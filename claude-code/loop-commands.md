# Loop Commands

Map of every loop command in this project, classified by the variants in [`~/Development/docs/claude-code/long-running-loops.md`](file:///Users/docchang/Development/docs/claude-code/long-running-loops.md). Read that guide first — this doc is the local index, not the pattern reference.

**Last Updated:** 2026-04-24

---

## Summary

Six commands. Three variants. Two skills (`review`, `dev`).

| Command | Skill | Variant | Trigger | Coordinates with |
|---------|-------|---------|---------|------------------|
| [`/monitor`](#monitor) | review | A — tick-driven | Bash sleep 120s | (none — observes execution) |
| [`/exam-loop`](#exam-loop) | review | A — tick-driven | Bash sleep 240s | `/review-doc-loop` (paired session) |
| [`/review-doc-loop`](#review-doc-loop) | review | A + B hybrid | Bash sleep 240s (outer) + Task notifications (inner) | `/exam-loop` (paired session) |
| [`/review-doc-run`](#review-doc-run) | review | B — notification-driven | Task completion notifications | (subagents fan out and rejoin) |
| [`/dev-review-run`](#dev-review-run) | dev | B — notification-driven | Task completion notifications | (subagents fan out and rejoin) |
| [`/dev-execute-run`](#dev-execute-run) | dev | C — sequential orchestrator | Synchronous Task per step | (delegates each step to a fresh `dev-executor`) |

**Variant legend** (per the canonical guide):
- **A**: tick-driven loop — periodic Bash echo wakes the main conversation; encode state in the echo string for compaction immunity.
- **B**: notification-driven scatter-gather — N background subagents spawned in one message; main conv processes completion notifications as they arrive.
- **C**: sequential orchestrator — main conv spawns one subagent at a time synchronously, stop-on-failure.

---

## `/monitor`

**Variant**: A (tick-driven)
**Source**: [`review/commands/monitor.md`](file:///Users/docchang/Development/anvil/claude-code/review/commands/monitor.md), [`review/references/exam-guide.md`](file:///Users/docchang/Development/anvil/claude-code/review/references/exam-guide.md) § Monitor Mode

Single-side periodic observation of an in-flight execution. Reads results / plan / design / review docs every 2 minutes, reports status, and runs per-step analysis when a step transitions to Complete. Strictly read-only except for its own issue log.

**State**: Observable in the source docs (results, plan, etc.). Echo state is minimal — the loop is single-side so there's no counterpart to coordinate with; just the tick cadence and idle counter need to survive between turns.

**Termination**:
- All plan steps complete → final summary + stop.
- User says stop → acknowledge + stop.
- 8 consecutive idle ticks (~16 min at 2-min cadence) → ask user whether to continue.

**Side effects**: Lazy-creates `docs/[slug]-monitor-issues.md` on first verifiable issue. Append-only across sessions. Never edits source docs.

**Why variant A**: the work IS the periodic observation. No fan-out, no per-step subagent. One main-conv loop reading state at a fixed cadence.

---

## `/exam-loop`

**Variant**: A (tick-driven)
**Source**: [`review/commands/exam-loop.md`](file:///Users/docchang/Development/anvil/claude-code/review/commands/exam-loop.md), [`review/references/review-loop-guide.md`](file:///Users/docchang/Development/anvil/claude-code/review/references/review-loop-guide.md) (canonical)

Tick-driven critic loop. On each tick wake, parse echo state, re-read the shared review doc, evaluate the gate, and either run a single-turn exam round inline or arm the next timer. Coordinates with `/review-doc-loop` via the shared review doc.

**State** (encoded in echo suffix):
```
(idle X/4, last_sig=rD,eD,rT,eT,rS,eS, entry=r0,e0, target=N, role=leader|follower)
```

The 6-tuple `last_sig` is the load-bearing split — `(rD, eD)` gates round progression, all six elements feed idle reset. See the canonical guide § "Why done vs total+step (split counters)".

**Round body**: single-turn. Follow `exam-guide.md` § Review Mode in full (Read Review Doc, Read Target, Load Cross-Refs, Deep Examination, Codebase Verification, Write to Review Doc, Applying Fixes, Update Fix Status, Completion Notification) **inline**. Do NOT invoke `/exam` via the Skill tool.

**Termination** (3 conditions):
1. `rounds_done >= target_rounds` — `completed N rounds, stopping`.
2. 4 consecutive idle ticks AND counterpart progressed at least once this invocation — `no change in review doc for 4 ticks (~16 minutes), stopping`.
3. 4 consecutive idle ticks AND counterpart progressed zero times — `counterpart never started, stopping`.

**Default role**: leader. Default N: 2. Pairs with `/review-doc-loop` follower N=1 to produce the critic-sandwich (E1 → R1 → E2).

**Critical gotcha**: the `disable-model-invocation: true` flag on `/exam` is load-bearing for loop reliability — it forces fallback to inline execution if a post-compaction agent reaches for `Skill(/exam)`. Full rationale in [`docs/review-loop-exam-inline-design.md`](file:///Users/docchang/Development/anvil/docs/review-loop-exam-inline-design.md).

---

## `/review-doc-loop`

**Variant**: A + B hybrid
**Source**: [`review/commands/review-doc-loop.md`](file:///Users/docchang/Development/anvil/claude-code/review/commands/review-doc-loop.md), [`review/references/review-loop-guide.md`](file:///Users/docchang/Development/anvil/claude-code/review/references/review-loop-guide.md) (canonical)

Tick-driven outer loop with the same echo, gate, and termination semantics as `/exam-loop`. The **inner round body is variant B** — each round runs the multi-turn `/review-doc-run` flow (Phase 1 setup → Phase 2 fan-out → Phase 3 notification processing → Phase 3.6 completion sound).

**Outer state** (echo suffix): identical to `/exam-loop` — same 6-tuple sig, same role/target fields.

**Inner state** (during the multi-turn round): no idle ticks fire. The loop is **dormant** between Phase 1 start and Phase 3.6 end. The next tick is armed by Continuation logic in the same turn as Phase 3.6 (see canonical guide § "Continuation-turn handoff").

**Compaction defense**:
- **Outer (idle sleep)**: echo state is compaction-immune by construction — the future `tool_result` postdates any compaction summary.
- **Inner (Phase 2/3 multi-turn)**: arm a **pre-round sentinel** (`sleep 1 && echo 'Running /review-doc-loop [sentinel] ... '`) in the same single message as Phase 2's Task spawns. Sentinel is **compaction-tolerant**, not immune. If both the loop awareness and the sentinel are erased, the loop silently exits at end-of-Phase-3 (terminal failure mode — acceptable, no data corruption). See canonical guide § "Mid-round compaction recovery".

**Termination**: same 3 conditions as `/exam-loop`.

**Default role**: follower. Default N: 1. Pairs with `/exam-loop` leader N=2 (default critic-sandwich).

**Why hybrid**: the round body is a pre-existing multi-turn variant-B flow (`/review-doc-run`). Wrapping it in a tick-driven outer loop required no edits to the inner flow — the loop guide augments Phase 2 with one extra Bash call (the sentinel) and re-frames Phase 3.6's turn-end as a Continuation handoff. The inner guide (`review-doc-run-guide.md`) is textually unmodified.

---

## `/review-doc-run`

**Variant**: B (notification-driven scatter-gather)
**Source**: [`review/commands/review-doc-run.md`](file:///Users/docchang/Development/anvil/claude-code/review/commands/review-doc-run.md), [`review/references/review-doc-run-guide.md`](file:///Users/docchang/Development/anvil/claude-code/review/references/review-doc-run-guide.md)

Single-pass parallel review. Phase 2 spawns N item-reviewer agents + 1 holistic-reviewer in **a single message** with `run_in_background: true`. Phase 3 processes completion notifications as they arrive, writing each agent's result directly into the review doc.

**State**: lives in the review doc. Each agent's notification triggers an immediate Edit. The main conv doesn't try to collect results in memory — the file is the merge buffer.

**Phase shape**:
1. Phase 1 (single turn): setup, write skeleton review doc with `...` cells.
2. Phase 2 (single message): N+1 Task spawns + brief status text. End turn.
3. Phase 3 (multi-turn): notifications arrive one at a time; for each, edit the review doc immediately. After all agents reported, run elevation/log-write/auto-fix/status-update/completion-notification.

**Termination**: implicit. When the last agent's notification has been processed and Phase 3 post-processing completes, the turn ends.

**Why variant B**: the work fans out — one item per item-agent, plus one holistic agent — and rejoins in the review doc. No tick-driven coordination needed; the notifications themselves drive re-entry.

**Loop-mode override**: when invoked from inside `/review-doc-loop`, two convention overrides apply (per canonical guide § "Fix-application under the loop"):
- Phase 3.4 takes the `--auto` branch implicitly (no user prompt).
- Phase 2 emits one extra Bash call alongside the Task spawns (the pre-round sentinel for compaction recovery).

Standalone invocation (no loop) does NOT apply these overrides.

---

## `/dev-review-run`

**Variant**: B (notification-driven scatter-gather)
**Source**: [`dev/commands/dev-review-run.md`](file:///Users/docchang/Development/anvil/claude-code/dev/commands/dev-review-run.md)

Per-step conceptual review of a completed task. Spawns one `dev-reviewer` agent per completed step in a single background message; merges each agent's review block into the results doc as the notification arrives.

**State**: lives in the results doc. Each notification triggers an immediate Edit to insert the review block into the matching step section.

**Phase shape**:
1. Setup (single turn): identify completed steps from results doc, find plan doc, extract Risk Profile.
2. Spawn (single message): N background `dev-reviewer` Tasks (one per completed step) with `--report-only`.
3. Merge (multi-turn): per notification, extract review block + insert into results.md. Report PASS/FLAG to user.
4. Summary (final turn): update `Reviewed` timestamp in summary table; print review summary.

**Termination**: implicit, same as `/review-doc-run` — after all notifications processed and summary printed.

**Why variant B**: same fan-out-rejoin shape as `/review-doc-run`, just on a different doc family (results.md instead of review.md) and with a different agent type (`dev-reviewer` instead of `item-reviewer`/`holistic-reviewer`).

**Difference from `/review-doc-run`**: smaller scale (one agent per step, not per item), reviews implementation against design rather than reviewing the doc itself, no holistic-reviewer companion. Otherwise structurally identical variant-B pattern.

---

## `/dev-execute-run`

**Variant**: C (sequential orchestrator)
**Source**: [`dev/commands/dev-execute-run.md`](file:///Users/docchang/Development/anvil/claude-code/dev/commands/dev-execute-run.md)

Loops through plan steps in order, spawning a fresh `dev-executor` subagent per step **synchronously** (no `run_in_background`). Stop-on-failure. The orchestrator is intentionally "dumb" — it spawns agents in order and never makes content decisions.

**State**: lives in the plan and results docs. The orchestrator parses step IDs from the plan, reads results.md to find current progress, then spawns agents one by one. Each subagent updates results.md before reporting back.

**Loop body**:
```
For each step in plan (in order):
  Spawn dev-executor (synchronous)  ← blocks the main conv until this agent finishes
  If failure: STOP (do not continue to next step)
  If success: continue
End: spawn dev-finalizer.
```

**Why synchronous (not run_in_background)**: stop-on-failure ordering matters. The orchestrator can't decide whether to spawn step N+1 until step N's agent returns. Background spawns would race ahead and corrupt sequencing.

**Termination**:
- All steps complete → spawn `dev-finalizer`, report.
- Any step fails → stop, print recovery instructions.
- (Optional `--auto`) → after finalizer, run `/dev-review-run` inline + spawn `mc-update-agent`.

**Why variant C** (not B): each step's work is large and self-contained — fresh-context subagents avoid inter-step contamination. And ordering is load-bearing (step N+1 may depend on step N's side effects, e.g., file writes). Variant B would race; variant A's tick cadence would be wasteful (you don't need to poll — the agent tells you when it's done).

**Critical rule**: the orchestrator NEVER skips steps based on its own judgment. Even if a step looks already done, delegate it anyway — only the executor can determine completion. Skipping would corrupt the results doc.

---

## Cross-cutting notes

### Why these are separate variants

- **A vs B**: A polls; B reacts to notifications. Use A when state lives in an external file that changes asynchronously (another session, a long-running process). Use B when state lives in subagents you spawned and you want to merge their results.
- **B vs C**: B fans out and rejoins in parallel; C is strictly sequential. Use C when ordering matters or stop-on-failure is required.
- **A + B hybrid (`/review-doc-loop`)**: the outer loop uses A (tick-driven, encoded state, compaction-immune); each round of work uses B (parallel scatter-gather). Hybrids work when the inner round is itself a complete multi-turn workflow.

### Skill split

- The **review** skill owns variant A and most of variant B (`/monitor`, `/exam-loop`, `/review-doc-loop`, `/review-doc-run`). Its canonical reference is `review-loop-guide.md`.
- The **dev** skill owns variant C and one variant B instance (`/dev-execute-run`, `/dev-review-run`). The patterns are described inline in each command file — there is no shared dev-side loop guide because the variants don't compose (one is parallel, one is sequential).

### When to add another loop command

Before adding a new loop command, decide which variant it is:

- Polling external state on a fixed cadence → **A**.
- Fanning out parallel subagents and rejoining → **B**.
- Sequencing per-step subagents with ordering and stop-on-failure → **C**.
- Multi-turn round inside a tick-driven outer loop → **A + B hybrid**.

If your design doesn't fit one of these (or a clear hybrid), it may be a sign that the work belongs inside a single subagent rather than as a long-running main-conv loop. Re-check the "When NOT to use" section of the canonical guide before building.

### Test the failure modes, not just the success path

For every loop you add, verify:
- **Compaction during idle** (variant A): does the next tick recover state from the echo?
- **Compaction during round body** (variant A + B hybrid): does the sentinel let you recover, or do you silently exit cleanly?
- **No timer armed on exit** (variant A): zombie ticks are a real failure mode.
- **Stop-on-failure works** (variant C): does the orchestrator actually stop when the agent reports failure, or does it skip to the next step?
- **Notification ordering** (variant B): does merging Edit-by-notification produce a consistent doc when notifications arrive out of order?
