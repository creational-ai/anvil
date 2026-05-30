# Goal Doc Guide (Stage 0)

## Purpose

A **goal doc** is the **lean expectation doc** for a task. It answers two questions:

1. **What are the goals?** — one declarative sentence per goal.
2. **What changes for the operator?** — per-goal current usage (today) vs. post-task usage (after this ships).

A task may have one goal or several. Multi-goal docs enumerate `### Goal 1`, `### Goal 2`, … under a single `## Goals` H2; single-goal docs use a flat `## Goal` H2 with no enumeration (see § Shape).

It has **two audiences, both load-bearing**:

- **The operator**, who uses it to confirm the direction of the task before the team commits to it.
- **Downstream agents** — design → review → plan → review → execute → monitor — who use it as a fixed alignment anchor across the entire dev pipeline. One confirmed set of goals, one shared expectation, no per-stage drift.

It is NOT a design doc. It carries no schemas, no signatures, no API specs, no risks list, no decisions log. Those live in `docs/[milestone-slug]-[task-slug]-design.md` (Stage 1). The goal doc is the *why-it-matters* layer; the design doc is the *how*.

A reader should be able to absorb the goal doc in under two minutes and walk away knowing:
- What this task delivers (one declarative sentence per goal)
- What today's pain looks like, per goal (with specifics)
- What the post-task flow looks like, per goal (with concrete commands)
- What "done" looks like (one observable sentence)

## When to create a goal doc

Create one when:

- **Feature tasks where the operator-facing surface IS the value** (CLI flow, YAML/TOML schema change, new tool, UX change). Goal doc makes the operator value legible apart from implementation depth.
- **The design doc is long enough that "what changes for the operator?" gets buried.** If the design doc is 500+ lines, distill the operator-value layer into a goal doc.
- **Stakeholder buy-in matters** (PM, ops, exec, external operator). A 700-line design doc is a poor stakeholder artifact.
- **You want to anchor design conversations** to the operator outcome rather than the implementation. The goal doc as a Stage 0 input keeps the design honest.
- **The task delivers multiple operator-visible improvements that are independently valuable** — multi-goal docs let stakeholders scan each value piece without re-reading.

Don't create one when:

- **Pure internal refactor** with no operator-facing surface change (no new CLI, no YAML change, no UX delta). The design doc's executive summary is enough.
- **Bug fix** with no behavior change visible to the operator. Use the bug report itself + the results doc.
- **Spike / exploratory PoC** where the operator-facing flow isn't yet known. The goal doc presupposes you can describe the post-task user flow concretely — if you can't, you're not ready.
- **The "post-task usage" would just repeat the CLI's `--help` output.** That means the goal isn't operator-facing enough to need its own doc.

## When in the workflow

The goal doc can land at either of two points, both legitimate:

| Timing | Use case | Example |
|---|---|---|
| **Before design** (Stage 0 → Stage 1) | Stakeholder-alignment artifact that drives what the design should achieve. PM/operator writes it; design absorbs the goals as constraints. | New feature with multiple competing approaches — goal doc fixes the operator-facing target before the design weighs options. |
| **After design** (Stage 1 → Stage 0 distillation) | Communication artifact extracted from an already-thought-through design. Useful when the design grew organically and the operator-value layer needs to be made re-readable on its own. | Refactor that delivers multiple independent operator-facing wins (e.g., decouple-from-X + new CLI surface + format upgrade) — distillation makes each Goal's before/after re-readable on its own. |

Both flows are valid. The doc shape doesn't change based on timing.

## How to draft (inputs differ by timing)

**Before drafting, check whether `docs/[milestone-slug]-[task-slug]-design.md` exists.** The input to the goal doc depends on what's there.

### If the design doc exists (after-design distillation)

The design doc is the primary input. The goal doc is a compression of its operator-facing layer.

1. Read the design doc end-to-end. Do not skim — the operator-value claims are scattered (Executive Summary, Current State, Target State, Files to Modify, worked examples).
2. **Identify how many goals**: list every distinct operator-facing improvement the design delivers. If they cluster naturally into one frame, single-goal form. If each is independently valuable (could ship alone and still help the operator), multi-goal form.
3. Extract per goal:
   - **Goal statement**: one declarative sentence — what this goal brings about. No qualifications, no implementation hints.
   - **Current Usage**: today-flow specific to this goal. Code block if today has concrete commands; prose if today's reality is "destructive in-place edit" or "doesn't exist yet"; omit if this goal is a brand-new capability with no today-state.
   - **Post-Task Usage**: the operator-facing flow for this goal, as paste-able commands or UI steps. Optional properties bullets for safety/precedence/cross-goal references.
