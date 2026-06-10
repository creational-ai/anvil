---
description: Triangulated deep review of a design or plan doc — runs the review-loop workflow while independent read-only subagents ground every claim against the repo and adversarially validate the chosen path (web-verified), then cross-references all lanes and consolidates one verdict.
disable-model-invocation: true
argument-hint: <docs/<slug>-design.md | docs/<slug>-plan.md> [rounds] [notes]
---

# /review-triangulate

Run a multi-lane, cross-validated review of a single design or plan doc. Three independent measurement lanes — the review-loop workflow (critic sandwich), repo-grounding subagents, and path-correctness subagents — examine the same doc concurrently; findings that converge across lanes are high-confidence, findings unique to one lane get scrutiny before they ship. This command is the explicit user opt-in for the Workflow tool and background subagents.

> **Run this in a top-level session** — your main pane, or a session-agents `builder` pane. It launches a Workflow and spawns background subagents, which only works from a top-level session, never from inside another subagent.

## Input — parse `$ARGUMENTS`

- **doc-path** (required): the first token; exactly one path. Detect design vs plan from the `-design.md` / `-plan.md` suffix.
- **rounds** (optional): a bare integer ≥ 1 — how many NEW exam rounds the review-loop workflow runs. Omitted → the workflow's default (2).
- **notes** (optional): any remaining text — focus context, threaded into the workflow AND every subagent lane ("weight findings toward this; do NOT let it narrow required coverage").

## Hard rules (apply for the entire run)

