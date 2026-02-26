---
description: Generate comprehensive milestone summary document from all task docs. Runs in main conversation.
argument-hint: <milestone-slug> [update]
disable-model-invocation: true
---

# /dev-milestone-summary

Generate comprehensive milestone summary document from all task docs.

**Guide**: `~/.claude/skills/dev/references/milestone-summary-guide.md`
**Template**: `~/.claude/skills/dev/assets/templates/milestone-summary.md`

## Usage

```bash
# Create new milestone summary doc
/dev-milestone-summary core

# Update existing doc with current progress
/dev-milestone-summary core update
```

**Update mode**: Re-read all task docs, update status table, add new tasks, refresh progress diagram, update completion map. Preserve existing content structure.

Read the guide. Follow it exactly.
