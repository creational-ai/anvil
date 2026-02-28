---
description: Review a design or implementation document for soundness, consistency, and correctness. Runs in main conversation.
argument-hint: <doc-path> [--auto] [notes]
disable-model-invocation: true
---

# /review-doc

Review a design or implementation document -- checks soundness, consistency, cross-references, and codebase alignment.

**Guide**: `~/.claude/skills/review/references/review-doc-guide.md`

## Usage

```bash
/review-doc docs/core-architecture.md
/review-doc docs/core-poc3-plan.md --auto
/review-doc docs/core-poc2-plan.md check dependency chain
```

## Input

- **Argument (required)**: Single document path
- **Flag (optional)**: `--auto` -- apply all fixes immediately instead of presenting report only
- **Notes (optional)**: Additional context or focus areas

## Process

1. Read the guide
2. Identify document type from filename pattern
3. Load cross-reference docs automatically
4. Run type-specific + universal checks
5. Verify codebase references
6. Write full report to review document
7. Present simplified summary, apply fixes if --auto
8. Update review doc fix status

Read the guide. Follow it exactly.
