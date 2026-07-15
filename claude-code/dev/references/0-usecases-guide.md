# Usecases Doc Guide (Stage 0)

## Purpose

A **usecases doc** is the **value-first behavior doc** for a task. It answers three questions:

1. **What are the goals?** — one declarative sentence per goal, with the pain it removes.
2. **What does the operator actually edit?** — the real artifact, with real data, as the confirmation anchor.
3. **What does the system do in every branch?** — each behavior as a **main success scenario plus extensions**.

It describes a task's externally observable behavior as **use cases** in the UP/RUP sense — Cockburn-style: each use case is a goal-oriented set of interactions between an **actor** (usually the operator) and the **system**, written as a **main success scenario plus extensions**. It is **NOT user stories** ("As an X I want Y" — the agile two-bits-of-precision form) and **NOT a flat scenario list** (a scenario is one path; a use case is the goal *plus all its paths*).

It is **descriptive, not normative**. The design doc stays the single normative source; the usecases doc explains behavior and value. Where the two would disagree, the design wins and the usecases doc gets fixed in the same change set (see § Evergreen rule).

It has **two audiences, both load-bearing**:

- **The operator**, who uses it to confirm the direction of the task before the team commits to it.
- **Downstream agents** — design → review → plan → review → execute → monitor — who use it as a fixed alignment anchor across the entire dev pipeline. One confirmed set of goals and behaviors, one shared expectation, no per-stage drift.

It is NOT a design doc. It carries no schemas, no signatures, no API specs, no risks list, no decisions log. Those live in `docs/[milestone-slug]-[task-slug]-design.md` (Stage 1). The usecases doc is the *why-it-matters and what-it-does* layer; the design doc is the *how*.

A reader should be able to absorb the usecases doc quickly and walk away knowing:
- What this task delivers (one declarative sentence per goal) and the pain each removes (quantified)
- What the operator actually edits (real artifact, real data)
- What every branch of each behavior does (main success scenario + extensions)
- What "done" looks like (one observable sentence, plus a one-sentence contract over all use cases)

### Goal levels — the trick that makes subsumption work

Written value-first, one usecases doc **subsumes the Stage-0 goal doc**: goals, pain quantification, and the real-artifact anchor all live inside it, so the operator reads ONE doc instead of goal + behavior in two places. The mechanism is Cockburn's **goal levels** — goals and use cases do **not** map 1:1:

- **User-goal-level** goals carry their value pairing **inline**, inside the `Use Case N` that delivers them (the `**Operator value**` today/post-task block).
- **Sub-function-level** goals are consumed by multiple use cases; their value lives **doc-level in the goals table**, whose `Where` cell points at an artifact section rather than at a single `Use Case N`.

If a goal has no use-case or artifact home, you have found a scope gap. If a use case serves no goal, question it.

(When transcribing this section, use the spelled-out `Use Case N` label per the labeling convention below — see § File naming.)

## When to create a usecases doc

Create one when:

- **The operator-facing surface IS the value** (CLI flow, YAML/TOML schema change, new tool, UX change). The usecases doc makes the operator value legible apart from implementation depth.
- **Behavior branches on state** — best fit is operator-facing behavior with **branching state** (a CLI verb, a protocol, a UX flow) where "what will it do when…" questions keep coming up. The extensions tables are where that completeness lives.
- **The design doc is long enough that "what changes for the operator?" and "what does it do when…?" get buried.** If the design is 500+ lines, distill the value + behavior layer into a usecases doc.
- **Stakeholder buy-in matters** (PM, ops, exec, external operator). A 700-line design doc is a poor stakeholder artifact; the usecases doc is the readable one.
- **You want to anchor design conversations** to the operator outcome and observable behavior rather than the implementation.

Don't create one when:

- **Pure internal refactor** with no operator-facing surface change and no branching behavior to enumerate. The design doc's own sections carry it fine.
- **Bug fix** with no behavior change visible to the operator. Use the bug report itself + the results doc.
- **Spike / exploratory PoC** where the operator-facing flow isn't yet known. The usecases doc presupposes you can describe the post-task scenarios concretely — if you can't, you're not ready.

