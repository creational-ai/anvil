---
description: Review all completed steps in a results doc. Spawns review agents in parallel.
argument-hint: <results-doc>
disable-model-invocation: true
---

# /dev-review-run

Review all completed steps in parallel by spawning a `dev-reviewer` for each.

## Input

**Required**: Path to results document
- File path: `docs/[milestone-slug]-[task-slug]-results.md`
- Task name: `core-poc6` → looks for `docs/core-poc6-results.md`

**Examples**:
```bash
/dev-review-run docs/core-prefab-manager-results.md
/dev-review-run core-prefab-manager
```

## Process

**You are the orchestrator. Follow these steps exactly:**

### 1. Setup

1. Resolve the results path (if task name given, convert to `docs/[name]-results.md`)
2. Read the results doc to find all completed steps (status: ✅ Complete)
3. Find the corresponding plan doc (linked at top of results doc)
4. Read the plan doc's Overview table → extract the **Risk Profile**

### 2. Spawn Reviews and Report

For each completed step, spawn a `dev-reviewer` in background with `--report-only` so agents return the review block without writing to files.

```
Spawn dev-reviewer (run_in_background: true):
"[results-doc-path] step [N] --report-only"
```

Launch ALL review agents in a single message. Then immediately respond to the user:

```
Spawned [N] review agents for steps [list]. Merging results as they complete.
```

This response is important — it lets the background notifications arrive naturally.

### 3. Merge Each Completion

Each time a background agent completes, you receive a notification. On each notification:

1. Extract the review block from the agent's result
2. Insert the **Review** section into step {N} block in results.md
3. Report to user: "Step {N} review: PASS/FLAG"

Process each notification as it arrives. Continue until all agents have reported back.

**Format for results.md**: Use `~/.claude/skills/dev/assets/templates/review.md` for the review block format.

The **Reviewed** timestamp is the time you merge the review into results.md. Run `date "+%Y-%m-%dT%H:%M:%S%z"` to get it.

### 4. Update Summary Table

After all reviews are merged, update the **Reviewed** field in the Summary table at the top of results.md:

```markdown
| **Reviewed** | [ISO 8601 with timezone] |
```

Run `date "+%Y-%m-%dT%H:%M:%S%z"` to get the timestamp. This records when the full review pass completed.

### 5. Report Summary

After all agents have completed, all reviews merged, and Summary table updated:

```markdown
## Review Summary

**Task**: [task-name]
**Steps Reviewed**: [count]
**Risk Profile**: [from plan]

| Step | Name | Verdict |
|------|------|---------|
| 0 | [name] | PASS / FLAG |
| 1 | [name] | PASS / FLAG |
| ... | ... | ... |

**Result**: All PASS / [N] flagged

[If any FLAG:]
### Flagged Issues
**Step [N]**: [issue summary from review agent]
```

## Key Rules

1. **All reviews in parallel** — spawn all agents in a single message with `run_in_background: true`
2. **Wait for automatic notifications** — background agents notify you when done; merge each result as it arrives
3. **Orchestrator merges** — only the orchestrator writes to results.md
4. **Only review completed steps** — skip steps that are Pending or In Progress
5. **Report all results** — even if all PASS, show the summary table
