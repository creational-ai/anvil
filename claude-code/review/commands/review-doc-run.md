---
description: Review a document using parallel subagents for per-item and cross-cutting checks. Runs in main conversation.
argument-hint: <doc-path> [--auto] [notes]
disable-model-invocation: true
---

# /review-doc-run

Review a document using parallel subagents -- item reviewers check each item, holistic reviewer checks cross-cutting concerns, orchestrator writes findings incrementally.

**Guide**: `~/.claude/skills/review/references/review-doc-run-guide.md`

## Usage

```bash
/review-doc-run docs/core-poc3-plan.md
/review-doc-run docs/core-poc3-plan.md --auto
/review-doc-run docs/core-tasks.md focus on dependency chain
```

## Input

- **Argument (required)**: Single document path
- **Flag (optional)**: `--auto` -- apply all fixes immediately instead of presenting report only
- **Notes (optional)**: Additional context or focus areas

## Process

1. Read the guide
2. Identify document type and extract items
3. Create review doc skeleton (or add column if exists)
4. Spawn item reviewers + holistic reviewer in background
5. Process findings incrementally as agents complete
6. Run elevation pass after all agents complete
7. Present simplified summary, apply fixes if --auto

Read the guide. Follow it exactly.
