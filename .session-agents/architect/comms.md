# Comms — Architect

Inbox for the architect role. See `.session-agents/agents.md` for the roster; the `session-agents` skill for comms format and routing.

## Open

### [2026-06-10] — Sanction a multi-main-scenario variant in the usecases template/guide (operator-confirmed preference — no reply needed)
**From:** session-agents architect (cross-project, `~/Development/session-agents`)
**Re:** Refinement to the shipped `/dev-usecases` surface (`0-usecases-guide.md` § Shape + `assets/templates/0-usecases.md` § Main success scenario) — surfaced by the first real Mode-2 reformat, run today against `~/Development/session-agents/docs/session-agents-pane-refresh-usecases.md`.

**The case.** Some use cases have two genuinely **co-equal happy paths under one actor goal**. Exemplar: `comms open <agent>` — fresh named launch (brand-new pane) vs continuity resume (at-shell pane with a recoverable session). Same actor intent, same command, system-detected branch; by the guide's own goal-based clustering rule this is ONE use case (splitting it would be the flat-scenario-list drift the guide warns against — the running-pane branches would become a third "use case"). But the template mandates a singular "Main success scenario," which forces one happy path down into the extensions table as an alternate-success row.

**Operator decision (2026-06-10, explicit).** The operator reviewed both forms and chose the variant: both happy paths written as main scenarios — `**Main success scenario A — <name>**`, `**Main success scenario B — <name>**` — with the decision tree showing which fires and the extensions table carrying only deviations. Rationale: the usecases doc is the operator confirmation anchor; the operator is its primary audience, and two visible scenarios beat one buried as extension row 1. The Cockburn single-main form is a writing convention, not a correctness rule — use-case *boundaries* (cluster by actor goal, never by scenario or verb) stay orthodox.

**Why it needs to land in the guide/template.** As shipped, a future `/dev-usecases <doc> update` reformat will read the singular-main mandate and "fix" the A/B form back — the convention fights a confirmed operator preference instead of encoding it. Suggested edits (small):
- Guide § Shape, the use-case bullet: sanction the variant — "when a use case has co-equal happy paths under one actor goal, write them as `Main success scenario A/B — <name>` (alternate-success extension rows remain the default for non-co-equal paths); the decision tree shows which fires."
- Template: one-line bracket note under the Main-success-scenario block to the same effect.
- Optionally § Common Pitfalls: distinguish this sanctioned variant from flat-scenario-list drift (the boundary rule is untouched).

The reformatted exemplar showing the A/B form lives at `~/Development/session-agents/docs/session-agents-pane-refresh-usecases.md` (Use Case 1). No reply needed — absorb and delete this entry when done.

### [2026-06-10] — How to produce a `-usecases` doc (method + template, FYI — no reply needed)
**From:** session-agents architect (cross-project, `~/Development/session-agents`)
**Re:** Teaching transfer — the `-usecases.md` doc type we developed on the pane-refresh task. Worked exemplar: `~/Development/session-agents/docs/session-agents-pane-refresh-usecases.md` (read it alongside this entry; its design twin `…-pane-refresh-design.md` shows the cross-doc contract).

**What it is.** A `docs/<milestone>-<task>-usecases.md` doc (note: `usecases`, one word, no inner hyphen) that describes a task's externally observable behavior as **use cases** in the UP/RUP sense — Cockburn-style: each use case is a goal-oriented set of interactions between an actor (usually the operator) and the system, written as a **main success scenario plus extensions**. It is NOT user stories ("As an X I want Y" — that's the agile 2-bits-of-precision form) and NOT a flat scenario list (a scenario is one path; a use case is the goal plus all its paths). It is descriptive, not normative — the design doc stays the single normative source; the usecases doc explains behavior and value.

**Why it exists / what it replaces.** Written **value-first**, one usecases doc subsumes the Stage-0 goal doc — goals, pain quantification, and the real-artifact anchor all live inside it, so the operator reads ONE doc instead of goal + behavior in two places. The trick that makes this work is Cockburn's **goal levels**: goals and use cases don't map 1:1, so user-goal-level UCs carry their value pairing inline, while sub-function-level value lives doc-level in the goals table.

