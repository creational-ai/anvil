---
description: Triangulated deep review of a design or plan doc — runs the review-loop workflow while independent read-only subagents ground every claim against the repo and adversarially validate the chosen path (web-verified), plus, when the doc's claims are runtime-testable, empirical probe lanes that demonstrate behavior instead of citing it, then cross-references all lanes and consolidates one verdict.
disable-model-invocation: true
argument-hint: <docs/<slug>-design.md | docs/<slug>-plan.md> [rounds] [notes]
---

# /review-triangulate

Run a multi-lane, cross-validated review of a single design or plan doc. Three independent measurement lanes — the review-loop workflow (critic sandwich), repo-grounding subagents, and path-correctness subagents — examine the same doc concurrently; plus, when the doc's claims are runtime-testable, empirical **probe lanes** demonstrate the behavior instead of citing it. Findings that converge across lanes are high-confidence, findings unique to one lane get scrutiny before they ship. This command is the explicit user opt-in for the Workflow tool and background subagents.

> **Run this in a top-level session** — your main pane, or a session-agents `builder` pane. It launches a Workflow and spawns background subagents, which only works from a top-level session, never from inside another subagent.

## Input — parse `$ARGUMENTS`

- **doc-path** (required): the first token; exactly one path. Detect design vs plan from the `-design.md` / `-plan.md` suffix.
- **rounds** (optional): a bare integer ≥ 1 — how many NEW exam rounds the review-loop workflow runs. Omitted → the workflow's default (2).
- **notes** (optional): any remaining text — focus context, threaded into the workflow AND every subagent lane ("weight findings toward this; do NOT let it narrow required coverage").

## Hard rules (apply for the entire run)

