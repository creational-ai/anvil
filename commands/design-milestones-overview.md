# /design-milestones-overview

Create milestones overview roadmap breaking North Star into strategic phases.

## What This Does

Stage 3 of dev-design: Break North Star + Architecture into strategic milestones.

## Resources

**Read these for guidance**:
- `~/.claude/skills/dev-design/SKILL.md` - See "Stage 3: Milestones Overview" section
- `~/.claude/skills/dev-design/references/3-milestones-overview-guide.md` - Detailed process
- `~/.claude/skills/dev-design/assets/templates/milestones-overview.md` - Template

## Prerequisites

Must complete before running this command:
- [ ] Stage 1: North Star (`docs/north-star.md`)
- [ ] Stage 2: Architecture (`docs/[name]-architecture.md`)

## Input

**Required docs (auto-read):**
- `docs/north-star.md` - Vision and goals
- `docs/*-architecture.md` - All architecture documents
- Research findings (if any exist)

**User notes (optional):**
```
{{notes}}
```

**Examples:**
```bash
# Basic usage (reads all docs + user context)
/design-milestones-overview

# With specific guidance
/design-milestones-overview "Clear path: Core → Mobile → Enterprise"

# For unclear path
/design-milestones-overview "Small project - just start with Core milestone"
```

## Key Requirements

⛔ **NO CODE** - This is design only (milestone planning, strategic roadmap)

## Process

1. **Read all prerequisite docs:**
   - Read `docs/north-star.md`
   - Read all `docs/*-architecture.md` files
   - Read any research findings (Stage 3 outputs)
   - Review user notes

2. **Follow the guidance in `4-milestones-overview-guide.md`:**
   - Start with Milestone 1: Core (always)
   - Assess path clarity (can you see the giant steps?)
   - Define milestones based on strategic phases
   - Document milestone progression and rationale

## Output

Creates:
- `docs/milestones-overview.md` - Strategic milestone roadmap

## Key Decisions

**Every project starts with Milestone 1: Core** (core functionality)

**Clear path to north star**: Define multiple milestones upfront if you can see the strategic phases

**Unclear path**: Start with just Core milestone - expand as clarity emerges through execution

## After Completion

User will run `/verify-doc docs/milestones-overview.md`, fix issues, then proceed to Stage 4 (Milestone Design).

**Next Stage**: Create detailed design for Milestone 1, then proceed to PoC design for Milestone 1. Repeat for subsequent milestones as needed.