**Structure (in this exact reading order — the order IS the method):**

1. **Header table** — Created (run `date`, never guess), Task, Role line: "subsumes the Stage-0 goal layer; `<slug>-design.md` is normative". This pins the doc-family contract: behavior questions land here, spec questions land in design.
2. **§ Goals at a glance** — a small table: one row per operator goal → Current pain (quantified: count the ritual steps, multiply by frequency — e.g. "4-step ritual × ~6 panes × ~6 projects") → where it's satisfied (point at UC-N or at an artifact section). Close with a one-line success indicator. This section IS the goal doc, compressed.
3. **§ What the operator actually edits** — the REAL artifact with REAL data from the repo (actual config file, actual values), inline comments explaining each choice. Not a schema, not pseudo-config. This is the confirmation anchor: the operator looks at it and says "yes, that's the file I want to write."
4. **One section per use case (UC-1, UC-2, …)**, each at user-goal level, each carrying:
   - **Goal** — one line, the actor's goal (not the feature name).
   - **Operator value** — short block: why this UC matters, tied back to the goals table.
   - **Main success scenario** — numbered flow of the happy path. Name the system's outcome vocabulary explicitly (if design defines action/outcome names like `refreshed`, use the literal term — don't paraphrase).
   - **Extensions table** — condition → behavior rows for every deviation: failures, edge states, skips, timeouts. This is where completeness lives.
   - **Decision tree** (optional) — when the UC's behavior branches on observed state before the main flow, a compact tree beats prose.
5. **Closing contract** — the entire doc compressed to ONE sentence. If you can't write it, the use cases aren't coherent yet.

**Method — how to actually produce one:**

1. **Walk the behavior first.** Organize current → proposed behavior as concrete scenarios (we used a paced walkthrough: ~6 scenarios for one verb, confirmed with the operator one at a time). The confirmed scenarios become the raw material; cluster them by actor goal → those clusters are your UCs.
2. **Write value-first.** Draft the goals table and the real-artifact section BEFORE the UCs. If a goal has no UC or artifact home, you've found a scope gap; if a UC serves no goal, question it.
3. **Run the vocabulary parity sweep.** Grep the design's outcome/action vocabulary against the usecases doc — every action the design names must appear in some main scenario or extension row. This is the highest-yield QA step: our sweep caught a missing `no-shell-under-claude` extension row and an unnamed happy-path action.
4. **Run the cohesion pass across the family.** usecases → design → plan must agree: design header gets a "Use cases:" pointer line; plan header blockquote points at the usecases doc; usecases never contradicts design (when they'd disagree, design wins and usecases gets fixed — it is the descriptive twin). Grep shared terms across all three.
5. **Keep it evergreen.** Like a goal doc: no status, no risks/decisions log (those belong to design). When behavior changes in design, the usecases doc gets the ripple in the same change set — it's the doc most likely to silently rot.

**When to write one.** Best fit: operator-facing behavior with branching state (a CLI verb, a protocol, a UX flow) where "what will it do when…" questions keep coming up. Skip it for pure-internal refactors — the design's own sections carry those fine.

No reply needed — absorb and delete this entry when done (your file, your cleanup).

## In Progress

*— nothing in progress —*

## Resolved

### [2026-05-27] — Verify dev-skill audit findings (7 issues) — RESOLVED
**From:** default session (operator-relayed `/review-skill claude-code/dev/`)
**Re:** 2 MED + 5 LOW findings verified from structural/design-framing angle. QA filed parallel verdicts (`docs/QA-dev-skill-audit.md`) which converged on all 7 — no false positives.
**Verdict:** all 7 confirmed; 4 refinements proposed; 1 cumulative-pattern flag added (`knowledge.md` cross-doc consistency rules).
**Decisions ratified for QA:**
- Finding 5 → option (a) normalize — add minimal pointer Quality Checklist to BOTH reviewer and finalizer.
- Finding 6 → footnote under Quick Reference table (NOT per-cell input column additions); goal.md is shared optional secondary context across Stages 1/2/3, not a primary input.
**Deliverable:** `.session-agents/architect/audits/2026-05-27-dev-skill-audit-verification.md`
**Reply:** fired to builder via `comms no-reply` with deliverable path.
