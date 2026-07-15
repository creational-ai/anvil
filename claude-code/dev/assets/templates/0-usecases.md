# [Milestone-Slug]-[Task-Slug] Use Cases

| Field | Value |
|---|---|
| **Created** | [run `date "+%Y-%m-%dT%H:%M:%S%z"` — never guess] |
| **Task** | [Task name] |
| **Role** | Operator-value + behavior companion — subsumes the Stage-0 goal layer; `[milestone-slug]-[task-slug]-design.md` is normative — behavior questions land here, spec questions land in design. (When this doc is written before the design exists, the normative link is forward-looking — same as the goal doc's design pointer.) |

---

## Goals at a glance

[1-2 sentence opening framing — what unifies these goals, and the goal-level read: which goals are user-goal-level (carried inline by a use case) vs. sub-function-level (value lives here in the table, pointing at an artifact section). Drop this framing if there is a single goal.]

| # | Goal (one sentence) | Current pain (quantified) | Where |
|---|---|---|---|
| 1 | [One declarative sentence — what this goal brings about, the actor's win.] | [Quantify the ritual: count the steps, multiply by frequency — e.g. "4-step ritual × ~6 panes × ~6 projects". Not "it's annoying" — a number.] | [`Use Case N` for user-goal-level goals, OR an artifact section (e.g. `§ What the operator actually edits`) for sub-function-level goals consumed by multiple use cases.] |
| 2 | [...] | [...] | [...] |

> **Single-goal degenerate form**: collapse this table to one row, OR drop the table entirely for a single bolded goal sentence. Keep the `**Success indicator**:` line either way.

**Success indicator**: [One observable sentence — "Operator never types X to do Y" or "Every change to Z is a git-diffable edit followed by W". Observable, not metric-shaped. This is the goal doc's success indicator, carried verbatim in spirit.]

---

## What the operator actually edits — [App/Context]

[One sentence: "This is what `[filepath]` would look like after `[trigger]`." This is the confirmation anchor — the operator looks at it and says "yes, that's the file I want to write."]

```yaml
# [filepath]
[real example using REAL data from the repo (actual config, actual values) — not synthetic "foo/bar/baz" placeholders]
[inline # comments for operator-knowledge that doesn't fit the schema —]
[e.g., "# ⚠ no Default declared today — loader warns; operator decides."]
```

[Optional 1-2 short paragraphs compressing form-rules or conventions visible in the example. Omit the whole section only when the task has no operator-edited artifact.]

---

## Use cases

[Intro: name the **Actor** (usually the operator, in what context) and the **System** (the CLI / verb / flow under design). State any **standing guarantees** that hold across every scenario below — invariants like "the verb always ends in a working state; failure degrades, never errors out". Omit the standing-guarantees list if there are none.]

> **Labeling**: use cases are numbered and spelled out — `## Use Case 1`, `## Use Case 2`, … (H2, em-dash before the name). Keep the enumeration even when there is only one use case — a use case is a named structured unit (scenario + extensions), so the ceremony pays for itself, and growth to the next use case stays a clean append. The goals-table "Where" column addresses these by the same spelled-out label.

---

## Use Case 1 — [verb / actor-goal name]

**Goal**: [One line — the actor's goal, not the feature name. "End up attached to the right pane", not "implement attach logic".]

**Operator value**:

*Today*: [The current flow and its specific pain — the today-state for this use case's slice, tied back to the goals table. Use prose, or a code block when the current commands are concrete.]

*Post-task*: [The proposed flow — what the operator does instead.]

```bash
# [proposed command(s) the operator can paste]
[actual command]      # what each branch produces, in one line
```

**Main success scenario** (the happy path):

```
[numbered or arrowed flow of the happy path]
[name the system's outcome vocabulary EXPLICITLY — if the design defines action/outcome
names (e.g. a `refreshed` action), use the literal term; do not paraphrase]
```

[Co-equal happy paths under one actor goal? Write `**Main success scenario A — [name]** (firing condition):` / `**Main success scenario B — [name]** (firing condition):` instead — the decision tree is then required and shows which fires; extensions carry only true deviations. Reserve letters for genuinely co-equal paths — secondary successes stay extension rows.]

**Decision tree** (optional — required in the A/B variant above; include otherwise only when behavior branches on observed state *before* the main flow; a compact tree beats prose here):

```
[trigger]
   ├─ [observed state A] ──► [scenario / outcome]
   └─ [observed state B] ──► [scenario / outcome]
```

**Extensions** (every deviation — failures, edge states, skips, timeouts; this table is where completeness lives):

| Scenario | Trigger | Outcome |
|---|---|---|
| [short name] | [the condition that fires it] | [the system's behavior — named with the design's outcome vocabulary] |
| [...] | [...] | [...] |

---

## Use Case 2 — [verb / actor-goal name]

[Same per-use-case shape as Use Case 1: **Goal** / **Operator value** (today vs post-task) / **Main success scenario** / optional **Decision tree** / **Extensions** table. Append further use cases the same way; delete this section entirely for a single-use-case task — but keep `## Use Case 1`.]

---

## One-sentence contract

[The entire doc compressed to ONE sentence — what every use case here guarantees, together. If you cannot write this sentence, the use cases are not coherent yet; go back and reconcile them before closing the doc.]
