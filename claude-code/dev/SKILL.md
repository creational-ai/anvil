# dev

A structured 3-stage workflow (with optional Stage 0 alignment and opt-in Stage 3b review) for implementing tasks with production-grade quality.

## Hierarchy

```
Project (e.g., "mission-control")
├── Milestone (grouping layer, e.g., "core", "cloud")
│   ├── Task (e.g., "poc-1", "auth-feature", "fix-bug-42")
│   └── Task ...
└── Milestone (e.g., "integrations")
    └── Task ...
```

**Task Types:**
- **PoC** - Proof of Concept (validate technical approach)
- **Feature** - New functionality
- **Issue** - Bug fix
- **Refactor** - Code improvement

## Overview

This skill operates at the **Task level** — one task at a time through a 3-stage core workflow, optionally wrapped by Stage 0 (goal) and Stage 3b (conceptual review):

1. **Stage 1: Design** - Problem analysis and solution design (what and why)
2. **Stage 2: Planning** - Step-by-step breakdown
3. **Stage 3: Execution** - Actual implementation with tests

## Quick Reference

| Stage | Input | Output | Code? |
|-------|-------|--------|-------|
| 0. Goal (Optional) | Operator notes / design doc | `docs/[milestone-slug]-[task-slug]-goal.md` | ❌ NO |
| 1. Design | Bug/feature spec, user notes | `docs/[milestone-slug]-[task-slug]-design.md` | ❌ NO |
| 2. Planning | `docs/[milestone-slug]-[task-slug]-design.md` (recommended) | `docs/[milestone-slug]-[task-slug]-plan.md` | ✅ YES |
| 3. Execution | `docs/[milestone-slug]-[task-slug]-plan.md` | `docs/[milestone-slug]-[task-slug]-results.md` + code + tests | ✅ YES |

