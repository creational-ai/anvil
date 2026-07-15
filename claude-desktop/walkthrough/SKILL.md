---
name: walkthrough
description: >
  Operator-facing, pedagogical walkthrough of a document — paces you
  unit-by-unit, elaborating each unit from five angles (plain English,
  motivation, diagram, before/after state delta, usage) and advancing on
  natural-language confirmation. Use whenever the user asks to be walked
  through a doc, says "walkthrough", wants a design/plan/vision/architecture
  document explained section by section, asks "help me understand this doc",
  wants to review a document at a comfortable pace, or asks to visualize
  what a design or plan actually does — even if they don't say "walkthrough"
  explicitly. Works on uploaded files, pasted documents, project files, and
  docs fetched via connected tools. Read-and-elaborate only; never edits the
  target document.
---

# walkthrough

Operator-facing, pedagogical walkthrough of a document — paces the operator unit-by-unit, elaborating each unit from five angles and advancing on natural-language confirmation.

**Version**: 1.0.0

**Guide**: `references/walkthrough-guide.md` — the source of truth for all behavior. Read it before the first unit renders.

> **Lineage**: Claude Desktop port of the Anvil Claude Code `/walkthrough` command (`claude-code/review/commands/walkthrough.md` + `review/references/walkthrough-guide.md`). The five-angle elaboration, 3-tier adaptive vocabulary, unit extraction, and advance semantics are ported intact; input handling and Angle-3 rendering are adapted for the Claude Desktop surface. A behavior change in one version should be considered for the other.

## Input

- **Document (required)**: an uploaded file, pasted content, a project file, or a doc fetched via connected tools (Drive, filesystem MCP, etc.)
- **Notes (optional)**: free-form focus areas the operator wants emphasized (e.g., "focus on the migration path")

No flags, no modes. Walkthrough is strictly read + elaborate; it never writes to or edits the target document.

## Process

1. Read `references/walkthrough-guide.md`
2. Acquire the document (uploaded / pasted / fetched) + optional notes
3. Detect doc type — filename pattern first, content cues as fallback
4. Detect the unit term via 3-tier adaptive vocabulary (heading-pattern scan → doc-type default → generic "Section")
5. Extract units at the detected dominant heading depth (or H2 boundaries when Tier 1 is inconclusive)
6. Load review context if a companion `-review.md` is available
7. For each unit in order: render the five angles, pause on a minimal `Ready for {Term} {N+1}?` prompt, interpret the operator's natural-language response
8. On exit signal or final unit: render summary (`Walked through {K} of {Total} {term}s`), end

Read the guide. Follow it exactly.