## When in the workflow

The usecases doc can land at **ANY break** in the pipeline — before design, after design, after plan, or mid-execution. The shape **never changes**. Only the **inputs** and **which QA passes can run** scale with what's on disk:

| Break | Inputs available | QA passes that can run |
|---|---|---|
| **Before design** (Stage 0 → 1) | operator notes, feature spec, stakeholder ask | none yet — parity sweep and cohesion pass are deferred (no normative vocabulary exists to grep against) |
| **After design** (Stage 1 → 0 distillation) | the design doc | vocabulary parity sweep + cohesion pass (design header pointer) |
| **After plan** (Stage 2 → 0 distillation) | design + plan | parity sweep over **both** design and plan vocabulary + cohesion pass (design + plan header pointers) |
| **Mid-execution** | design + plan (+ partial results) | same as after-plan |

The doc is descriptive and evergreen, so lateness costs nothing. Run `/dev-ready docs/[milestone-slug]-[task-slug]-usecases.md` at the Stage-0 break for a bounded readiness check (G1).

## How to draft (inputs differ by break)

**Before drafting, check what exists on disk** — `docs/[milestone-slug]-[task-slug]-{design,plan}.md`. The input and the runnable QA passes depend on what's there. Three flows:

### Flow A — nothing exists yet (before-design)

There is no normative doc to distill; you produce the usecases doc *with* the operator, and it will later drive what the design must achieve.

1. **Walk the behavior first.** Organize current → proposed behavior as concrete scenarios with the operator, confirmed **one at a time** (a paced walkthrough — e.g. ~6 scenarios for a single verb). Do NOT manufacture details and do NOT punt to a discovery phase: the usecases doc *is* the operator's confirmation of direction, so the conversation that produces it is the work.
2. **Cluster confirmed scenarios by actor goal.** Those clusters are your use cases. Each happy-path cluster becomes a main success scenario (or co-equal A/B scenarios — see § Shape); each deviation (failure, edge state, skip, timeout) becomes an extension row.
3. **Draft value-first — goals table + artifact section BEFORE the use cases.** Use real portfolio data for the artifact (the operator supplies it or names the context for you to read). A goal with no use-case/artifact home is a scope gap; a use case serving no goal is questioned.
4. **Defer the QA passes.** The vocabulary parity sweep and the cohesion pass require normative vocabulary to grep against — there is none before design. They run later, when the design lands (Flow B).

### Flow B — design (and optionally plan) exists (distillation)

The design doc is the primary input; the usecases doc is a compression of its value + behavior layer.

1. **Read everything that exists end-to-end.** Design always; the plan too when present — its steps often name outcome vocabulary the design abstracts. Do not skim; value and outcome claims are scattered (Executive Summary, Current/Target State, Files to Modify, worked examples).
2. **Extract** the goals (and their goal levels), the real artifact, and the **outcome/action vocabulary** the design (and plan) name.
3. **Draft value-first**, same as Flow A step 3 — goals table + artifact section before the use cases — then write each `Use Case N`'s main success scenario and extensions using the **design's literal outcome vocabulary** (do not paraphrase named actions like a `refreshed` action).
4. **Run the vocabulary parity sweep** — the **highest-yield QA step**. Grep the design's (and plan's, if present) outcome/action vocabulary against the usecases doc: **every named action must appear in some main scenario or extension row.** A missing term means a missing extension row or an unnamed happy-path action — fix it.
5. **Run the cohesion pass across the family.** usecases → design → plan must agree:
   - The **design header** gets a `Use cases:` pointer line.
   - The **plan header blockquote** points at the usecases doc when the plan exists.
   - The usecases doc never contradicts the design — on disagreement, **design wins** and the usecases doc gets fixed (it is the descriptive twin). Grep shared terms across all docs that exist.

### Flow C — converting a legacy goal doc (mode 2)

Legacy `docs/[m]-[t]-goal.md` docs are inert history; convert them on demand. Conversion is **seeding, not completion** — goal docs lack scenario/extension material.

Field mapping:

