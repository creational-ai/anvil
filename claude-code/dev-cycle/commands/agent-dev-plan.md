---
description: Create implementation plan from design document (Stage 2)
argument-hint: <doc-path> [update]
---

Use the **dev-plan-agent** subagent to create an implementation plan.

**Input**: $ARGUMENTS

**Examples**:
```bash
# Create new implementation plan from design doc
/agent-dev-plan docs/core-poc6-design.md

# Update existing plan doc to match current template
/agent-dev-plan docs/core-poc6-plan.md update
```
