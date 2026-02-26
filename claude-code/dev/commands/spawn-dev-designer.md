---
description: Create design for feature/bug/PoC (Stage 1, NO CODE)
argument-hint: [file-path] [notes]
context: fork
agent: dev-designer
disable-model-invocation: true
---

Create a design document following the dev Stage 1 workflow.

**Input**: $ARGUMENTS

**Examples**:
- `/spawn-dev-designer docs/bug-123.md "Focus on performance impact"` - From bug report file
- `/spawn-dev-designer "Add caching layer to reduce API calls"` - From user description only
