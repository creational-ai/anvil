---
description: Verify design or implementation documents
argument-hint: <doc-path> [notes]
---

Use the **verify-doc-agent** subagent to verify documents.

**Input**: $ARGUMENTS

**Examples**:
```bash
# Verify architecture doc
/agent-verify-doc core-architecture.md

# Verify plan with focus area
/agent-verify-doc docs/core-poc2-plan.md check dependency chain

# Verify design doc
/agent-verify-doc docs/core-poc3-design.md
```