1. **Subagents are read-only — except probe lanes.** Every grounding, path-correctness, and non-probe menu Agent prompt MUST open with: "You are read-only. DO NOT modify, create, or write any files — report findings only." **Exception — probe lanes are execute-but-don't-write:** they MAY run non-destructive commands and write scratch only under `/tmp/<slug>-probes/`; they MUST NOT modify repo files, installed tools, global config, or shared state. A probe prompt does NOT carry the read-only opener (it is allowed to execute); it opens instead with the verbatim safety-constraint block from the **Empirical probe / doubt-removal** first-order menu entry. Only the workflow (and later, you) writes **to tracked files**.
2. **Never edit the target doc or its `-review.md` while the workflow is running** — the workflow applies its own fixes; concurrent edits collide. Hold all your edits for the consolidation phase.
3. **Don't poll — and don't idle.** Workflow and background agents notify on completion. Between notifications, launch the next lane (first-order menu, then second-order once it's exhausted) or — only when no lane adds value right now — say so in one line, then end the turn. There is no lane cap: the loop keeps spawning until the workflow completes. **Model parity:** never pass a `model` override when spawning a lane — lanes inherit this session's model, the same inheritance the review-loop workflow's agents use, so every lane and every workflow agent runs on the model of the session that invoked this command.
4. **Evidence discipline.** Every grounding claim cites `file:line`. Every external-platform claim (SDK semantics, API behavior, policy) cites a current official URL. Every probe claim cites the exact command run and its literal output. No finding ships on memory alone.
5. **Demonstration outranks citation.** When a probe verdict (DEMONSTRATED/REFUTED, carrying the exact command and literal output) conflicts with a citation-grounded verdict — web, memory, or repo `file:line` — about runtime behavior, the probe wins. Code and docs describe; execution proves. (Precedent, 2026-06-09: citation lanes returned "VERIFIED FALSE — no such command"; a 5-second bare run printed `Usage: claude stop <id>` — the docs were the defect.) **Scope:** this rule covers `file:line` citations *for runtime-behavior claims* only; for claims about what the source *says*, `file:line` remains authoritative and no probe applies.

## Phase 1 — Launch (one parallel block)

Read the target doc fully first (and its existing `-review.md` if present — know what prior exams already found; don't re-discover known issues). Snapshot a launch-time baseline for the second-order re-grounding lane: `cp <doc> /tmp/<slug>-launch-baseline.md` — your in-context read won't survive compaction. `<slug>` is the target doc's basename minus `.md` — the same slug the probe scratch dir and the run file use, so a design run and a plan run on the same task never share scratch.

While reading, **classify each load-bearing claim TESTABLE vs CITE-ONLY** (zero added cost — tag them during the same load-bearing-claim enumeration the grounding lane already receives below). A claim is **TESTABLE** when its truth is demonstrable by a safe, non-destructive command in *this* environment: CLI verbs/flags/exit codes, output formats, parse behavior, env-var effects, version checks, timing bounds. Everything else is **CITE-ONLY** (settled by `file:line` or a web source, never by running anything). This classification sets the applicability gate:

- **≥2 load-bearing TESTABLE claims** → record `probes: in-play` — the **Empirical probe / doubt-removal** first-order lane joins the menu and the second-order probe lanes (**Probe-the-contradiction**, **Probe-the-fix**) become available.
- **Exactly 1** → record `probes: spot-check (claim: <claim text>)` — the record carries the claim text itself so a post-compaction Phase-3 agent can run the spot-check without re-reading the doc. Spot-check ⇒ **no Phase-2 probe lanes spawn**; the only probe activity is the Phase-3 inline check.
- **0** → record `probes: N/A (reason)` — the probe lane class is skipped everywhere; the run behaves exactly as a pure-prose review.

Record the chosen state in the run file's **Probe gate** section (written below, before the launch block).

**Gate upgrade**: if a completed lane later surfaces a runtime-testable doubt while the gate is `N/A` or `spot-check`, you MAY update the record to `probes: upgraded-in-play (was: <prior state>; trigger: <lane finding>)` — preserve the prior state verbatim (an upgrade from `spot-check` must not lose its claim text; that carried spot-check claim is fed to the first probe lane launched after the upgrade).

**Phase-1 launch exception**: probes are normally Phase-2 doubt-fed lanes, but when the Phase-1 read itself surfaces TESTABLE claims no planned lane will otherwise verify, the first probe lane MAY launch in the Phase-1 block alongside the original three. This exception applies **only when the gate recorded `probes: in-play`** — under `spot-check` the only probe activity remains the Phase-3 inline check.

### Write the run file — before you launch anything

The run's durable state lives at `/tmp/<slug>-triangulate-run.md` — the only thing that survives a compaction. Create it now, before the launch block, after the baseline `cp` and the gate classification.

**If a file is already there** (a prior run on the same slug): `mv` it to `/tmp/<slug>-triangulate-run.abandoned-<its Started value>.md`, tell the operator in one line, and create fresh. **Never overwrite, never halt** — no flag, no branch, no boolean to get wrong.

Write it once, whole, with `Write`. This is the entire schema:

````markdown
# Triangulate run: <slug>

| Field | Value |
|-------|-------|
| **Command** | `~/.claude/commands/review-triangulate.md` — **re-read it if you are recovering: this file carries the run's data, not its procedure** |
| **Target doc** | <doc-path> |
| **Review doc** | <doc-path minus .md>-review.md |
| **Baseline** | /tmp/<slug>-launch-baseline.md |
| **Started** | <ISO 8601 from `date "+%Y-%m-%dT%H:%M:%S%z"`> |
| **Workflow run** | <run-id> · running \| ok \| degraded \| drifted \| aborted |
| **Probe gate** | in-play \| spot-check \| N/A \| upgraded-in-play |
| **Pending ack** | <sender> \| none |

## Probe gate

<the gate line verbatim: `probes: in-play` / `probes: spot-check (claim: …)` / `probes: N/A (reason)` / `probes: upgraded-in-play (was: …; trigger: …)`>

Carried claim text — reproduce byte-for-byte, never re-wrap, never paraphrase:

```text
<verbatim claim text — spot-check and any upgrade from spot-check only>
```

## Standing constraints

- No edits to the target doc or its `-review.md` while the workflow is running.
- Do NOT shell-Read agent `.output` JSONL files — results arrive in task-notifications.
- <any role constraints in effect, including a pending ack owed to a dispatching pane>
- If the `## Lane log` below is empty but the report needs lanes, check `/tmp/<slug>-triangulate-run.abandoned-*.md` — a post-compaction re-entry at Phase 1 moves the live log aside and starts fresh, so this run's landed lanes may be in the sibling.

## Lane log

**Loop rule** — while the workflow is running, every turn ends with either a new lane launched or a one-line statement of why no lane adds value right now. Never idle-wait. A turn that launches nothing appends `### idle · <ts> · <one-line reason>` here — that append is what forces you to open this file on a turn with no lane landing, and it is what the Phase-3 ledger counts.

Append-only. Newest at the bottom. Never edit or delete an existing block.
````

**Read it back once.** When the gate is `spot-check` or an upgrade from one, re-read the file and confirm the fenced claim matches character-for-character. Phase 3 runs that claim cold; a mangled quote means the spot-check tests the wrong thing while the report claims doubt-removal it did not earn. Nothing else is verified, deliberately: append-only removes the silent-loss class, not the silent-wrongness class — a block written under the wrong key will not be flagged.


Then launch in a single message:

1. **Workflow**: `Workflow({name: "review-loop", args: {doc: "<target-doc-path>", rounds: <rounds>, notes: "<notes>"}})` — omit `rounds`/`notes` keys when not given (bare-path shorthand `args: "<target-doc-path>"` is equivalent when both are absent)
2. **Grounding agent** (general-purpose, background, read-only): enumerate every checkable factual claim in the doc — file paths, line numbers, versions, class/method names, config values, architectural assertions ("X is instantiated in Y", "Z has no callers") — and verify each against the repo. Output: a Claim | Verdict (CONFIRMED/WRONG/PARTIAL/UNVERIFIABLE) | Evidence(file:line) table, then a list of stale/overclaimed statements and grounding gaps. Give the agent the project root, the doc path, and an explicit numbered list of the doc's most load-bearing claims so it can't skip them — the same numbered list you tagged TESTABLE vs CITE-ONLY during the Phase-1 read.
3. **Path-correctness agent** (general-purpose, background, read-only, web): adversarial architecture review — is the chosen approach correct per CURRENT official documentation? Extract the doc's 4-7 most load-bearing technical assumptions, instruct the agent to challenge each with web research against primary sources, and require per-question verdicts (CONFIRMED/WRONG/NUANCED) with URLs plus an overall PATH CORRECT / CORRECT WITH CAVEATS / WRONG verdict. Tell it to be adversarial: "your job is to find the flaw before production does."

If `notes` were given, append them to every subagent prompt (Phase 1 and Phase 2) as focus context: "Operator focus context (weight findings toward this; do NOT let it narrow required coverage): <notes>".

Immediately after the launch block returns: `Edit` the run file's **Workflow run** row with the real run ID, then append one `### <laneKey> · launched · <ts>` block per lane you launched.

**Write protocol — one writer, the orchestrator. Lanes never touch this file.** The hazard is not concurrent writers; it is a single writer with a lossy memory rewriting the file from a stale in-context copy after a compaction, and silently dropping a lane. Three rules close that:

1. **One whole-file `Write`, at creation. Never again.**
2. **Every subsequent write is an append at end of file**, using `cat >> /tmp/<slug>-triangulate-run.md <<'RUNFILE_EOF_a91f'`. The **quoted** heredoc is load-bearing — probe output is the payload most likely to contain backticks and `$` — and the **odd delimiter** is too: `probeFindings` carries literal command output, so a payload line that is exactly `EOF` would close the heredoc early and hand the rest to the shell as commands. Never use a delimiter a captured output could plausibly contain. Do NOT use `Edit` for appends: it needs an anchor, which needs a fresh read of the tail a compaction just removed.
3. **A written block is never edited or deleted.** For a key with repeated blocks — `probeFindings` collects the first-order probe, both second-order probes, and the Phase-3 spot-check — the later block supersedes by position and both stay visible.

Two header rows are ever rewritten, each a single-line `Edit` anchored on its bold key: **Workflow run** (status) and **Probe gate** (on upgrade). A gate upgrade **appends a new gate block** and rewrites only the row — it never edits the fenced claim text, so the original survives.

Lane blocks take this shape, lane keys verbatim (`groundingFindings`, `pathFindings`, `probeFindings`, `fixShapeFindings`, `blastRadiusFindings`):

```
### <laneKey> · launched · <ts>
### <laneKey> · landed · <ts>
<condensed findings: verdicts, file:line evidence for load-bearing items, fix-worthy deltas>
```

Condense hard — carry what Phase 3 needs to act, not the full report. **`probeFindings`** carries, per question: claim → command(s) run → condensed literal output → verdict → iterations used.

The loop rule lives at the head of the run file's `## Lane log`. There is no separate driver task and nothing re-injects the rule each turn, so it is on you — with one prop: a turn that launches nothing must append an `### idle` block, which both forces you to open the file and makes the idling countable in the Phase-3 ledger.

## Phase 2 — Keep looping until the workflow finishes

Each time an agent completes (or you have a free turn), launch the next agent on an **uncovered dimension**. Pick from this **first-order menu** based on what the doc touches (typically 2-4 of these fit a doc; scale to doc size and risk — that's coverage guidance, NOT a stop condition; when this menu is exhausted the loop continues into the second-order menu below, until the workflow completes):

- **Call-chain / choke-point trace** — when the doc gates, reorders, or hooks an existing runtime flow: trace the actual init/call chain with file:line, find the narrowest insertion point, list bypass paths and never-ran safety.
- **Testability / environment-behavior audit** — are the doc's planned tests writable in the house test patterns? How do the involved SDKs behave in the editor/CI environment (stubs? throws?)? Does the dev loop need a bypass?
- **Dependency / namespace / portability audit** — verify every dependency the proposed code needs (actual namespaces, locations, which side of a library boundary they live on); check claimed reusability/agnosticism against the real dependency graph, with an existing class as the precedent.
- **Sibling-doc interaction audit** — read the sibling/predecessor docs the target references; verify the claimed interactions and non-interactions still hold against both the docs and the source.
- **Data/analytics impact audit** — when the doc changes event flows: what rows change in the warehouse, which dashboards/queries break, what new states need instrumentation.
- **Empirical probe / doubt-removal** *(only when the gate recorded `probes: in-play` or `probes: upgraded-in-play`)* — an execute-but-don't-write lane (general-purpose, background) that settles runtime-behavior doubts by *running* the behavior instead of citing it. This entry is the single source for the probe contract; the second-order probe lanes and the Phase-3 spot-check reference it rather than restate it.
  - **Lane input** — a numbered list of open questions, each carrying the claim, why it's in doubt, and the doc's assumption. Sources: Phase-1 TESTABLE claims nothing else will verify; grounding-lane UNVERIFIABLE rows; path-lane NUANCED verdicts; operator `notes` (threaded via the existing focus-context line — no new mechanism).
  - **Per-question required output** — the minimal probe designed → the exact command(s) run → the **literal output** (trimmed, never paraphrased) → the verdict.
  - **Verdict vocabulary** (spell exactly, UPPERCASE):
    - **DEMONSTRATED** — behavior shown to match the claim.
    - **REFUTED** — behavior shown to contradict the claim.
    - **INCONCLUSIVE** — the probe ran with an ambiguous result, OR no unblocked probe design remains.
    - **UNTESTABLE** — no safe, non-destructive probe exists *in principle*; state what access or mutation it would take.
  - **Iteration rule** — INCONCLUSIVE is non-terminal. On an ambiguous result the agent designs a follow-up probe that attacks the ambiguity and re-runs, **up to 3 probe runs total per question (the initial probe = iteration 1)** — all within this one subagent's own context (run → observe → re-probe; no respawn). Only at the bound — or via permission-block early termination — may INCONCLUSIVE ship; **at the bound it must include the written design of the next probe** it would have run.
  - **Permission-block handling** — a permission-blocked command (harness prompt or sandbox denial) does NOT burn an iteration. When no unblocked probe design remains for the question, it terminates early as INCONCLUSIVE — shipping immediately (the at-the-bound next-probe-design rule applies to ambiguous *results*, not to blocked *access*), with the blocked command named as its required-access statement. Distinguish from UNTESTABLE: UNTESTABLE = no safe probe exists in principle; blocked-INCONCLUSIVE = a safe probe exists but access was denied.
  - **Safety constraints — carry this block VERBATIM at the head of every probe prompt** (it opens the prompt in place of the read-only opener, per hard rule 1's exception): *"You are an empirical probe lane: execute-but-don't-write. Run ONLY non-destructive commands. Write scratch ONLY under `/tmp/<slug>-probes/`. Do NOT modify repo files, installed tools, global config, or any shared state. No sudo. No deletes outside `/tmp`, and never delete or modify `/tmp/<slug>-triangulate-run.md` or `/tmp/<slug>-launch-baseline.md`. No network writes. Do NOT kill or restart any session, service, or process. NEVER run against a production surface. Any question that can only be answered by a mutation → verdict UNTESTABLE plus an operator-acceptance flag; never run it."*
  - **Scratch lifecycle** — the prompt's first command, immediately after the safety block, is `mkdir -p /tmp/<slug>-probes/` (idempotent — no orchestrator action needed; sibling of `/tmp/<slug>-launch-baseline.md`). Treat any pre-existing contents (a same-slug prior run's scratch) as untrusted — never as this run's evidence.

Report each completed agent's headline findings to the user in 2-4 sentences as they land (lead with what changed your assessment), and **append that lane's `landed` block to the run file before doing anything else** — if compaction strikes mid-run, an unlogged lane is a lost lane. Do NOT fix the doc yet.

### When the first-order menu is exhausted but the workflow is still running

The loop does NOT stop — switch to **second-order lanes**, which work the completed lanes' output instead of the doc's untouched dimensions (still background; read-only except probe lanes):

- **Fix-shape verification** — take each MUST-FIX finding from completed lanes and research the precise correction (exact API composition, exact code shape, primary-source citations) so Phase 3's edits are surgical rather than directional. The highest-value second-order lane: a verified fix beats a verified flaw.
- **Probe-the-fix** *(gate `probes: in-play` or `upgraded-in-play` only; skipped under `N/A`/`spot-check`)* — extends **Fix-shape verification**. When fix-shape proposes a correction that is itself TESTABLE (exact command form, flag composition, API invocation), a probe agent demonstrates it *before* Phase 3 applies it to the doc — same contract as the **Empirical probe / doubt-removal** entry (carry its safety block verbatim; do not restate the contract). A failed demonstration sends the fix back to fix-shape with the failure output attached. Logs its verdict under `probeFindings`.
- **Blast-radius sweep** — for each disproven claim, enumerate every OTHER artifact stating the same claim (sibling docs, the design twin, reference docs, knowledge files, code comments) with file:line — Phase 3 fixes the family, not just the target doc.
- **Cross-lane contradiction hunt** — feed the completed lanes' verdicts to an agent that hunts for findings that contradict each other or rest on incompatible assumptions; contradictions get re-verified before consolidation treats both as true.
- **Probe-the-contradiction** *(gate `probes: in-play` or `upgraded-in-play` only; skipped under `N/A`/`spot-check`)* — extends the **Cross-lane contradiction hunt**. When a lane's verdict conflicts about runtime behavior — either with another lane OR with the doc's own runtime-behavior claim (the precedent case: one confidently-wrong lane against the doc) — **you (the orchestrator) launch this entry** with the conflict as its single question (the contradiction hunt is itself a background subagent and cannot spawn lanes; it surfaces the conflict in its findings for the loop to act on). Same contract as the **Empirical probe / doubt-removal** entry by reference (carry its safety block verbatim; do not restate the contract). Its verdict resolves the conflict under hard rule 5. Logs under `probeFindings`.
- **Completeness critic** — "what's missing: which doc claim did NO lane verify, which dimension was skipped and why does that matter, which acceptance criterion is unverifiable as written?" Its output is either reassurance or the next lane's prompt.
- **Re-ground the workflow's mid-run edits** — the workflow applies fixes to the target doc as it goes (reading the doc is safe; only WRITING is forbidden). Diff the current doc state against the launch-time baseline snapshot (path in the run file's **Baseline** row) and spot-check that the workflow's applied fixes don't contradict completed-lane evidence; contradictions become Phase 3 items.

Each second-order lane appends to the run file like any other (e.g. `fixShapeFindings`, `blastRadiusFindings`). If genuinely nothing remains worth verifying (rare — say so explicitly in one line), end the turn; the run file's loop rule still requires that explicit statement rather than silent idling.

## Phase 3 — Consolidate (after the workflow completes)

Read `/tmp/<slug>-triangulate-run.md` first, whether or not you think you remember the run. If the conversation was compacted, that file IS the run state — reconstruct from it, not from memory. A lane with a `launched` block and no `landed` block either is still in flight or landed in the turn compaction hit; if its findings are nowhere, name it as a coverage gap in the report rather than letting it read as a clean lane.

1. Read the final `-review.md` (the workflow's E/R columns) and the workflow's return value. Check its `status` (`ok | degraded | drifted | aborted`) and record it in the run file's **Workflow run** row before going further: `drifted`/`aborted` means the workflow STOPPED mid-sequence — lead the final report with that, treat E/R columns from the stop point onward as absent or suspect, and weight the convergence map toward the subagent lanes; `degraded` means a review round ran with failed reviewers — its R column under-reports.
2. **Single-claim spot-check** (only when the gate recorded `probes: spot-check`): *before* building the convergence map, run that one carried claim's probe inline — same safety constraints as the **Empirical probe / doubt-removal** entry's safety block (non-destructive only; scratch only under `/tmp/<slug>-probes/`; no mutation), result logged under `probeFindings` like any lane. (The orchestrator runs this directly — rule 1's read-only opener binds Agent prompts, not the orchestrator, which already executes the launch-baseline `cp` and the completion sound.) Then build the **convergence map**: for every distinct finding across all lanes, classify it —
   - **CONVERGED** (workflow + ≥1 subagent found it): highest confidence, fix without debate.
   - **WORKFLOW-ONLY**: verify against subagent evidence before accepting; the workflow may lack repo grounding.
   - **SUBAGENT-ONLY**: the workflow missed it; verify the citation yourself (spot-check one file:line per finding), then fix.
   - **Probe weighting** — a **DEMONSTRATED** or **REFUTED** probe finding (carrying the exact command and literal output) enters as highest-confidence regardless of lane count; when it conflicts with a citation-grounded verdict about runtime behavior, the conflict resolves in the probe's favor under hard rule 5, and the overruled citation lane's finding is **annotated, not deleted** — the map must show *why* the citation lost.
3. Apply the consolidated fixes the workflow didn't already apply to the target doc (the workflow has finished — edits are safe now). Respect the doc's existing structure; date-stamp substantive corrections. **In-flight probe handoff for TESTABLE fixes** (from **Probe-the-fix**): if a TESTABLE fix's demonstrating probe is still in flight when the workflow completes, await that probe's verdict before applying the fix; if the probe cannot complete, apply the fix annotated **UNDEMONSTRATED**; a TESTABLE fix for which no probe was ever launched is applied annotated **UNDEMONSTRATED** directly (no await target exists). Phase 3 spawns NO new probe lanes — the only Phase-3 probe activity is the inline spot-check (Phase-3 step 2); any runtime-behavior conflict noticed during Phase 3's steps 1–2 becomes a residual operator-acceptance item, not a new lane.
4. Deliver the final report: overall verdict (lead with it), the convergence map (table), fixes applied vs. residual plan-time items, and any finding that changes the task's risk profile. **Residual probe doubts** — every terminal **INCONCLUSIVE** (whether it hit the iteration bound or terminated early on a permission block) and every **UNTESTABLE** question appears as a named residual operator-acceptance item: an at-bound INCONCLUSIVE carries its written next-probe design, a permission-blocked INCONCLUSIVE and an UNTESTABLE carry their required-access statement. The report may not claim doubt-removal it didn't earn. If any lane found the path WRONG, say so first and stop short of fixes until the user weighs in.
5. Report the lane ledger in one line, counted from the run file's `## Lane log` — e.g. `lanes: 7 launched / 7 landed over 84 min · 2 idle turns` (an idle turn is an `### idle` block; if there are none and elapsed time is long, say the log is silent rather than implying none occurred) — then delete `/tmp/<slug>-triangulate-run.md`, but only after the final report is delivered. If the report could not be delivered, leave the file and say where it is.
6. Play a single completion notification:

```bash
command -v afplay >/dev/null 2>&1 && afplay /System/Library/Sounds/Glass.aiff; command -v say >/dev/null 2>&1 && say "Review triangulate completed"
```