4. Extract once at doc level:
   - **What the operator actually edits**: if the design references a real config file or YAML/TOML edit, use real portfolio data from the project (look in `placements/`, `configs/`, etc.). If the design used synthetic placeholders, you MUST find real data to ground the goal doc — synthetic stays in the design, not the goal.
   - **Success Indicator**: one observable sentence derived from the design's Success Criteria (not a copy of the checklist).
5. Cross-link to the design doc in the introductory blockquote.
6. **Do NOT duplicate design content.** Schemas, signatures, validation rules, risks, decisions — all stay in the design. The goal doc owns the operator-visible layer only.

### If the design doc does NOT exist (before-design alignment artifact)

The goal doc is a forward-looking spec; it will drive what the design has to achieve.

1. Work from whatever input does exist — feature spec, operator notes, stakeholder ask, fix doc, bug report.
2. **When context is missing, work it out with the operator.** Ask the questions the doc requires answers to — what are the distinct operator-facing wins (one goal or several?), what's today's flow per goal, where's the specific pain, what should the post-task flow look like per goal, which app or context grounds the concrete-edit example. The operator's answers are the input. Do NOT manufacture details and do NOT punt to a discovery phase or design draft: the goal doc *is* the operator's confirmation of direction, so the conversation that produces it is the work.
3. Use real portfolio data for the concrete artifact example — the operator either supplies it or names the context for you to read.
4. Cross-link to the (future) design doc in the blockquote. The link is forward-looking; the file doesn't need to exist yet (see Best Practices for the Stage-0-before-Stage-1 link rule).
5. When the design is later drafted, the design absorbs the goals as constraints. The goal doc shouldn't need to be rewritten unless the design changes the operator-facing target — if it does, update the goal doc and re-confirm with the operator.

### Closing step (both flows): operator confirmation

The goal doc is the operator's expectation artifact — until they confirm it, downstream agents have no stable anchor to align against. After drafting (distillation or alignment), present the draft to the operator:

- If they push back on the goal count, the goal statements, the pain framing, the post-task flows, the concrete-edit example, or the success indicator — revise and re-confirm.
- Once confirmed, the goal doc becomes the reference for every subsequent stage (design → review → plan → review → execute → monitor). Each stage checks against the goal doc; none of them redefines the operator-facing target unilaterally.
- If the operator's expectations later change (mid-design, mid-execution, mid-anything), update the goal doc explicitly and re-confirm. Never let the goal doc drift silently — that breaks the alignment contract.

**Both flows produce the same doc shape** (see § Shape). Only the input changes.

## File naming

`docs/[milestone-slug]-[task-slug]-goal.md`

Same `[milestone-slug]-[task-slug]` convention as the design / plan / results docs. Adjacent to its design doc in `docs/` so the cross-reference is mechanical.

Examples:
- `docs/core-auth-refactor-goal.md`
- `docs/cloud-mcp-ui-goal.md`
- `docs/integrations-slack-goal.md`

## Shape

The doc has three required H2 sections. The first H2 contains the per-goal content (one H3 per goal in multi-goal form, or flat content in single-goal degenerate form).

### Required H2 sections (in order)

1. **`## Goals`** (multi-goal) OR **`## Goal`** (single-goal degenerate form) — the per-goal content
2. **`## What the operator actually edits — [App/Context] as concrete example`** — doc-level concrete artifact
3. **`## Success Indicator`** — one observable sentence

No `## Operator pain delta` table — the per-goal Current/Post-Task pairs ARE the rollup. Don't add it back.
No `## Open Questions` / `## Risks` / `## Decisions Log` — those belong in the design doc.
No status metadata (versions, dates, "last updated") — the goal doc is evergreen.

### Multi-goal form (N ≥ 2)

```markdown
## Goals

[1-2 sentence opening framing — what unifies these goals.]

### Goal 1: [Short name]

[One declarative sentence.]

**Current Usage (today)**:
[code block OR prose; optional if new-feature with no today-state]
[brief prose explanation]

**Post-Task Usage**:
```bash
[concrete commands]
```
[brief prose explanation]
- [optional properties bullet]
- [optional another property]

### Goal 2: [Short name]
[same per-goal shape]

### Goal N: [Short name]
[same per-goal shape]
```

