---
description: Research and evaluate product/project name candidates with scoring matrix
argument-hint: <project-slug> <notes>
context: fork
agent: naming-research-agent
disable-model-invocation: true
---

Research product/project name candidates and produce a ranked recommendation with scoring matrix.

**Input**: $ARGUMENTS

**Examples**:
- `/agent-naming-research admedi "Ad mediation platform for mobile games, hosted under creational.ai"` - With hosting context
- `/agent-naming-research myproject "Developer tool for API testing"` - Standalone product
