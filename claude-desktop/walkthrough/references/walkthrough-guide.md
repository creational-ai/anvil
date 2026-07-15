# Walkthrough Guide (Claude Desktop)

Pedagogical, operator-facing comprehension pass: the walkthrough paces an operator through a document **unit-by-unit**, elaborating each unit from five angles (plain English, motivation, diagram, before/after state delta, usage) and pausing between units for natural-language confirmation before advancing.

> **Source of truth.** This guide defines every aspect of walkthrough behavior — input acquisition, doc-type recognition, unit detection, unit extraction, the five-angle elaboration rules, review-context enrichment, and per-unit advance semantics. `SKILL.md` is the entry point; all logic lives here.

> **Lineage.** Ported from the Anvil Claude Code walkthrough (`claude-code/review/references/walkthrough-guide.md`). Sections marked **[CD-adapted]** deviate deliberately for the Claude Desktop surface; everything else is ported intact and should stay in sync with the CC version.

> **Reading convention.** Below, "unit" is the generic label for whatever the doc calls its segment (Step, Item, Task, Milestone, Goal, Phase, Component, Requirement, Section, …). `{Term}` is the placeholder the walkthrough substitutes at render time with the doc's detected term (see Adaptive Vocabulary).

---

## Input Acquisition **[CD-adapted]**

Claude Desktop has no path arguments; the document arrives through whatever channel the conversation offers:

1. **Uploaded file** — use its content directly; the filename drives doc-type recognition.
2. **Pasted content** — use as-is; no filename, so doc-type recognition falls to content cues.
3. **Project file / artifact** — a doc already in the conversation or project context.
4. **Fetched via connected tools** — when the operator names a file and a filesystem/Drive/repo tool is connected, fetch it. Ask before guessing among multiple matches.

**Notes (optional)**: free-form focus areas the operator wants emphasized (e.g., "pay extra attention to the migration path"). Weight elaboration toward them; never let them skip units or angles.

### Rejection Rules

Surface these as operator-visible errors (not silent failures):

- **No document provided and none fetchable** → ask the operator for the doc; do not walk through a summary of what you imagine the doc says.
- **Doc has no headings Unit Extraction can consume** (neither a Tier 1 match nor any H2 under default extraction) → `No unit structure detected. Walkthrough requires at least H2 sections (or a consistent indexed heading pattern at any depth) to segment the doc.`

---

## Doc-Type Recognition **[CD-adapted: table inlined]**

The CC version references `exam-guide.md § Document Type Recognition`; that guide is not present on this surface, so the mapping is inlined here. Identify the document type from its filename pattern (Anvil naming conventions):

| Filename pattern | Doc type |
|---|---|
| `[slug]-vision.md` | Vision |
| `[slug]-architecture.md` | Architecture |
| `[slug]-milestones.md` | Milestones |
| `[milestone]-tasks.md` | Tasks |
| `[milestone]-[task]-usecases.md` | Usecases |
| `[milestone]-[task]-design.md` | Task Design |
| `[milestone]-[task]-plan.md` | Plan |
| `[milestone]-[task]-results.md` | Results |
| `[milestone]-milestone-summary.md` | Milestone Summary |

**Content-cue fallback** (pasted docs with no filename): an Executive Summary table + `## Analysis` + `## Proposed Sequence` reads as Task Design; `## Specification` + numbered Steps + acceptance criteria reads as Plan; goals/strategy framing reads as Vision; milestone enumerations read as Milestones. Apply judgment; certainty is not required.

- The doc type drives two things: the **Tier 2 unit-term default** (see Adaptive Vocabulary below) and the **before/after interpretation** for Angle 4 (see Five-Angle Elaboration Rules).
- **Unknown doc type** (no pattern or cue match) → walkthrough continues; the unit term falls through to Tier 3 generic "Section".

---

## Adaptive Vocabulary — Unit Detection (3-Tier Priority)

The walkthrough detects what the doc calls its own units and uses that exact term everywhere in output (gate prompts, counters, summary lines). Three-tier priority — **first match wins**.

### Tier 1 (primary) — Heading-Pattern Scan

Scan the doc for repeated unit headers at **any heading depth** (H2, H3, H4, …). Accept two patterns:

1. **Termed-index pattern**: `#+ <Term> <N>[:.]? <title>` or `#+ <Term> <N.M>[:.]? <title>`. The word immediately before the numeric index supplies the unit term. Examples:
   - `## Step 1: Setup`, `## Step 2: Migrate` → unit term = **Step**
   - `## Milestone 1: MVP` → unit term = **Milestone**
   - `### Item 1: Authentication`, `### Item 2: Authorization` → unit term = **Item**
   - `## Phase 1: Planning` → unit term = **Phase**
   - `## Task 3.2: ...` → unit term = **Task**
   - `## Requirement 5.1: ...` → unit term = **Requirement**
   - `## Use Case 2 — Sign in` → unit term = **Use Case**
   - `## Component 4: ...` → unit term = **Component**

