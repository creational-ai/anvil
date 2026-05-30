---
description: Create or update a goal doc (Stage 0, optional). Operator-facing target. Runs in main conversation.
argument-hint: [notes-or-slug-or-goal-doc-path] [update]
disable-model-invocation: true
---

# /dev-goal

Create or update a goal doc for a task (Stage 0 of dev workflow — optional).

## What This Does

Stage 0 of dev: Capture the **operator-facing target** for a task as a lean expectation doc. Two audiences, both load-bearing:

- **The operator**, who confirms direction before the team commits.
- **Downstream agents** (design → review → plan → review → execute → monitor), who use it as a fixed alignment anchor across the pipeline.

A goal doc is NOT a design doc — it carries no schemas, no signatures, no risks list, no decisions log. Those live in `docs/[milestone-slug]-[task-slug]-design.md`.

## Resources

**Read these for guidance**:
- `~/.claude/skills/dev/SKILL.md` - See "Stage 0: Goal (Optional)" section
- `~/.claude/skills/dev/references/0-goal-guide.md` - Detailed process (when to create, two timing flows, sections, anti-patterns)
- `~/.claude/skills/dev/assets/templates/0-goal.md` - Goal doc template (multi-goal: `## Goals` + `### Goal N` enumeration; single-goal degenerate form: flat `## Goal`)

## Input modes

Stage 0 supports three input modes. **In mode 1, notes MUST begin with `<milestone-slug>-<task-slug>:`** so the output path `docs/[milestone-slug]-[task-slug]-goal.md` is unambiguous. If the prefix is missing, the command prompts the operator for the slug rather than guessing.

**Mode 1 — Notes only (before-design alignment artifact):**
- Argument: free-form notes describing the goal, must begin with `<milestone-slug>-<task-slug>:`.
- Example: `/dev-goal "core-placements: declare ad-slot placements per app as config-as-code with audit trail"`
- The command runs `0-goal-guide.md`'s before-design flow: works through the missing context interactively with the operator (today flow, specific pain, post-task flow, real portfolio data for the YAML example) and drafts the goal doc.

**Mode 2 — Existing goal doc + `update` (reformat to latest template + guide):**
- Argument: path to an existing goal doc, followed by `update`.
- Example: `/dev-goal docs/core-placements-goal.md update`
- The command reads the current template, the current guide, and the existing goal doc; restructures the existing doc to match the latest shape — preserving semantic content (goal statements, today-state, post-task flow, concrete artifact, success indicator) while updating structure. Detects single-goal vs multi-goal content automatically and uses flat `## Goal` form or enumerated `## Goals` + `### Goal N` form accordingly. Mirrors `/dev-design`'s update-mode pattern: preserve content, update structure. Re-confirms the reformatted draft with operator before writing per `0-goal-guide.md`'s Closing step.

**Mode 3 — Task slug with existing design doc (after-design distillation):**
- Argument: `<milestone-slug>-<task-slug>` where `docs/[milestone-slug]-[task-slug]-design.md` already exists.
- Example: `/dev-goal core-placements`
- The command runs `0-goal-guide.md`'s after-design distillation flow: reads the design doc end-to-end, compresses the operator-facing layer (Executive Summary, Current State / Target State / Files-to-Modify), and drafts the goal doc. Does NOT duplicate design content — schemas, signatures, risks stay in the design.

**User notes (optional, when invoked with `--notes`):**
```
{{notes}}
```

## Process

**Run in main conversation. Do NOT spawn a subagent or fork — Stage 0's operator-interactive collaboration loop requires the main conversation; no `/spawn-dev-goal` variant exists by design.** Follow `0-goal-guide.md` exactly. The guide branches on whether the design doc exists; both flows close with operator confirmation.

The command will:
1. Read the guide and template
2. Determine which input mode applies (notes-prefixed-with-slug / goal-doc-path + update / task-slug-with-existing-design)
3. Execute the matching flow from `0-goal-guide.md` (before-design alignment OR after-design distillation OR refresh-and-reconfirm)
4. Draft the goal doc using the template's goals-enumerated shape (or flat single-goal degenerate form if only one goal applies), with real portfolio data for the doc-level concrete artifact example. Each goal MUST have a Post-Task Usage block; Current Usage is optional per goal.
5. **Present the draft to the operator and obtain confirmation.** Until the operator confirms, downstream agents have no stable anchor. If the operator pushes back, revise and re-confirm.
6. Write to `docs/[milestone-slug]-[task-slug]-goal.md`

## Output

Create one document:
- `docs/[milestone-slug]-[task-slug]-goal.md`

**Examples**: `docs/core-placements-goal.md`, `docs/cloud-auth-fix-goal.md`, `docs/integrations-slack-goal.md`

## After Completion

User will proceed to Stage 1 (Design) with the confirmed goal doc as the alignment anchor.

Optionally run `/dev-ready docs/[milestone-slug]-[task-slug]-goal.md` at this break for a bounded readiness check — it resolves the **G1** gate (a light de-risking judgment: are the high-risk issues that would shape the design de-risked enough to proceed, or is a spike warranted first?). See `references/ready-guide.md`.