*All stages read `docs/[milestone-slug]-[task-slug]-goal.md` as optional alignment context when present (per each stage's guide). Listed inputs are primary contracts; goal.md is a soft secondary read.*

| Stage | Guide | Template |
|-------|-------|----------|
| 0. Goal | `references/0-goal-guide.md` | `assets/templates/0-goal.md` |
| 1. Design | `references/1-design-guide.md` | `assets/templates/1-design.md` |
| 2. Planning | `references/2-planning-guide.md` | `assets/templates/2-plan.md` |
| 3. Execution | `references/3-execution-guide.md` | `assets/templates/3-results.md` |
| 3b. Review (opt-in gate) | `references/review-guide.md` | `assets/templates/review.md` |

| Environment | Guide |
|-------------|-------|
| Python | `references/python-guide.md` |
| Unity | `references/unity-guide.md` |

| Utility | Template | Output |
|---------|----------|--------|
| `/dev-diagram <milestone-slug>-<task-slug>` | `assets/templates/diagram.md` | Inserts ASCII box into results doc |

## Optional Commands

Users can invoke stages explicitly via commands:
- `/dev-goal <notes>` - Start Stage 0
- `/dev-design <notes>` - Start Stage 1
- `/dev-plan <notes>` - Start Stage 2
- `/dev-execute <notes>` - Start Stage 3 (one step)
- `/dev-execute-run <plan> [--auto]` - Run all steps to completion (auto-finalize, `--auto` adds review-run + mc-update)
- `/dev-ready <doc>` - Run the readiness gate for a task (pass any of its docs; resolves the furthest-along break from docs on disk) — see Readiness Gates below
- `/dev-review <results-doc> <step>` - Review completed step against design
- `/dev-review-run <results-doc>` - Review all completed steps in parallel
- `/dev-finalize <milestone-slug>-<task-slug>` - Finalize task (timestamp, lessons, diagram, health check)
- `/dev-health` - Project health check
- `/dev-diagram <milestone-slug>-<task-slug>` - Generate ASCII diagram for task
- `/dev-milestone-summary <milestone-slug>` - Generate milestone summary

**Spawn commands** (run in background via subagents):
- `/spawn-dev-designer <notes>` - Design agent for Stage 1
- `/spawn-dev-planner <design-doc>` - Plan agent for Stage 2
- `/spawn-dev-executor <plan>` - Execute agent for Stage 3
- `/spawn-dev-reviewer <results-doc> <step>` - Review agent for conceptual review
- `/spawn-dev-finalizer <milestone-slug>-<task-slug>` - Finalize agent (timestamp + lessons + diagram + health)
- `/spawn-dev-milestone-summarizer <milestone-slug>` - Milestone summary agent

Or use natural language: "Create design for database abstraction", "Plan the implementation", "Execute step 1"

---

## Stage 0: Goal (Optional)

**Goal**: Capture the operator-facing expectation — one or more goals, each with its own today vs. post-task before/after. Confirmation artifact for the operator; alignment anchor for downstream agents.

**Code Allowed**: ❌ NO

**Optional**: This stage is opt-in. Create one when the operator-facing surface IS the value (per `0-goal-guide.md` §'When to create a goal doc'). Skip for pure refactors / bug fixes / spikes.

**Guide**: `references/0-goal-guide.md` | **Template**: `assets/templates/0-goal.md`

**Output**: `docs/[milestone-slug]-[task-slug]-goal.md`

**Dual audience**: Operator confirms direction; downstream agents (design → review → plan → review → execute → monitor) read it as alignment input when present.

**After completion**:
- *Before-design flow*: Operator confirms the draft, then runs `/dev-design` for Stage 1 — Stage 1 reads the goal doc as input context.
- *After-design distillation flow*: Operator confirms the draft. Downstream stages already in flight pick up the goal doc on their next activation.

---

## Stage 1: Design

**Goal**: Analyze problems and design solutions before implementation planning.

**Code Allowed**: ❌ NO full implementations. YES to conceptual patterns, signatures, diagrams.

⚠️ **Stage 1 is strictly a NO-CODE zone.** See guide for what is/isn't allowed.

**Guide**: `references/1-design-guide.md` | **Template**: `assets/templates/1-design.md`

**Output**: `docs/[milestone-slug]-[task-slug]-design.md`

**Structure**: Part A (Analysis — each item independently) + Part B (Proposed Sequence — #1 → #2 → #3)

**After completion**: User reviews, runs `/review-doc`, then requests Stage 2.

---

## Stage 2: Planning

**Goal**: Break down a single task into bite-sized, production-grade implementation steps.

**Code Allowed**: ✅ YES — Step 0/Prerequisites: concrete commands. Steps 1+: spec-driven (behavior, acceptance criteria, no code blocks).

**Guide**: `references/2-planning-guide.md` | **Template**: `assets/templates/2-plan.md`

**Input**: `docs/[milestone-slug]-[task-slug]-design.md` (recommended) | **Output**: `docs/[milestone-slug]-[task-slug]-plan.md`

**Key rules**: Production-grade (OOP, validated models, typing). Self-contained (add alongside, don't replace). Each step includes its tests.

**After completion**: User reviews, runs `/review-doc`, then requests Stage 3.

---

## Stage 3: Execution

**Goal**: Implement the current task one step at a time.

**Code Allowed**: ✅ YES — Full implementation.

**Guide**: `references/3-execution-guide.md` | **Template**: `assets/templates/3-results.md`

**Input**: `docs/[milestone-slug]-[task-slug]-plan.md` | **Output**: `docs/[milestone-slug]-[task-slug]-results.md` + code + tests

**Key rules**:
- ⚠️ ONE STEP THEN STOP — execute only current step, do not continue automatically
- ⚠️ LOOP UNTIL TESTS PASS — if tests fail, fix and re-test
- 📝 DOCUMENT AND STOP — when tests pass, update results doc and stop

**After all steps**: Run `/dev-finalize` to record timestamp, consolidate lessons, generate diagram, and run health check.

---

## Stage 3b: Review (Opt-In)

**Goal**: Catch conceptual errors tests miss — wrong assumptions, silent trade-offs, architectural drift, over-engineering.

**Code Allowed**: ❌ NO — review only writes to results.md; the executor handles fixes.

**Optional**: This gate is opt-in. Run `/dev-review-run` after execution to review all completed steps in parallel, or `/dev-review <results-doc> <step>` for a single step.

**Guide**: `references/review-guide.md` | **Template**: `assets/templates/review.md`

**Input**: `docs/[milestone-slug]-[task-slug]-results.md` + step number (single-step mode) | **Output**: Review block written into the step's section in results.md

**Key rules**:
- **DESIGN-ANCHORED** — compare against design intent and plan acceptance criteria
- **RISK-CALIBRATED** — apply checks at the depth specified by the plan's Risk Profile (default Standard)
- **REPLACE, DON'T APPEND** — exactly one Review section per step at all times

**After completion**: If FLAG, run `/dev-execute <plan> <step> --fix "<findings>"` to apply scoped fixes, then re-review.

---

## State Detection

The skill should detect where the user is in the workflow:

1. **No docs exist**: Start with Stage 1 (Design)
2. **Only goal doc exists**: Move to Stage 1 (Design) — Stage 1 reads goal doc as alignment context
3. **Only design exists**: Move to Stage 2 (Planning)
4. **Plan exists**: Move to Stage 3 (Execution)
5. **Results doc shows progress**: Continue Stage 3 from current step

Use Glob/Grep to check for existing documents:
- `docs/[milestone-slug]-[task-slug]-goal.md`
- `docs/[milestone-slug]-[task-slug]-design.md`
- `docs/[milestone-slug]-[task-slug]-plan.md`
- `docs/[milestone-slug]-[task-slug]-results.md`

`/dev-ready <doc>` resolves the applicable readiness gate (G1–G5) from these same artifact-trail signals — it derives the task slug from the doc argument, walks the ladder (goal → design → design-review → plan → plan-review) and binds the **furthest-along** break, each `-review.md` twin advancing the cursor one gate. The gate is always computed, never operator-supplied. See **Readiness Gates** below.

---

## Readiness Gates

**Goal**: At each break between dev stages, run a directed, inline readiness check that emits a **bounded decision** (READY / NOT-READY + the shortest in-scope action list, or "escalate: re-scope") — never a finding dump. Non-autonomous work (spikes, human-gates, operator-driven steps) is caught **at the gate**, so downstream execution stays autonomous.

**Code Allowed**: ❌ NO — the gate is PROPOSE-only: it surfaces the minimal in-scope diff, the operator approves and applies. The gate never mutates the artifact itself.

**Command**: `/dev-ready <doc>` | **Guide**: `references/ready-guide.md` (the shared flow + leashes + profile schema) | **Profiles**: `assets/ready/g1.md … g5.md` (one per gate)

There are **five gates**, one at each break:

```
/dev-goal → [G1] → /dev-design → [G2] → /review-doc → [G3] → /dev-plan → [G4] → /review-doc → [G5] → /dev-execute-run
            ▲                    ▲                     ▲                   ▲                     ▲
            ready to design?     ready for review?     ready to plan?      ready for review?     ready to execute?
```

| Gate | Break — "are we ready…?" | Reads | Verdict |
|------|--------------------------|-------|---------|
| **G1** | …to design? | goal doc and/or notes (any de-risking evidence, optional) | proceed-to-design / spike-first |
| **G2** | …for design review? | `…-design.md` | ready-for-`/review-doc` |
| **G3** | …to plan? | `…-design.md` + `…-design-review.md` | ready-to-plan **or** go/no-go (may recommend don't-plan / archive) |
| **G4** | …for plan review? | `…-plan.md` | ready-for-`/review-doc` |
| **G5** | …to execute? | `…-plan.md` + `…-plan-review.md` | ready-to-execute |

**Resolution**: `/dev-ready <doc>` derives the task slug from the doc argument, then binds the **furthest-along** break by walking the artifact ladder; each `-review.md` twin advances the cursor one gate. The `<doc>` argument selects the *task*; the ladder selects the *gate* — the gate is never operator-supplied.

**Contract**: every gate runs through the **one shared flow** in `ready-guide.md` — **inline** (one agent, one context; no sub-agents, no fan-out, no Workflow-primitive dependency), against the **one artifact** for that break, scored on a short fixed rubric, **biased to READY**. Adding or retuning a gate is editing one `assets/ready/gN.md` profile — zero new machinery.

---

## Best Practices

1. **Execute, review, auto-fix** — Execute step → review → if flagged: up to 2 fix→re-review cycles → if still flagged: stop for human. Most steps pass on first try.
2. **User always verifies** — Complete stage → user runs `/review-doc` → user requests next stage.
3. **Documentation stays clean** — Implementation docs evergreen (no status). Results docs track progress.
4. **Tests are mandatory** — Every step requires passing tests before moving on.
5. **Self-contained is non-negotiable** — Add alongside, don't replace. System works at every task boundary.

---

## File Naming Conventions

**Project Tracking** (created once, updated throughout):
- `PROJECT_STATE.md` - Milestone progress, key decisions, system status, latest health check
- Template: `assets/templates/PROJECT_STATE.md`
- Keep it concise - remove resolved questions, keep only latest health check

**Per Task**:
- `docs/[milestone-slug]-[task-slug]-goal.md` - e.g., `docs/core-placements-goal.md`, `docs/cloud-auth-fix-goal.md`
- `docs/[milestone-slug]-[task-slug]-design.md` - e.g., `docs/core-poc6-design.md`, `docs/cloud-auth-fix-design.md`
- `docs/[milestone-slug]-[task-slug]-plan.md` - e.g., `docs/core-poc6-plan.md`, `docs/cloud-auth-fix-plan.md`
- `docs/[milestone-slug]-[task-slug]-results.md` - e.g., `docs/core-poc6-results.md`, `docs/cloud-auth-fix-results.md`

**Per Milestone**:
- `docs/[milestone-slug]-milestone-summary.md` - e.g., `docs/core-milestone-summary.md`

**Test Files**:
- Follow environment conventions (e.g., Python: `tests/test_[task-slug]_*.py`)

**Where**:
- `[milestone-slug]` is the milestone name (e.g., `core`, `cloud`, `mobile`)
- `[task-slug]` is the task name (e.g., `poc6`, `auth-fix`, `database-abstraction`)
- Both are lowercase with hyphens

---

## Integration with design skill

**Standalone**: Use dev for any development work (features, bugs, refactoring).

**With design skill**: The design skill creates the plan (`docs/[milestone-slug]-tasks.md`), then dev implements it (Stage 1 → Stage 2 → Stage 3, repeat for each task).