2. **Bare-numeric pattern**: `#+ <N>[.:]? <title>` — no term word, just a numeric index. Tier 1 **still matches** on this form; the term word falls back to the Tier 2 doc-type default. Example: `### 1. Command Spec`, `### 2. Adaptive Vocabulary`, … (the dev-design Analysis items pattern).

**Tier 1 is inconclusive when**:
- Fewer than **2** matching headings are found, **OR**
- Matching headings disagree on the unit term (mixed vocabulary — e.g., `## Step 1` and `## Item 2` both present), **OR**
- Matching headings span multiple heading depths with no single dominant depth.

When any of these conditions holds, fall through to Tier 2.

**Detected heading depth**: Tier 1 also records the **dominant heading depth** of its matches (e.g., H3 when the doc's items are all `### <N>. <title>`). That depth drives Unit Extraction — this is what makes the walkthrough work correctly on, say, dev-design Analysis items at H3 even when the term comes from Tier 2.

### Tier 2 (fallback) — Doc-Type Default Lookup

If Tier 1 is inconclusive, fall back to the per-doc-type default term:

| Doc type | Default unit term |
|----------|-------------------|
| Vision | Goal |
| Architecture | Component |
| Milestones | Milestone |
| Tasks | Task |
| Usecases | Use Case |
| Task Design | Item |
| Plan | Step |
| Results | Step |
| Milestone Summary | Task |

### Tier 3 (last resort) — Generic "Section"

If the doc type is unknown AND Tier 1 was inconclusive, fall through to generic **Section**: treat each `## H2` heading as a unit, label it "Section".

### Term Substitution

The detected term replaces `{Term}` placeholder in all operator-facing output:

- Gate prompt: *"Ready for **{Term} {N+1}**?"*
- Counter (if shown): *"**{Term} {N}** of {Total}"*
- Summary on exit: *"Walked through {K} of {Total} {term}s"* (plural lowercased — e.g., "items", "steps", "milestones")

---

## Unit Extraction

- **When Tier 1 matched**: iterate headings at the **detected dominant depth** in document order. Each matching heading starts a new unit; content until the next heading at the same depth (or an ancestor depth) belongs to that unit. Headings at **deeper depths** are part of the current unit's body. This is the branch that surfaces dev-design Analysis Items (H3 under `## Analysis`) correctly — the walkthrough never collapses them into one H2 block.
- **When Tier 1 was inconclusive** (Tier 2 or Tier 3 branch): iterate `##` H2 headings in document order (default extraction). Each H2 starts a new unit; nested `###` and deeper headings are part of the parent unit.
- Units carry: **(index, title, body text, any code blocks / tables / lists in body)**.

---

## Five-Angle Elaboration Rules

For every unit, in **this fixed order, no angle skipped**:

### Angle 1 — Plain English (What)

One paragraph, jargon-free. Describe what this unit accomplishes and its outcome. Length: 1-3 sentences.

### Angle 2 — Motivation (Why)

One paragraph. Explain why this unit exists, what would break or remain unsolved without it, what constraint or goal it satisfies. Length: 1-3 sentences.

### Angle 3 — Diagram (How) **[CD-adapted: rendering upgrade]**

A diagram illustrating the unit's mechanism, structure, flow, or state. Diagram kind is selected from the unit's body content:

- **flow diagram** — for process / sequence units (e.g., "read input → validate → write output").
- **box-and-arrow** — for structural / component units (e.g., architecture components, module interactions).
- **state transition** — for before→after value changes (e.g., config key flipped, data-model migration).
- **dependency graph** — for coordination units (e.g., milestone ordering, which task blocks which).

**Default rendering is inline ASCII** — it always works, keeps the pace conversational, and reads fine on a phone. Claude Desktop adds one upgrade the CC version cannot offer: when a unit's structure genuinely earns it (a multi-component architecture, a dependency web, a state machine with several transitions), you MAY render the diagram as a Mermaid or SVG artifact instead. Use the upgrade sparingly — at most where it adds real comprehension over ASCII — and never as a substitute for the angle: a unit gets exactly one diagram either way.

**Non-visual units** (renames, config-value edits, prose changes) still get a diagram — a **simple two-box before→after** showing the value change is sufficient. **Never skip Angle 3.** The discipline of producing a diagram forces the unit to be concrete.

If unsure which kind to use, default to **box-and-arrow** in ASCII.

### Angle 4 — Before / After (State Delta)

A concrete state delta, anchored in **artifacts**. The interpretation of "state" depends on the doc type:

- **Plan / Results** → **code state**: file list, key function signatures, test count — before vs. after.
- **Task Design / Tasks** → **design state** (decisions, constraints) and **behavior state** (what the system does) — before vs. after.
- **Milestones** → **deliverable / capability state**: what exists, what's in scope, what's shippable per milestone — before vs. after.
- **Usecases** → **operator-facing usage state**: per use case, the Operator value today vs. post-task (and the main success scenario + extensions the operator gains) — before vs. after.
- **Architecture** → **structural state**: what components exist and how they relate — before vs. after.
- **Vision** → **strategic state**: what the organization understood — before vs. after.
- **Unknown / generic** → describe the delta in whatever terms the unit itself uses.

Length guidance: 1-3 sentences or equivalent structured content (a short before/after list is fine).

### Angle 5 — Usage (Consumer)

Who consumes this unit's output? Another unit? A downstream doc? End user? QA? What should the operator expect to see in the repo, tests, or UI once this unit is done? Length: 1-3 sentences.

### Common Pitfalls (avoid all of these)

- **common pitfall: verbose boilerplate** that repeats the unit's own body text instead of elaborating. Each angle must add information — not restate.
- **common pitfall: diagrams that describe rather than render**. A prose sentence that says "this is a flow from A to B" is not a diagram. Render actual ASCII (or an artifact, per the Angle-3 upgrade rule).
- **common pitfall: before/after type mismatch** — phrasing state delta as "code changes" when the unit is strategic, or as "strategic change" when the unit edits code. Match the per-doc-type interpretation in Angle 4.
- **common pitfall: artifact overuse** **[CD]** — rendering every unit's diagram as an artifact turns a paced conversation into a gallery crawl. ASCII is the default for a reason; upgrade only when structure earns it.

---

## Review Context Enrichment (Optional Overlay) **[CD-adapted: availability]**

If a companion review doc (`[slug]-review.md`) is available — uploaded alongside the target, present in project context, or fetchable via the same connected tool that supplied the target — load it.

- Surface review context in the **Motivation angle** when pedagogically useful. Example: *"This {term} was rewritten in R2 because the original approach conflicted with the existing loop defaults."*
- Review context **enriches** elaboration; it does **not** drive unit extraction or override the detected term.
- If no review doc is available, proceed without it — never ask the operator to go find one.

---

## Per-Unit Advance Semantics

After the five angles render for a unit, pause on a minimal prompt and interpret the operator's next utterance in natural language.

### Prompt Shape

- At the final line of the unit's elaboration, render exactly: *"Ready for {Term} {N+1}?"*
- Nothing else is rendered per unit. **No** explicit QA checklist. **No** "common traps" list (pitfalls are guidance for the walkthrough's own elaboration, not an operator-facing checklist). **No** formal response-protocol labels.

### Readiness Is Internal

**Readiness is an internal judgment by the walkthrough, not an operator-facing artifact.** The walkthrough reads the operator's engagement from their response: a substantive question prompts elaboration before advancing; a quick acceptance advances. Readiness is never rendered as a checklist.

### Operator Signals (Natural Language)

Interpret operator responses conversationally — **no formal tokens required**:

- **Affirmative** (*"yes"*, *"ok"*, *"next"*, *"continue"*, *"got it"*, *"sure"*) → advance to the next unit.
- **Question or concern** → answer directly, then re-prompt *"Ready for {Term} {N+1}?"*.
- **Exit signal** (*"stop"*, *"enough"*, *"I've got it"*, *"done"*, *"that's enough"*) → end the walkthrough.

### Exit Conditions

- Any exit signal from the operator, **or**
- Reaching the final unit (the walkthrough wraps with a brief acknowledgement and stops automatically).

### Summary on Exit

Render exactly: *"Walked through {K} of {Total} {term}s"* (plural lowercased, e.g., "items" / "steps" / "milestones" / "sections").

---

## Invariants (Non-Negotiable)

These are **non-negotiable** — hard invariants enforced by this guide:

1. The walkthrough **never writes** to the target doc or any other file, and never edits an artifact holding the target doc. It is strictly read + elaborate. No fix mode, no persisted state. Re-running starts fresh.
2. The five-angle format is **non-negotiable**. Even non-visual units get a weak two-box state diagram for Angle 3. No angle is skipped. No angle is silently merged with another.
3. **No formal response-protocol vocabulary** (`yes` / `questions` / `stop` as labeled tokens) surfaces in the walkthrough's output. Operator signals are interpreted from natural language only — the prompt shape is *"Ready for {Term} {N+1}?"*, not a menu.

---

## Process Outline

The authoritative process is:

1. Read this guide.
2. Acquire the document (uploaded / pasted / project file / fetched) + optional free-form notes.
3. Detect doc type — filename pattern first, content cues as fallback (tables above).
4. Detect the unit term using the 3-tier adaptive vocabulary (Tier 1 heading scan → Tier 2 doc-type default → Tier 3 generic "Section").
5. Extract units — iterate at the detected dominant heading depth from Tier 1; default to H2 boundaries when Tier 1 is inconclusive.
6. Load review context if a companion review doc is available.
7. For each unit in document order: render the five angles → pause on the minimal *"Ready for {Term} {N+1}?"* prompt → interpret the operator's response in natural language → advance, elaborate, or exit.
8. On exit signal or final unit: render the summary line *"Walked through {K} of {Total} {term}s"* and end.
