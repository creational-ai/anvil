---
description: "Create milestones doc breaking Vision into strategic milestones (Stage 3 of design skill)"
argument-hint: "<notes>"
disable-model-invocation: true
---

# /design-milestones

Create milestones doc breaking Vision into strategic phases.

## What This Does

Stage 3 of design skill: Break Vision + Architecture into strategic milestones.

## Resources

**Read these for guidance**:
- `~/.claude/skills/design/SKILL.md` - See "Stage 3: Milestones" section
- `~/.claude/skills/design/references/3-milestones-guide.md` - Detailed process
- `~/.claude/skills/design/assets/templates/3-milestones.md` - Template

## Prerequisites

Must complete before running this command:
- [ ] Stage 1: Vision (`docs/[project-slug]-vision.md`)
- [ ] Stage 2: Architecture (`docs/[project-slug]-architecture.md`)

## Input

**Required docs (auto-read):**
- `docs/[project-slug]-vision.md` - Vision and goals
- `docs/[project-slug]-architecture.md` - Architecture document
- Research findings (if any exist)

**User notes (optional):**
```
{{notes}}
```

**Examples:**
```bash
# Basic usage (reads all docs + user context)
/design-milestones

# With specific guidance
/design-milestones "Clear path: Core → Mobile → Enterprise"

# For unclear path
/design-milestones "Small project - just start with Core milestone"
```

## Key Requirements

⛔ **NO CODE** - This is design only (milestone planning, strategic milestones doc)

## Process

1. **Read all prerequisite docs:**
   - Read `docs/[project-slug]-vision.md`
   - Read `docs/[project-slug]-architecture.md`
   - Read any research findings (from market-research, if available)
   - Review user notes

2. **Follow the guidance in `3-milestones-guide.md`:**
   - Start with Core milestone (always)
   - Assess path clarity (can you see the giant steps?)
   - Define milestones based on strategic phases
   - Document milestone progression and rationale

## Output

Creates:
- `docs/[project-slug]-milestones.md` - Strategic milestones doc (e.g., `docs/mc-milestones.md`)

## Key Decisions

**Every project starts with a Core milestone** (core functionality)

**Clear path to product vision**: Define multiple milestones upfront if you can see the strategic phases

**Unclear path**: Start with just Core milestone - expand as clarity emerges through execution

## After Completion

User will run `/review-doc docs/[project-slug]-milestones.md`, fix issues, then proceed to Stage 4 (Tasks).

**Next Stage**: Create tasks doc for Core milestone. Repeat for subsequent milestones as needed.
