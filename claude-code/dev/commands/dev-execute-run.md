---
description: Execute all remaining steps, spawning fresh subagent for each step. Runs in main conversation.
argument-hint: <plan-doc>
disable-model-invocation: true
---

# /dev-execute-run

Execute all remaining implementation steps, spawning a fresh subagent for each.

## What This Does

Orchestrates Stage 3 execution by looping through steps, launching a fresh `dev-execute-agent` for each step. This avoids context exhaustion since each step gets a clean agent context.

## Input

**Required**: Path to plan document
- File path: `docs/[milestone-slug]-[task-slug]-plan.md`
- Task name: `core-poc6` → looks for `docs/core-poc6-plan.md`

**User notes (optional)**:
```
{{notes}}
```

**Examples**:
```bash
/dev-execute-run docs/core-poc6-plan.md
/dev-execute-run core-poc6 --notes "Skip step 3, already done manually"
```

## Process

**You are the orchestrator. Follow these steps exactly:**

### 1. Setup

1. Resolve the plan path (if task name given, convert to `docs/[name]-plan.md`)
2. Read the plan to get total step count
3. Read or create results.md to find current progress
4. Identify all incomplete steps

### 2. Execute Loop

For each incomplete step (in order):

```
1. Log: "Starting Step [N] of [Total]..."

2. Spawn subagent using Task tool:
   - subagent_type: dev-execute-agent
   - prompt: "Execute step [N] of [plan-path]. Stop after this step completes."
   - Wait for completion

3. Check result:
   - If FAILED (tests failing, errors): STOP loop, report failure
   - If SUCCESS (tests passing): Continue to next step

4. Brief pause for user visibility
```

### 3. Completion

When loop ends:

**If ALL steps completed successfully:**
1. Show brief summary
2. Automatically run finalize by spawning `dev-finalize-agent`:

| Parameter | Value |
|-----------|-------|
| `subagent_type` | `dev-finalize-agent` |
| `description` | `Finalize [task-slug]` |
| `prompt` | `Finalize the task at [results-path]. Run all 4 steps: timestamp, lessons, diagram, health check.` |

3. Report final status

**If stopped due to failure:**
```markdown
## Execution Stopped

**Task**: [task-name]
**Steps Completed**: [X] of [Total]
**Stopped At**: Step [N] - [reason]

### Next Action
Fix issues, then run `/dev-execute-run [plan]` to continue
```

## Key Rules

1. **Fresh agent per step** - Always use Task tool to spawn `dev-execute-agent`
2. **Stop on failure** - Do NOT continue if a step fails
3. **Report between steps** - Brief status update so user sees progress
4. **No skipping** - Execute steps in order, don't skip ahead

## Task Tool Invocation

For each step, call the **Task** tool with these parameters:

| Parameter | Value |
|-----------|-------|
| `subagent_type` | `dev-execute-agent` |
| `description` | `Execute step N of [task-slug]` |
| `prompt` | See below |

**Prompt template:**
```
Execute step [N] of the plan at [plan-path].

This is step [N] of [Total] total steps.

Execute ONLY this step, then return with results.
Do not continue to the next step.

[Any user notes if provided]
```

The Task tool will spawn a fresh subagent, wait for completion, and return the result.

## After All Steps Complete

When all steps pass:
1. Show brief summary of steps completed
2. Spawn `dev-finalize-agent` to wrap up (timestamp + lessons + diagram + health check)
3. Report final completion status

The task is fully done when finalize completes - no manual steps needed.
