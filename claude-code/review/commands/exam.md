---
description: Independent critical examination of a design or plan document. Deeper than automated review.
argument-hint: <doc-path> [--auto] [notes]
disable-model-invocation: true
---

# /exam

Independent critical examination of a design or plan document — challenges substance, architecture, and what the automated reviewer missed.

**Guide**: `~/.claude/skills/review/references/exam-guide.md`

## Usage

```bash
/exam docs/core-settings-redesign-plan.md
/exam docs/core-settings-redesign-plan.md --auto
/exam docs/core-poc6-design.md check the migration approach
```

## Input

- **Argument (required)**: Single document path
- **Flag (optional)**: `--auto` -- apply all fixes immediately after report without prompting
- **Notes (optional)**: Additional context or focus areas

## Process

1. Read the guide
2. Auto-detect doc type from filename pattern
3. Derive and read the `-review.md` first (if it exists)
4. Read the target doc and cross-reference docs
5. Deep examination per the guide
6. Report findings conversationally
7. Apply fixes if --auto, otherwise prompt user

Read the guide. Follow it exactly.
