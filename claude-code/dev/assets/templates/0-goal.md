# [Milestone-Slug]-[Task-Slug] Goal

> **Purpose**: High-level goal and operator-facing expectation for the [task name] task.
> **Design**: `docs/[milestone-slug]-[task-slug]-design.md` (the how)
> **This doc**: just the what and the before/after (the why-it-matters)

## Goals

[1-2 sentence opening framing — what unifies these goals. Drop this paragraph if there's only one goal and you're using the flat `## Goal` form below.]

### Goal 1: [Short name]

[One declarative sentence — what this goal brings about.]

**Current Usage (today)**:

[Code block OR prose, whichever lands the today-state most clearly. Code is preferred when commands are concrete. Prose is preferred when today's flow is "doesn't exist" or "destructive in-place edit" with no meaningful command. Omit entirely if the goal is a new feature with no today-state.]

[Brief prose explanation naming the specific operator pain.]

**Post-Task Usage**:

```bash
# [Step] — what this command does
[actual command the operator can paste]
```

[Brief prose explanation.]

- [Optional: safety/guard/precedence property the operator will experience]
- [Optional: another property; properties shared across goals live under the first goal that introduces them — later goals back-reference, e.g., "(see Goal 2 for the full walkup)"]

### Goal 2: [Short name]

[Same per-goal shape as Goal 1.]

### Goal 3: [Short name]

[Same per-goal shape as Goal 1.]

## What the operator actually edits — [App/Context] as concrete example

[One sentence: "This is what `[filepath]` would look like after `[trigger]`."]

```yaml
# [filepath]
[real example using real portfolio data — not synthetic "foo/bar/baz" placeholders]
[inline comments for operator-knowledge that doesn't fit the schema —]
[e.g., "# ⚠ no Default declared today — loader warns; operator decides."]
```

[Optional 1-2 short paragraphs compressing form-rules or conventions visible in the example.]

## Success Indicator

[One observable sentence — "Operator never opens X to do Y" or "Every change to Z is a git-diffable edit followed by W". Observable, not metric-shaped.]