1. **Subagents are read-only.** Every Agent prompt MUST open with: "You are read-only. DO NOT modify, create, or write any files — report findings only." Only the workflow (and later, you) writes.
2. **Never edit the target doc or its `-review.md` while the workflow is running** — the workflow applies its own fixes; concurrent edits collide. Hold all your edits for the consolidation phase.
3. **Don't poll — and don't idle.** Workflow and background agents notify on completion. Between notifications, launch the next lane (first-order menu, then second-order once it's exhausted) or — only when no lane adds value right now — say so in one line, then end the turn. There is no lane cap: the loop keeps spawning until the workflow completes.
4. **Evidence discipline.** Every grounding claim cites `file:line`. Every external-platform claim (SDK semantics, API behavior, policy) cites a current official URL. No finding ships on memory alone.

## Phase 1 — Launch (one parallel block)

Read the target doc fully first (and its existing `-review.md` if present — know what prior exams already found; don't re-discover known issues). Snapshot a launch-time baseline for the second-order re-grounding lane: `cp <doc> /tmp/<slug>-launch-baseline.md` — your in-context read won't survive compaction; record the baseline path in the anchor task's metadata.

Then launch in a single message:

1. **Workflow**: `Workflow({name: "review-loop", args: {doc: "<target-doc-path>", rounds: <rounds>, notes: "<notes>"}})` — omit `rounds`/`notes` keys when not given (bare-path shorthand `args: "<target-doc-path>"` is equivalent when both are absent)
2. **Grounding agent** (general-purpose, background, read-only): enumerate every checkable factual claim in the doc — file paths, line numbers, versions, class/method names, config values, architectural assertions ("X is instantiated in Y", "Z has no callers") — and verify each against the repo. Output: a Claim | Verdict (CONFIRMED/WRONG/PARTIAL/UNVERIFIABLE) | Evidence(file:line) table, then a list of stale/overclaimed statements and grounding gaps. Give the agent the project root, the doc path, and an explicit numbered list of the doc's most load-bearing claims so it can't skip them.
3. **Path-correctness agent** (general-purpose, background, read-only, web): adversarial architecture review — is the chosen approach correct per CURRENT official documentation? Extract the doc's 4-7 most load-bearing technical assumptions, instruct the agent to challenge each with web research against primary sources, and require per-question verdicts (CONFIRMED/WRONG/NUANCED) with URLs plus an overall PATH CORRECT / CORRECT WITH CAVEATS / WRONG verdict. Tell it to be adversarial: "your job is to find the flaw before production does."

If `notes` were given, append them to every subagent prompt (Phase 1 and Phase 2) as focus context: "Operator focus context (weight findings toward this; do NOT let it narrow required coverage): <notes>".

Immediately after the launch block, **TaskCreate the consolidation anchor** (compaction insurance — long multi-agent runs routinely outlive the context window, and the task list survives compaction when the conversation doesn't):

- **subject**: `Consolidate triangulated review of <doc> — convergence map, apply fixes, final report`
- **description** must be self-sufficient to execute Phase 3 from scratch after a full compaction. Include: (a) the target doc path and its `-review.md` path; (b) the workflow run ID + task ID and every launched agent's task ID with its dimension label; (c) the full Phase 3 procedure (read final `-review.md` → build CONVERGED / WORKFLOW-ONLY / SUBAGENT-ONLY convergence map → apply only fixes the workflow didn't already apply → final report leading with the verdict); (d) the standing constraints (no doc edits until the workflow completes; do NOT shell-Read agent `.output` JSONL files — results arrive in task-notifications); (e) any role constraints in effect.
- **As each lane completes, TaskUpdate the anchor task's `metadata`** with that lane's condensed findings (one key per lane, e.g. `groundingFindings`, `pathFindings`): verdicts, file:line evidence for the load-bearing items, and the fix-worthy deltas. Condense hard — carry what Phase 3 needs to act, not the full report. This is the run's persistent memory; write it as if the conversation will be gone.

Also **TaskCreate the Phase-2 loop driver** (the loop's own forget-insurance — the anchor only protects Phase 3):

- **subject**: `[loop-driver] Keep launching review lanes on <doc> until workflow <run-id> completes`
- **description**: "While workflow <run-id> is still running: every completed-agent notification and every free turn MUST end with either a new lane launched (first-order menu, then second-order menu when first-order is exhausted — see /review-triangulate Phase 2) or an explicit one-line statement of why no lane adds value right now. Never idle-wait on the workflow. Complete this task ONLY when the workflow's completion notification arrives — then proceed to the consolidation anchor."
- Mark it `in_progress` immediately (it is live the whole of Phase 2). On the workflow's completion notification: mark it `completed` and start Phase 3.

## Phase 2 — Keep looping until the workflow finishes

Each time an agent completes (or you have a free turn), launch the next agent on an **uncovered dimension**. Pick from this **first-order menu** based on what the doc touches (typically 2-4 of these fit a doc; scale to doc size and risk — that's coverage guidance, NOT a stop condition; when this menu is exhausted the loop continues into the second-order menu below, until the workflow completes):

- **Call-chain / choke-point trace** — when the doc gates, reorders, or hooks an existing runtime flow: trace the actual init/call chain with file:line, find the narrowest insertion point, list bypass paths and never-ran safety.
- **Testability / environment-behavior audit** — are the doc's planned tests writable in the house test patterns? How do the involved SDKs behave in the editor/CI environment (stubs? throws?)? Does the dev loop need a bypass?
- **Dependency / namespace / portability audit** — verify every dependency the proposed code needs (actual namespaces, locations, which side of a library boundary they live on); check claimed reusability/agnosticism against the real dependency graph, with an existing class as the precedent.
- **Sibling-doc interaction audit** — read the sibling/predecessor docs the target references; verify the claimed interactions and non-interactions still hold against both the docs and the source.
- **Data/analytics impact audit** — when the doc changes event flows: what rows change in the warehouse, which dashboards/queries break, what new states need instrumentation.

Report each completed agent's headline findings to the user in 2-4 sentences as they land (lead with what changed your assessment), and **TaskUpdate the anchor task's metadata with that lane's condensed findings before doing anything else** — if compaction strikes mid-run, an unlogged lane is a lost lane. Do NOT fix the doc yet.

### When the first-order menu is exhausted but the workflow is still running

The loop does NOT stop — switch to **second-order lanes**, which work the completed lanes' output instead of the doc's untouched dimensions (still read-only, still background):

- **Fix-shape verification** — take each MUST-FIX finding from completed lanes and research the precise correction (exact API composition, exact code shape, primary-source citations) so Phase 3's edits are surgical rather than directional. The highest-value second-order lane: a verified fix beats a verified flaw.
- **Blast-radius sweep** — for each disproven claim, enumerate every OTHER artifact stating the same claim (sibling docs, the design twin, reference docs, knowledge files, code comments) with file:line — Phase 3 fixes the family, not just the target doc.
- **Cross-lane contradiction hunt** — feed the completed lanes' verdicts to an agent that hunts for findings that contradict each other or rest on incompatible assumptions; contradictions get re-verified before consolidation treats both as true.
- **Completeness critic** — "what's missing: which doc claim did NO lane verify, which dimension was skipped and why does that matter, which acceptance criterion is unverifiable as written?" Its output is either reassurance or the next lane's prompt.
- **Re-ground the workflow's mid-run edits** — the workflow applies fixes to the target doc as it goes (reading the doc is safe; only WRITING is forbidden). Diff the current doc state against the launch-time baseline snapshot (path in the anchor metadata) and spot-check that the workflow's applied fixes don't contradict completed-lane evidence; contradictions become Phase 3 items.

Each second-order lane logs to the anchor metadata like any other (e.g. `fixShapeFindings`, `blastRadiusFindings`). If genuinely nothing remains worth verifying (rare — say so explicitly in one line), end the turn; the loop-driver task still requires that explicit statement rather than silent idling.

## Phase 3 — Consolidate (after the workflow completes)

Mark the anchor task `in_progress`. If the conversation was compacted, the anchor task's description + metadata ARE the run state — reconstruct from them, not from memory.

1. Read the final `-review.md` (the workflow's E/R columns) and the workflow's return value. Check its `status` (`ok | degraded | drifted | aborted`): `drifted`/`aborted` means the workflow STOPPED mid-sequence — lead the final report with that, treat E/R columns from the stop point onward as absent or suspect, and weight the convergence map toward the subagent lanes; `degraded` means a review round ran with failed reviewers — its R column under-reports.
2. Build the **convergence map**: for every distinct finding across all lanes, classify it —
   - **CONVERGED** (workflow + ≥1 subagent found it): highest confidence, fix without debate.
   - **WORKFLOW-ONLY**: verify against subagent evidence before accepting; the workflow may lack repo grounding.
   - **SUBAGENT-ONLY**: the workflow missed it; verify the citation yourself (spot-check one file:line per finding), then fix.
3. Apply the consolidated fixes the workflow didn't already apply to the target doc (the workflow has finished — edits are safe now). Respect the doc's existing structure; date-stamp substantive corrections.
4. Deliver the final report: overall verdict (lead with it), the convergence map (table), fixes applied vs. residual plan-time items, and any finding that changes the task's risk profile. If any lane found the path WRONG, say so first and stop short of fixes until the user weighs in.
5. Mark the anchor task `completed`.
6. Play a single completion notification:

```bash
command -v afplay >/dev/null 2>&1 && afplay /System/Library/Sounds/Glass.aiff; command -v say >/dev/null 2>&1 && say "Review triangulate completed"
```
