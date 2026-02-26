---
description: Generate comprehensive milestone summary document
argument-hint: <milestone-slug> [update]
context: fork
agent: dev-milestone-summarizer
disable-model-invocation: true
---

Generate a comprehensive milestone summary document.

**Input**: $ARGUMENTS

**Examples**:
- `/spawn-dev-milestone-summarizer core` - Create new milestone summary doc
- `/spawn-dev-milestone-summarizer core update` - Update existing doc with current progress
