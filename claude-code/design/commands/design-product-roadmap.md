# /design-product-roadmap

Create product roadmap breaking Product Vision into strategic phases.

## What This Does

Stage 3 of design skill: Break Product Vision + Architecture into strategic milestones.

## Resources

**Read these for guidance**:
- `~/.claude/skills/design/SKILL.md` - See "Stage 3: Product Roadmap" section
- `~/.claude/skills/design/references/3-product-roadmap-guide.md` - Detailed process
- `~/.claude/skills/design/assets/templates/3-product-roadmap.md` - Template

## Prerequisites

Must complete before running this command:
- [ ] Stage 1: Product Vision (`docs/[slug]-product-vision.md`)
- [ ] Stage 2: Architecture (`docs/[slug]-architecture.md`)

## Input

**Required docs (auto-read):**
- `docs/[slug]-product-vision.md` - Vision and goals
- `docs/[slug]-architecture.md` - Architecture document
- Research findings (if any exist)

**User notes (optional):**
```
{{notes}}
```

**Examples:**
```bash
# Basic usage (reads all docs + user context)
/design-product-roadmap

# With specific guidance
/design-product-roadmap "Clear path: Core → Mobile → Enterprise"

# For unclear path
/design-product-roadmap "Small project - just start with Core milestone"
```

## Key Requirements

⛔ **NO CODE** - This is design only (milestone planning, strategic roadmap)

## Process

1. **Read all prerequisite docs:**
   - Read `docs/[slug]-product-vision.md`
   - Read `docs/[slug]-architecture.md`
   - Read any research findings (Stage 3 outputs)
   - Review user notes

2. **Follow the guidance in `3-product-roadmap-guide.md`:**
   - Start with Core milestone (always)
   - Assess path clarity (can you see the giant steps?)
   - Define milestones based on strategic phases
   - Document milestone progression and rationale

## Output

Creates:
- `docs/[slug]-product-roadmap.md` - Strategic milestone roadmap (e.g., `docs/mc-product-roadmap.md`)

## Key Decisions

**Every project starts with a Core milestone** (core functionality)

**Clear path to product vision**: Define multiple milestones upfront if you can see the strategic phases

**Unclear path**: Start with just Core milestone - expand as clarity emerges through execution

## After Completion

User will run `/verify-doc docs/[slug]-product-roadmap.md`, fix issues, then proceed to Stage 4 (Milestone Spec).

**Next Stage**: Create detailed design for Core milestone, then proceed to PoC spec for Core. Repeat for subsequent milestones as needed.
