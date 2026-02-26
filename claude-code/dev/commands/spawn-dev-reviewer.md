---
description: Review execution step for conceptual errors (design-anchored)
argument-hint: <results-doc> <step-number>
context: fork
agent: dev-reviewer
disable-model-invocation: true
---

Review a completed execution step following the dev review workflow.

**Input**: $ARGUMENTS

**Examples**:
- `/spawn-dev-reviewer docs/core-poc6-results.md 3` - Review step 3
- `/spawn-dev-reviewer core-poc6 2` - Review step 2
