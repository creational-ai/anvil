# /design-milestone-design

Expand a single milestone into comprehensive, self-contained design document.

## What This Does

Stage 4 of dev-design: Create detailed design for one milestone with implementation perspective.

## Resources

**Read these for guidance**:
- `~/.claude/skills/dev-design/SKILL.md` - See "Stage 4: Milestone Design" section
- `~/.claude/skills/dev-design/references/4-milestone-design-guide.md` - Detailed process
- `~/.claude/skills/dev-design/assets/templates/milestone-design.md` - Output template

## Prerequisites

Must complete before running this command:
- [ ] Stage 3: Milestones Overview (`docs/milestones-overview.md`)
- [ ] Stage 2: Architecture (`docs/[name]-architecture.md`)

## Input

**First argument (optional):**
- Milestone name (e.g., "Core", "Mobile") → Reads milestone from `docs/milestones-overview.md`
- Milestone number (e.g., "1", "2") → Reads Nth milestone from `docs/milestones-overview.md`
- If not provided, uses first milestone (Milestone 1: Core)

**Required docs (auto-read):**
- `docs/milestones-overview.md` - Milestone overview with high-level sections
- `docs/*-architecture.md` - Architecture documents

**User notes (optional):**
```
{{notes}}
```

**Examples:**
```bash
# Basic usage - designs first milestone (Core)
/design-milestone-design

# Specify milestone by name
/design-milestone-design "Core"

# Specify milestone by number
/design-milestone-design "1"

# Later, design second milestone
/design-milestone-design "Mobile"
# OR
/design-milestone-design "2"
```

**Output naming:**
- Derives from milestone in `docs/milestones-overview.md`
- Creates `docs/milestone-[number]-[slug].md`
- Example: `docs/milestone-1-web-core.md`

## Key Requirements

⛔ **NO CODE** - This is design only (detailed architecture, components, phases)

## Process

Follow the guidance in `4-milestone-design-guide.md`:
1. Select milestone from overview
2. Write Executive Summary (2-3 paragraphs + key principle)
3. Expand Goal section (what it proves + what it doesn't)
4. Expand Architecture Overview (diagram, stack, cost)
5. Design Core Components (3-6 components with full detail)
6. Detail Implementation Phases
7. Expand Success Metrics
8. Add Key Outcomes
9. Document Design Decisions & Rationale
10. Identify Risks & Mitigation
11. Document Open Questions
12. Define Next Steps (three time horizons)

## Output

Creates:
- `docs/milestone-[number]-[slug].md` - Comprehensive milestone design

## Key Principles

**Self-Contained**: Focus ONLY on this milestone (no forward references to M2, M3)

**Implementation Perspective**: Production-grade design, not prototypes

**Design-Focused**: Focus on WHAT and WHY, not rigid WHEN

## After Completion

User will run `/verify-doc docs/milestone-[number]-[slug].md`, fix issues, then proceed to Stage 5 (PoC Design).

**Next Stage**: Create PoC design for this milestone, breaking it into atomic proof-of-concepts.
