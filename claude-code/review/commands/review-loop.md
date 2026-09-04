---
description: Deep multi-round critic review of ONE design or plan doc — N independent exam rounds interleaved with N-1 fan-out review rounds (default 2 exams, 1 review), applying fixes as it goes and ending on an exam. Use when a design or plan needs harder scrutiny than a single `/review-doc` pass — before committing to a plan, after a doc has been revised and needs re-checking, or when asked to stress-test, deeply review, or really dig into a doc. Heavyweight: spawns many subagents and costs context. Requires a top-level session (main conversation or a session-agents pane) — a subagent cannot run it.
argument-hint: <doc-path> [rounds] [notes]
disable-model-invocation: false
---

# /review-loop

Run an **additive exam → review → exam critic-sandwich** on a single document by sequencing the existing `/exam` and `/review-doc-run` behaviors. `rounds` = the number of NEW exam rounds this invocation (default **2**). The loop runs N exams interleaved with N-1 reviews and **always ends on an exam**: `E1, R1, E2, R2, …, E_N`.

> **Orientation.** Both round types lean on **background** subagents, so the chat never blocks for long: an exam round is one background subagent (zero orchestrator turns until it finishes); a review round has *this* session spawn its background item+holistic fan-out and process each completion notification (brief foreground turns between which the chat is free). Watch progress via the pane's own orchestration narration + per-round summaries when you `tmux attach -t <prefix>-builder`. Each subagent's full transcript also persists on disk for deep inspection.

## 0. Eligibility — check this before anything else

This command **spawns subagents**, which only works from a top-level session. Establish that you are one **before** reading the target doc, writing the sequence file, or touching the review doc.

- **Eligible** — the main conversation, or a session-agents pane (`builder`, `QA`, `architect`, …). These are full sessions and can spawn.
- **NOT eligible** — you are a subagent: something spawned you with a task prompt instead of you running a session of your own. Subagents cannot spawn subagents, so **every round would fail**.

If you are not eligible, **STOP before writing anything** and delegate instead:

```bash
comms no-reply builder -m "/review-loop <doc-path> [rounds] [notes]"
```

Then report that you delegated and to whom. Do **not** start the rounds "as far as you can get" — a partial run leaves a half-written column in the shared review doc and a stale `/tmp/<slug>-loop-sequence.md`, and the next invocation's column count reads that wreckage as real progress.

If you are eligible but were invoked on your own initiative rather than by the operator, say so in one line before starting — this run costs real context and spawns many agents, and the operator should see it beginning.

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

### 2. Hold the sequence — in a file, and in the transcript

The plan from step 1 is the run's record of where you are. A column appears in the review doc only when a round **finishes**, so "mid-E3" and "E3 not yet started" are byte-identical on disk — the sequence state is the only thing that tells them apart, and it must outlive a compaction.

1. **Write it to `/tmp/<slug>-loop-sequence.md`** — `<slug>` is the target doc's basename minus `.md`. One line, rewritten in place whenever it changes (whole-file `Write` is safe here: the file accumulates nothing, so there is nothing to lose):

   ```
   sequence: E3 → R2 → E4 · next: E3 · in-flight: none
   ```

   `in-flight:` carries the label of a round that has been **launched and has not yet returned** (`in-flight: E3`), or `none`. Set it when you launch a round; clear it — and advance `next:` — only once that round's column is written and its fixes are applied.
2. **Emit the same line to the transcript** before the first round, and **re-emit it — unchanged except for `next:`/`in-flight:` — at the start of every round and immediately after every completion notification, including when nothing has changed.** A model skips a restatement it judges redundant, and the round where it feels most redundant is the round before the compaction that needs it.
3. **Recovering.** Read `/tmp/<slug>-loop-sequence.md` first, whether or not you think you remember the run — it is authoritative over both your memory and the transcript. Only if that file is *also* gone, re-derive the plan by counting E/R columns, and say in the final report that you did.
4. **Never relaunch a round that may already be running.** Counting columns cannot see an in-flight round, so a re-derived plan will happily relaunch one — and two concurrent `E{n}` rounds both write the **same** column, which the step-3 corruption check cannot catch (it only fires on a *different* or extra label). Before launching any round reached by re-derivation rather than by the file, state the label you are about to launch and confirm no round of that label is in flight; if you cannot rule it out, **STOP and report** rather than launch.
5. Delete `/tmp/<slug>-loop-sequence.md` after the final report is delivered. If the report could not be delivered, leave it and say where it is.