| Legacy goal-doc field | Lands in usecases doc as |
|---|---|
| Each Goal statement | a row in `## Goals at a glance` (Goal one-sentence + pain) |
| Per-goal Current-usage / post-task-usage pair | a use case's `**Operator value**` today/post-task block **+ scenario seeds** |
| `## What the operator actually edits` | carried over nearly verbatim (real data, inline `# comment` rules) |
| Success Indicator sentence | the `**Success indicator**:` line under the goals table |

Because goal docs carry no branching behavior, each converted use case gets a **skeleton** with an explicit `[extensions TBD — walk with operator]` marker in the extensions table. **Operator re-confirmation is mandatory** — present the seeded draft and walk the missing scenarios/extensions before treating it as a real usecases doc. Output to `-usecases.md`; leave the original `-goal.md` in place.

### Closing step (all flows): operator confirmation

The usecases doc is the operator's expectation artifact — until they confirm it, downstream agents have no stable anchor to align against. After drafting (walk, distillation, or conversion), present the draft:

- If the operator pushes back on the goal count, the goal statements, the pain framing, a main scenario, an extension row, the artifact example, or the success indicator — revise and re-confirm.
- Once confirmed, the usecases doc becomes the reference for every subsequent stage. Each stage checks against it; none redefines the operator-facing target or behavior unilaterally.
- If expectations later change (mid-design, mid-execution, mid-anything), update the usecases doc explicitly and re-confirm (see § Evergreen rule).

**All flows produce the same doc shape** (see § Shape). Only the input changes.

## Evergreen rule

The usecases doc carries **no status metadata** (no versions, dates, "last updated"), **no risks list**, **no decisions log**, **no open-questions section** — those belong in the design doc. It describes the post-task state, which does not drift as the implementation evolves.

**Same-change-set ripple**: when behavior changes in the design, the usecases doc gets the ripple **in the same change set**. It is the **doc most likely to silently rot** — a design tweak that lands without the matching usecases update creates exactly the two-definitions drift the descriptive-twin contract exists to prevent. Treat a design-behavior edit and its usecases-doc edit as one atomic change.

## File naming

`docs/[milestone-slug]-[task-slug]-usecases.md`

`usecases` is **one word, no inner hyphen** (plural noun — the doc enumerates use cases). Same `[milestone-slug]-[task-slug]` convention as the design / plan / results docs; adjacent to its design doc in `docs/` so the cross-reference is mechanical.

Examples:
- `docs/core-auth-refactor-usecases.md`
- `docs/cloud-mcp-ui-usecases.md`
- `docs/integrations-slack-usecases.md`