### Single-goal degenerate form (N = 1)

```markdown
## Goal

[One declarative sentence — what this task brings about.]

**Current Usage (today)**:
[code block OR prose; optional if new-feature with no today-state]
[brief prose explanation]

**Post-Task Usage**:
```bash
[concrete commands]
```
[brief prose explanation]
- [optional properties bullet]
```

No `### Goal 1: name` enumeration. The H2 itself names the goal-bearing scope; the declarative sentence under it carries the goal statement.

### Per-goal pattern

Inside each `### Goal N` (multi-goal) or directly under `## Goal` (single-goal):

| Element | Required? | Notes |
|---|---|---|
| One declarative sentence | yes | What this goal brings about. No qualifications. |
| `**Current Usage (today)**:` block | optional per goal | Drop if this goal is a brand-new capability with no today-state. Otherwise: code block OR prose, whichever lands the today-state most clearly. |
| `**Post-Task Usage**:` block | **REQUIRED** per goal | Always present. Always includes a code block showing concrete commands. |
| Properties bullets (under Post-Task) | optional | 1-3 bullets for safety/precedence/cross-goal references. Shared properties live under the first goal that introduces them; later goals back-reference (e.g., "(see Goal 2 for the full walkup)"). |

**Post-Task Usage is mandatory per goal.** No exceptions — if you can't describe the post-task flow for a goal, you don't have a goal yet; resolve that before writing.

## Template

Copy from `~/.claude/skills/dev/assets/templates/0-goal.md` (multi-goal form by default; collapse to single-goal degenerate form per § Shape if N=1).

## Best Practices

- **Cross-link to the design doc; do NOT duplicate.** The goal doc says *what changes for the operator*. The design doc says *how to build it*. If you find yourself writing a schema or a class signature in the goal doc, move it to the design.
- **Use real data, not synthetic examples.** A TOML example with `secret_key = "${LP_SECRET_KEY}"` and a real Hexar.io BQ project_id reads as concrete. The same TOML with `secret_key = "${SOME_KEY}"` and `project_id = "my-project-id"` reads as theoretical.
- **Quote the pain, don't paraphrase.** If a related fix doc says "~30 min/app", cite that number with a source link. Specific numbers anchor the value claim.
- **Inline knowledge in YAML/TOML comments.** Operator-knowledge that doesn't fit the schema (reward placeholder caveats, "no Default declared today" warnings) goes in `# comments` inside the code block, not in a separate paragraph below it.
- **Current Usage code block is optional per goal** — code when commands are concrete, prose when today's reality is "doesn't exist" or "destructive in-place edit", omit when the goal is a brand-new capability. Don't force a code block for visual symmetry; prose can be the honest answer.
- **Post-Task Usage code block is mandatory per goal** — no exceptions. If you can't write the concrete commands, you don't have a goal yet.
- **Cross-goal property ownership**: a property mentioned in multiple goals lives under the first goal that introduces it. Later goals back-reference (e.g., "(see Goal 2)"). Don't duplicate properties across goal blocks.
- **Doc-level "What the operator actually edits" rolls up across goals** — don't duplicate the same artifact example per goal. The doc-level section is the unified concrete artifact; per-goal Post-Task code blocks show the goal-specific commands/flows.
- **Lean per goal**: target 30-50 lines per goal block (declarative sentence + Current Usage block + Post-Task block + bullets). Total doc length scales with goal count; a 4-goal doc landing at 180-200 lines is normal.
- **Single-goal degenerate form** when N=1: flat `## Goal` (no `s`, no enumeration). Don't pay the H2+H3 ceremony for a single goal.
- **Status metadata stays out.** No "Last updated: YYYY-MM-DD" headers, no version numbers, no author lists. The goal doc is evergreen — it describes the post-task state, which doesn't drift even as the implementation evolves. (Exception: a one-line note in the introductory blockquote pointing to the design doc.)
- **No decisions log, no risks list, no open questions.** These belong in the design doc. The goal doc is operator-facing communication, not implementer-facing record-keeping.
- **Stage-0-before-Stage-1 case**: if you're writing the goal doc *before* the design doc exists, the introductory blockquote's design-doc link is still correct — it points to where the design will land. The link is a forward-looking reference, not a verification.

## Common Pitfalls