### 3. Execute the rounds in order

For each planned round (set `in-flight:` to its label when you launch it; clear `in-flight:` and advance `next:` only when its column is written and fixes applied):

> **Numbering is orchestrator-owned.** The labels computed in Pre-flight (step 1) are authoritative — the orchestrator (this session) did the one reliable column count before any round wrote, and rounds run strictly one at a time, so nothing else changes the columns mid-round. Hand each round its exact target column and **never let a round re-derive its own number by counting** — once an agent starts writing column `E{n}`, a recount includes its own write and mis-promotes it to `E{n+1}`. After each round returns, re-read the review-doc summary-table header and confirm **exactly one** new column was added, with the expected label. If a round wrote a different/extra column (e.g. both `E{n}` and `E{n+1}`), **STOP and report** — do not launch the next round onto a corrupted base.

**Exam round `E{n}`** — spawn a fresh subagent (Agent tool, `general-purpose`) **in the background (`run_in_background: true`)** so the chat/pane is never blocked, with this instruction:

> Perform an `/exam --auto` pass on `<doc-path>` by following `~/.claude/skills/review/references/exam-guide.md`'s **Review Mode** section exactly — you are executing the guide's methodology directly, not invoking the slash command. The guide is the full methodology — don't restate it. Apply these four orchestration constraints it doesn't cover:
> 1. **Column is assigned, not counted.** Write your findings under column **E{n}** — orchestrator-assigned and authoritative. Do NOT re-derive it by counting columns or bump to a higher number; if an `E{n}` column or partial `E{n}` entries already exist, resume that same column (counting after you start writing double-counts your own work).
> 2. **Timestamp from the clock.** Stamp the `E{n}` log + detail entries by running `date "+%Y-%m-%dT%H:%M:%S%z"` via Bash — never guess, round, or fabricate; reuse the one value everywhere in this round.
> 3. **Skip the afplay/say notification.**
> 4. **Return a structured summary:** the E column written, HIGH/MED/LOW counts, fixes applied (X of Y), one-line verdict. `<notes, if any>`

Because it runs in the background, **end your turn after launching it** — do not block. The completion notification re-invokes you with its summary; only then do the post-round header check above and move to the next round. The rounds stay strictly sequential (R{n} must see E{n}'s applied fixes), but the chat is free the whole time.

**Review round `R{n}`** — orchestrate it **from this session** (do not delegate the whole review to one subagent — it couldn't fan out). Read `~/.claude/skills/review/references/review-doc-run-guide.md` and follow it in `--auto` mode on `<doc-path>`: identify type, extract items, create/extend the skeleton with the **R{n}** column (write exactly the orchestrator-assigned `R{n}` — do NOT re-derive the number by counting; if an `R{n}` column already exists you are resuming it), spawn the parallel item + holistic reviewers **in the background per the guide's Phase 2 (`run_in_background: true`), end the turn, and write findings incrementally as each completion notification arrives (Phase 3)** — so the chat stays free while they run, run the elevation pass, set the review-log entry (timestamp it from `date "+%Y-%m-%dT%H:%M:%S%z"` — never guess), and apply ALL fixes. The round is complete only once the `R{n}` column is written and all fixes applied. **Skip the per-round afplay/say notification.** Pass `<notes>` as focus context. For non-parallel doc types (anything but Tasks / Task-Design / Plan, or zero items), the guide's own fallback to sequential `/review-doc` applies.

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

- **Context cost scales with rounds.** Each review's fan-out results land in this session's context. `rounds=2` is light; `rounds=4+` on a large doc may trigger mid-loop compaction — `/tmp/<slug>-loop-sequence.md` is your recovery anchor if it does, with the re-emitted `sequence:` line as the in-context copy; if both are gone, re-derive by counting E/R columns under the never-relaunch rule in § 2. For very large unattended runs, the two-pane orchestration mesh keeps each review's fan-out out of one context.
- **Additive, per-invocation.** `rounds` is how many *new* exams to run now. Re-running on a doc that ended on an exam places two exams back-to-back across the boundary (e.g. `…E2` then `E3, R2, E4`) — expected.
