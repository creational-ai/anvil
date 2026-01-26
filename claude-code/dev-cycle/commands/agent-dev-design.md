---
description: Create design for feature/bug/PoC (Stage 1, NO CODE)
argument-hint: [file-path] [notes]
---

Use the **dev-design-agent** subagent to create a design document.

**Input**: $ARGUMENTS

**Examples**:
```bash
# From bug report file
/agent-dev-design docs/bug-123.md "Focus on performance impact"

# From user description only
/agent-dev-design "Add caching layer to reduce API calls"
```