**Heading convention** (Decisions Log override of the exemplar's mixed labeling): use cases are spelled out as `## Use Case N — [name]` — H2, em-dash before the name. **Never `UC-N`** (the abbreviation is rejected; this is the only line in this guide that mentions it). Keep the enumeration even at N=1: a use case is a named structured unit (scenario + extensions), the label is an address (the goals-table `Where` column points at it by this exact form), and growth to the next use case stays a clean append.

## Shape

Five sections, in this exact reading order — the order **is** the method:

1. **Header table** — `Created` (run `date "+%Y-%m-%dT%H:%M:%S%z"`, never guess), `Task`, `Role` line pinning the doc-family contract: "subsumes the Stage-0 goal layer; `[m]-[t]-design.md` is normative — behavior questions land here, spec questions land in design" (the link is forward-looking when the doc is written before the design exists).
2. **`## Goals at a glance`** — one row per goal: `# | Goal (one sentence) | Current pain (quantified) | Where`. Quantify the ritual (count the steps, multiply by frequency — "4-step ritual × ~6 panes × ~6 projects", not "it's annoying"). The `Where` cell points at a `Use Case N` (user-goal-level) or an artifact section (sub-function-level). Close with a `**Success indicator**:` one-observable-sentence line. **This section IS the goal doc, compressed.**
3. **`## What the operator actually edits — [App/Context]`** — the REAL artifact with REAL data from the repo, inline `# comments` explaining each choice. Not a schema, not pseudo-config. This is the **confirmation anchor**: the operator looks at it and says "yes, that's the file I want to write." Omit the whole section only when the task has no operator-edited artifact.
4. **One section per use case** — `## Use Case N — [verb / actor-goal name]`, each carrying:
   - **Goal** — one line, the actor's goal (not the feature name).
   - **Operator value** — *Today* (current flow + specific pain, tied back to the goals table) vs *Post-task* (proposed flow), with paste-able commands.
   - **Main success scenario** — numbered flow of the happy path; name the system's outcome vocabulary explicitly (literal design terms, no paraphrase). **A/B variant**: when a use case has **co-equal happy paths under one actor goal** (same actor intent, system-detected branch), write them as `**Main success scenario A — [name]**` / `**Main success scenario B — [name]**`, each with its firing condition in a trailing parenthetical; the decision tree becomes **required** and routes every observed state to a lettered scenario or an extension row; lettered scenarios are referenceable from extension rows and other use cases ("scenario A's line"). Alternate-success extension rows remain the default for non-co-equal paths — reserve letters for genuinely co-equal headline paths; secondary or conditional successes stay extensions.
   - **Decision tree** (optional; required in the A/B variant) — when behavior branches on observed state *before* the main flow, a compact tree beats prose.
   - **Extensions** table — `Scenario | Trigger | Outcome` rows for every deviation (failures, edge states, skips, timeouts). **This is where completeness lives.**
5. **`## One-sentence contract`** — the entire doc compressed to ONE sentence over all use cases. **If you cannot write it, the use cases are not coherent yet** — reconcile before closing.

**Single-use-case degenerate form** (N=1): keep `## Use Case 1` (the enumeration stays, per the heading convention). The goals table collapses to one row, or drops to a single bolded goal sentence. Keep the `**Success indicator**:` line either way.

## Template

Copy from `~/.claude/skills/dev/assets/templates/0-usecases.md` (multi-use-case form by default; collapse to the single-use-case degenerate form per § Shape if N=1). The template carries the five-section shape, the labeling note, and the degenerate-form note inline.

## Best Practices

- **Cross-link to the design doc; do NOT duplicate.** The usecases doc says *what changes for the operator and what the system does*. The design doc says *how to build it*. If you find yourself writing a schema or a class signature, move it to the design.
- **Use real data, not synthetic examples.** A TOML example with a real project_id reads as concrete; the same TOML with `project_id = "my-project-id"` reads as theoretical. Synthetic placeholders stay in the design, never in the artifact section.
- **Quote the pain, don't paraphrase.** If a fix doc says "~30 min/app", cite that number with a source. Quantify the ritual — count steps, multiply by frequency. Specific numbers anchor the value claim.
- **Inline knowledge in code-block `# comments`.** Operator-knowledge that doesn't fit the schema (reward-placeholder caveats, "no Default declared today" warnings) goes inside the code block, not in a separate paragraph below it.
- **Name the design's outcome vocabulary literally.** If the design defines an action like `refreshed`, use the literal term in the scenario and extension rows — paraphrasing breaks the parity sweep and the cohesion contract.
- **The parity sweep is the highest-yield QA step.** When a design (and/or plan) exists, grep its outcome/action vocabulary against the usecases doc before closing. It is the cheapest way to find a missing extension row.
- **Respect goal levels.** Don't promote a sub-function-level goal to its own top-level use case — its value belongs doc-level in the goals table pointing at the artifact section.
- **Keep it evergreen.** No status, no risks/decisions/open-questions. The usecases doc describes the post-task state; ripple design-behavior changes in the same change set.

## Common Pitfalls

Inherited from the goal doc:
- **Implementation creep**: schemas, signatures, validation rules, API specs slip in. Symptom: a reader can't tell whether they're reading value/behavior or the design. Fix: extract every implementation detail; replace with operator-observable behavior.
- **Hypothetical examples**: a config path with `project_id = "my-project"` that anchors to nothing real. Fix: use a real app from the actual portfolio.
- **Pain-paraphrase**: "Operators find this tedious" instead of "~30 min/app" or "4-step ritual × ~6 panes". Fix: pull specific numbers and concrete commands from incident reports, fix docs, or operator interviews.
- **Status / version metadata**: "v1.2 — updated YYYY-MM-DD". Symptom: the doc reads as a tracker. Fix: the design doc handles versioning; the usecases doc is evergreen.

New to the usecases doc:
- **User-story drift**: scenarios written as "As an operator I want X so that Y". That's the agile form, not a use case. Fix: rewrite as actor + system interactions — main success scenario + extensions.
- **Flat-scenario-list drift**: a bare list of scenarios with no goal grouping. A scenario is one path; a use case is the goal plus all its paths. Fix: cluster scenarios by actor goal; each cluster is a use case with one main scenario + extension rows. The sanctioned A/B variant (§ Shape) is NOT this drift — use-case *boundaries* stay clustered by actor goal; A/B only relaxes the writing convention inside one goal. The drift symptom returns as **letter inflation**: a scenario C/D for paths that aren't co-equal (the exemplar granted two letters and deliberately kept a third success-ish path as an extension row).
- **Normative creep**: the usecases doc starts dictating *how* (schemas, signatures) or contradicting the design. Fix: it is descriptive — on disagreement, design wins and the usecases doc gets corrected.
- **Goal-level confusion**: a sub-function-level goal promoted to a top-level use case (or a user-goal-level win buried in the goals table). Fix: user-goal-level → inline in a use case; sub-function-level → doc-level goals table pointing at the artifact section.
- **Unnamed outcome vocabulary**: the main scenario paraphrases the design's action names ("the pane gets updated" instead of the literal `refreshed`). Symptom: the parity sweep finds the design term with no match in the usecases doc. Fix: use the literal design term.

## Verification Checklist

Before considering the usecases doc done:

**Shape**
- [ ] Five sections present, in order: Header table → Goals at a glance → What the operator actually edits → Use Case N sections → One-sentence contract
- [ ] Header table has `Created` (via `date`), `Task`, `Role` line with the subsumes-the-goal-layer / design-is-normative contract
- [ ] `## Goals at a glance` table present; each row has a quantified pain and a `Where` cell pointing at a `Use Case N` or artifact section; `**Success indicator**:` line present
- [ ] Each use case is `## Use Case N — [name]` (spelled out, em-dash; abbreviation rejected); enumeration kept even at N=1
- [ ] `## One-sentence contract` written — "if you can't write it, the use cases aren't coherent yet"
- [ ] NO status metadata, NO risks / decisions log / open questions

**Per-use-case content**
- [ ] Each use case has a one-line **Goal** (actor's goal, not the feature name)
- [ ] Each use case has an **Operator value** today/post-task block, tied back to the goals table
- [ ] Each use case has a numbered **Main success scenario** using the design's literal outcome vocabulary (or co-equal `Main success scenario A/B — [name]` scenarios per § Shape, decision tree present showing which fires)
- [ ] Each use case has an **Extensions** table covering every deviation (failures, edge states, skips, timeouts)

**Doc-level content**
- [ ] Artifact section uses real portfolio data (not synthetic placeholders)
- [ ] Success indicator is observable, not metric-shaped

**QA (when a design exists)**
- [ ] **Vocabulary parity sweep** run: every design-named (and plan-named, if present) action appears in some main scenario or extension row
- [ ] **Cohesion pass** run: design header carries the `Use cases:` pointer; plan header blockquote points at the usecases doc when the plan exists; usecases never contradicts the design

## Cross-references

- `1-design-guide.md` — Stage 1 guide; the usecases doc's natural partner. Each use case's main success scenario + extensions is the operator-facing behavior the design's Target State must align with; the cohesion pass adds the design's `Use cases:` pointer line.
- `~/.claude/skills/dev/SKILL.md` — workflow overview; registers Stage 0 in the Quick Reference, Optional Commands, State Detection, and File Naming Conventions sections.

## Next Stage

→ Stage 1: Design (use `references/1-design-guide.md`)

Once the usecases doc is confirmed, proceed to Stage 1 with it as the alignment anchor. Optionally run `/dev-ready docs/[milestone-slug]-[task-slug]-usecases.md` at this break for a bounded readiness check — it resolves the **G1** gate (a light de-risking judgment: are the high-risk issues that would shape the design de-risked, or is a spike warranted first?). See `references/ready-guide.md`.