- **Goal-count creep**: every operator-visible property gets promoted to its own goal. Symptom: 7+ goals, redundant Current/Post-Task pairs. Fix: merge goals that share a today-state and a post-task flow; promote only independently-valuable improvements.
- **Goal-count under-counting**: a doc with one mega-goal that bundles 4 distinct operator-facing wins. Symptom: a single Goal whose Post-Task Usage has 6 sub-bullets covering disparate flows. Fix: split into separate goals; let each get its own Current/Post-Task pair.
- **Implementation creep**: schemas, signatures, validation rules, API specs slip into the goal doc. Symptom: a reader can't tell whether they're reading the goal or the design. Fix: extract every implementation detail; replace with operator-observable behavior.
- **Hypothetical examples**: `~/.adingest/my-app/config.toml` with `[bq] project_id = "my-project"`. Symptom: the example doesn't anchor to real portfolio reality. Fix: use a real app from the project's actual portfolio.
- **Pain-paraphrase**: "Operators find this tedious" instead of "~30 min/app" or "edit `.env.client` in place + remember to revert." Symptom: the today-state reads as opinion rather than fact. Fix: pull specific numbers and concrete commands from incident reports, fix docs, or operator interviews.
- **Duplicating doc-level artifact in per-goal Post-Task blocks**: the same full TOML/YAML file appears under one goal AND under "What the operator actually edits". Symptom: reader sees the same content twice. Fix: per-goal Post-Task shows a small excerpt anchoring the goal-specific pattern; doc-level shows the full artifact.
- **Reintroducing the Operator pain delta table in multi-goal docs**: the table re-states what's already in the per-goal Current/Post-Task pairs. Symptom: doc grows; rows duplicate goal content. Fix: drop the table; per-goal pairs ARE the rollup.
- **Design-doc duplication**: success criteria list copied from design's Success Criteria section. Symptom: goal doc grows toward 200+ lines of design content. Fix: success criteria belong in design; goal doc has a single Success Indicator sentence.
- **Status/version metadata**: "v1.2 — updated YYYY-MM-DD". Symptom: the doc reads as a tracker. Fix: the design doc handles versioning; the goal doc is evergreen operator-value.

## Verification Checklist

Before considering the goal doc done:

**Shape**
- [ ] Introductory blockquote (Purpose / Design / This doc)
- [ ] First H2 is `## Goals` (multi-goal) OR `## Goal` (single-goal degenerate form)
- [ ] If multi-goal: each goal is `### Goal N: name` with sequential numbering starting at 1
- [ ] If single-goal: NO `### Goal 1:` H3 (flat content under `## Goal`)
- [ ] `## What the operator actually edits — [App/Context]` H2 present
- [ ] `## Success Indicator` H2 present
- [ ] NO `## Operator pain delta` table (drop if present from old shape)
- [ ] NO `## Open Questions` / `## Risks` / `## Decisions Log`

**Per-goal content**
- [ ] Each goal has a one-sentence declarative statement
- [ ] **Each goal has a `**Post-Task Usage**:` block with a code block (REQUIRED — no exceptions)**
- [ ] Each goal has a `**Current Usage (today)**:` block OR explicit omission for new-feature goals
- [ ] Shared properties live under the first goal that introduces them; later goals back-reference

**Doc-level content**
- [ ] Concrete artifact example uses real portfolio data (not synthetic placeholders)
- [ ] Success Indicator is observable, not metric-shaped
- [ ] Cross-link to the design doc in the introductory blockquote

**Discipline**
- [ ] Zero implementation details (schemas, signatures, validation rules, API specs)
- [ ] Zero status metadata (versions, dates, author lists, "last updated")
- [ ] Per-goal lean: each goal block under ~50 lines

## Cross-references

- `1-design-guide.md` — Stage 1 guide; the goal doc's natural partner doc. Each Goal's "Post-Task Usage" is the operator-facing target the design's Target State must align with.
- `~/.claude/skills/dev/SKILL.md` — workflow overview; registers Stage 0 in the Quick Reference, Optional Commands, State Detection, and File Naming Conventions sections.

## Next Stage

→ Stage 1: Design (use `references/1-design-guide.md`)

Once the goal doc is confirmed, proceed to Stage 1 with it as the alignment anchor. Optionally run `/dev-ready docs/[milestone-slug]-[task-slug]-goal.md` at this break for a bounded readiness check — it resolves the **G1** gate (a light de-risking judgment: are the high-risk issues that would shape the design de-risked, or is a spike warranted first?). See `references/ready-guide.md`.
