---
description: Review all completed steps in a results doc. Spawns review agents in parallel.
argument-hint: <results-doc>
disable-model-invocation: true
---

# /dev-review-run

Review all completed steps in parallel by spawning a `dev-review-agent` for each.

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

### 2. Spawn Reviews in Parallel

For each completed step, spawn a `dev-review-agent` in background with a modified prompt that tells it to **return findings only, do NOT write to results.md**:

```
Spawn dev-review-agent (run_in_background: true):
"[results-doc] step [N]

IMPORTANT: Do NOT write to results.md. Return your review findings
and completion report as text output only. The orchestrator will
write all reviews to results.md after collecting all results."
```

Launch ALL review agents in a single message — do not wait between spawns.

### 3. Collect and Write As They Complete

Poll background agents. As each one finishes, immediately write its review section into the corresponding step block in results.md. Don't wait for all agents — write as they come in.

Use the review output from each agent to add/replace the `**Review**:` section in each step block.

### 4. Report Summary

After all agents have completed:

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
2. **Agents do NOT write** — agents return findings as text; orchestrator writes to results.md
3. **Write as they arrive** — as each agent completes, immediately write its review to results.md
4. **Only review completed steps** — skip steps that are Pending or In Progress
5. **Report all results** — even if all PASS, show the summary table
