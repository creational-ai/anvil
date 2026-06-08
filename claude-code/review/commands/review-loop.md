---
description: Additive exam/review critic-sandwich on a design or plan doc — N exams + N-1 reviews (default 2), ending on an exam (E1, R1, E2, …, E_N). Sequences the `/exam` and `/review-doc-run` methodologies (via their guides). Run in a top-level session (e.g. a session-agents builder pane) for full visibility.
argument-hint: <doc-path> [rounds] [notes]
disable-model-invocation: true
---

# /review-loop

Run an **additive exam → review → exam critic-sandwich** on a single document by sequencing the existing `/exam` and `/review-doc-run` behaviors. `rounds` = the number of NEW exam rounds this invocation (default **2**). The loop runs N exams interleaved with N-1 reviews and **always ends on an exam**: `E1, R1, E2, R2, …, E_N`.

> **Run this in a top-level session** — your main pane, or a session-agents `builder` pane (dispatch it with `comms no-reply builder -m "/review-loop <doc> <rounds>"`). It spawns subagents, which only works from a top-level session, never from inside another subagent. Both round types lean on **background** subagents, so the chat never blocks for long: an exam round is one background subagent (zero orchestrator turns until it finishes); a review round has *this* session spawn its background item+holistic fan-out and process each completion notification (brief foreground turns between which the chat is free). Watch progress in `/tasks` (live per-round status) and via the pane's own orchestration narration + per-round summaries when you `tmux attach -t <prefix>-builder`. Each subagent's full transcript also persists on disk for deep inspection.

## Input — parse `$ARGUMENTS`

- **doc-path** (required): the first token.
- **rounds** (optional): a bare integer ≥ 1. Default **2**. (`3` → `E1,R1,E2,R2,E3`; no value → `E1,R1,E2`.)
- **notes** (optional): any remaining text — pass it to each exam/review as focus context.

## Who owns each round (both use background subagents)

The split is **not** background-vs-foreground — both round types run on background subagents and neither blocks the chat for long. The difference is *who orchestrates the round*:

- **Exam = the whole round is delegated to one fresh subagent.** The examiner's value is *independence* — surfacing what the work is too close to see. A fresh background subagent (it reads the `-review.md` for continuity but carries none of this pane's reasoning) keeps E2/E3 honest after a review has run; this session does nothing until it completes.
- **Review = orchestrated from this session (background fan-out).** `/review-doc-run` fans out parallel item + holistic subagents, and a subagent can't spawn subagents — so the *spawn* must originate from *this* top-level session. The workers are still background (`run_in_background: true`); per `review-doc-run-guide.md` Phase 2-3 this session spawns them, ends its turn, and writes findings incrementally as each completion notification arrives. So it is non-blocking — just orchestrated here rather than delegated whole.

## Process

### 1. Pre-flight — additive numbering

The round labels are **not** fixed; they continue from whatever the shared review doc already holds.

1. Derive the review doc path: strip `.md` from doc-path, append `-review.md` (e.g. `docs/foo-design.md` → `docs/foo-design-review.md`).
2. Read it if it exists. Count the **E** columns and **R** columns in the item summary table header → `e0`, `r0`. If the doc does not exist, `e0 = r0 = 0`.
3. Compute the plan: for `i` in `1..rounds`: exam → `E(e0+i)`; and if `i < rounds`: review → `R(r0+i)`.
4. Announce the planned sequence, e.g. `pre-flight: 2 E / 1 R columns exist → planned: E3 → R2 → E4`.

### 2. Lay the sequence into the task list (TaskCreate — tracking, not execution)

`TaskCreate` does **not** run anything; it records a checklist. Use it to make the order explicit, visible in the pane, and resilient to mid-run compaction:

1. `TaskCreate` one task per planned round, in order — subject e.g. `review-loop E3 (exam)`, `review-loop R2 (review)`, `review-loop E4 (exam)`; description = the round's target column + doc path.
2. Chain them with `TaskUpdate addBlockedBy` so each round is blocked by the previous one (the sequence is the contract).
3. You execute each step yourself and move its task `pending → in_progress → completed` as you go. Never mark a round complete until its column is written and its fixes are applied.

### 3. Execute the rounds in order

For each planned round (set its task `in_progress` when you start, `completed` when its column is written and fixes applied):

