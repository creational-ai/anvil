---
description: Create a concept doc for an existing design (optional companion) — a short, diagram-carried explainer that lets a person understand a design without reading it. Human audience, visual, deliberately not exhaustive.
argument-hint: <design-doc-path> [--notes "<text>"]
disable-model-invocation: false
---

# /dev-concept

Create a **concept doc** — the human-facing companion to an existing design doc.

## What This Does

A concept doc exists so **a person can understand a design without reading the design**. The design doc is written to be *correct* — exhaustive, precise, normative, long. The concept doc is written to be *understood* — by a human, in one sitting, mostly by looking at pictures.

Three properties, in priority order when they conflict:

1. **Human** — plain language, short sentences, no unexplained jargon.
2. **Visual** — diagrams carry the concept; prose only connects them.
3. **Focused** — one angle per section, four to eight sections. Completeness is the design's job; a concept doc that tries to cover everything has failed at being one.

**Illustrative, never normative.** The design doc stays the single normative source. On any disagreement the design wins and the concept doc is wrong. Nothing downstream consumes this doc, nothing is graded against it, and it gates no stage — so there is **no confirmation step and nothing waits on it**. It is a companion, not a stage.

## Resources

**Read these for guidance** (the method lives in the guide — this command is thin):
- `~/.claude/skills/dev/references/concept-guide.md` - Full method: the three properties, sizing, shape, diagram rules, drafting order, pitfalls
- `~/.claude/skills/dev/assets/templates/concept.md` - Header table, thesis, angle sections with diagram slots, closing boundary section

## Input

- **A design doc path** (required) — e.g. `/dev-concept docs/core-placements-design.md`.
- **Optional notes** (`--notes`) — which angles matter, who the reader is, what to leave out.

If no design doc path is given, do **not** guess and do **not** invent a design to illustrate. Ask for it.

**User notes (optional, when invoked with `--notes`):**
```
{{notes}}
```

## Process

**Execute inline — do NOT spawn a subagent or fork from here.** An agent may invoke this command directly; when it does, it *is* the background execution and writes the concept doc itself rather than delegating again. To hand the work off instead, spawn the `dev-concept-author` agent by `subagent_type`.

Follow `concept-guide.md` exactly. In short:

1. Read the design in full and `wc -l` it — that is the read-size for the header's `Illustrates` row (the ceiling is flat, not derived from it).
2. Run the **input-staleness pass** (check claims against the sources the design *cites*, not only against the design body), and flag any place the design **contradicts itself** as you compress. Report both; **reconcile neither** — the design is normative even when it disagrees with itself.
3. Write the thesis, choose four to eight distinct angles, then **draw first and write second** — prose-first produces prose with a decorative picture under it.
4. Cut to the ceiling, check the prose budget, then report.

**Size is a ceiling, not a target to fill** — the guide's **§ Size** sets it, and it is flat rather than relative to the design. If the design is too big to illustrate in that space, **narrow the concept doc's scope and say what you left out** — never grow past it. If your draft runs longer than the design, do not cut to match it — ask whether the doc should exist at all (see the guide's § When to create one).

**Prose is labelling, not explaining** — the guide's **§ Prose budget** sets the caps (lines before and after a diagram, longest unbroken run, and whole-doc prose-to-fence ratio). **Over budget means redraw, never write-it-tighter**: move the content into the picture — label the arrow, name the box, add a column, split into panels. Prose that survives a redraw is prose the diagram genuinely cannot hold.

**ASCII diagrams only, never mermaid.** Width ≤100 **characters** inside a fence — measure characters, not bytes.

## Output

Create one document:
- `docs/[milestone-slug]-[task-slug]-concept.md` — the design's own path with `-design` replaced by `-concept`

If the source doc does not follow that convention, mirror its basename (`<basename>-concept.md`) and say so in the report.

**Report**: the path written, line count against the guide's ceiling, the prose-budget figures against the guide's caps, angle count, anything deliberately left out, and any stale or self-contradicting claims found in the design (reported, not fixed).

## After Completion

Nothing is gated on this doc — hand it to whoever needed the orientation. It is a snapshot, so it goes stale when the design changes; the header's `Illustrates … @ N lines` row is what makes that visible.