> **Numbering is orchestrator-owned.** The labels computed in Pre-flight (step 1) are authoritative — the orchestrator (this session) did the one reliable column count before any round wrote, and rounds run strictly one at a time, so nothing else changes the columns mid-round. Hand each round its exact target column and **never let a round re-derive its own number by counting** — once an agent starts writing column `E{n}`, a recount includes its own write and mis-promotes it to `E{n+1}`. After each round returns, re-read the review-doc summary-table header and confirm **exactly one** new column was added, with the expected label. If a round wrote a different/extra column (e.g. both `E{n}` and `E{n+1}`), **STOP and report** — do not launch the next round onto a corrupted base.

**Exam round `E{n}`** — spawn a fresh subagent (Agent tool, `general-purpose`) **in the background (`run_in_background: true`)** so the chat/pane is never blocked, with this instruction:

> Perform an `/exam --auto` pass on `<doc-path>` by following `~/.claude/skills/review/references/exam-guide.md`'s **Review Mode** section exactly — you are executing the guide's methodology directly, not invoking the slash command. The guide is the full methodology — don't restate it. Apply these four orchestration constraints it doesn't cover:
> 1. **Column is assigned, not counted.** Write your findings under column **E{n}** — orchestrator-assigned and authoritative. Do NOT re-derive it by counting columns or bump to a higher number; if an `E{n}` column or partial `E{n}` entries already exist, resume that same column (counting after you start writing double-counts your own work).
> 2. **Timestamp from the clock.** Stamp the `E{n}` log + detail entries by running `date "+%Y-%m-%dT%H:%M:%S%z"` via Bash — never guess, round, or fabricate; reuse the one value everywhere in this round.
> 3. **Skip the afplay/say notification.**
> 4. **Return a structured summary:** the E column written, HIGH/MED/LOW counts, fixes applied (X of Y), one-line verdict. `<notes, if any>`

Because it runs in the background, **end your turn after launching it** — do not block. The completion notification re-invokes you with its summary; only then do the post-round header check above and move to the next round. The rounds stay strictly sequential (R{n} must see E{n}'s applied fixes), but the chat is free the whole time.

**Review round `R{n}`** — orchestrate it **from this session** (do not delegate the whole review to one subagent — it couldn't fan out). Read `~/.claude/skills/review/references/review-doc-run-guide.md` and follow it in `--auto` mode on `<doc-path>`: identify type, extract items, create/extend the skeleton with the **R{n}** column (write exactly the orchestrator-assigned `R{n}` — do NOT re-derive the number by counting; if an `R{n}` column already exists you are resuming it), spawn the parallel item + holistic reviewers **in the background per the guide's Phase 2 (`run_in_background: true`), end the turn, and write findings incrementally as each completion notification arrives (Phase 3)** — so the chat stays free while they run, run the elevation pass, set the review-log entry (timestamp it from `date "+%Y-%m-%dT%H:%M:%S%z"` — never guess), and apply ALL fixes. The round's task is complete only once the `R{n}` column is written and all fixes applied. **Skip the per-round afplay/say notification.** Pass `<notes>` as focus context. For non-parallel doc types (anything but Tasks / Task-Design / Plan, or zero items), the guide's own fallback to sequential `/review-doc` applies.

### 4. Report

Summarize to the pane:
- planned vs actual sequence (flag any label drift),
- per-round issue counts (HIGH/MED/LOW) and fixes applied,
- a final bottom-line verdict,
- the review-doc path.

Then play a single completion notification:

```bash
command -v afplay >/dev/null 2>&1 && afplay /System/Library/Sounds/Glass.aiff; command -v say >/dev/null 2>&1 && say "Review loop completed"
```

## Notes & limits

- **Context cost scales with rounds.** Each review's fan-out results land in this session's context. `rounds=2` is light; `rounds=4+` on a large doc may trigger mid-loop compaction — the TaskCreate checklist is your recovery anchor if it does. For very large unattended runs, the two-pane orchestration mesh keeps each review's fan-out out of one context.
- **Additive, per-invocation.** `rounds` is how many *new* exams to run now. Re-running on a doc that ended on an exam places two exams back-to-back across the boundary (e.g. `…E2` then `E3, R2, E4`) — expected.
