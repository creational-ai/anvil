# idea-to-mvp

![Claude Skill](https://img.shields.io/badge/Claude-Skill-blue)

A structured workflow for taking ideas from concept to working product through two complementary skills:

1. **dev-design** - Design phase (0 to 1)
2. **dev-cycle** - Development loop (1 to N)

## Quick Start

```bash
git clone git@github-creational:creational-ai/idea-to-mvp.git
cd idea-to-mvp

# Deploy both skills and all commands
./deploy.sh

# Verify deployment is correct
./verify.sh
```

## Skills Overview

### dev-design - Design Phase

Creates the foundation before any code is written. **NO CODE allowed.**

**Stages**:
1. North Star - Refine idea into vision doc
2. Architecture - Technical architecture
3. Milestones Overview - Strategic milestone roadmap
4. Milestone Design - Detailed design per milestone
5. PoC Design - Define atomic proofs-of-concept

**Commands**:
- `/design-northstar` - Create vision document
- `/design-architecture` - Create architecture document
- `/design-milestones-overview` - Create milestone roadmap
- `/design-milestone-design` - Create detailed milestone design
- `/design-poc-design` - Create PoC breakdown

**Output**: `docs/[slug]-north-star.md`, `docs/[slug]-architecture.md`, `docs/[slug]-milestones-overview.md`, `docs/[slug]-milestone.md`, `docs/[slug]-poc-design.md`

### dev-cycle - Development Loop

Implements tasks through a repeating 3-stage cycle.

**Stages**:
1. Overview - Analyze features/bugs (design only, NO CODE)
2. Implementation Plan - Break into steps with code snippets
3. Execution - Implement with tests

**Commands**:
- `/dev-overview` - Create high-level design
- `/dev-plan` - Plan implementation steps
- `/dev-execute` - Execute step-by-step
- `/dev-lessons` - Consolidate lessons learned
- `/small-win-check` - Health check after work completion

**Agent Commands** (for subagent invocation):
- `/agent-dev-plan` - Plan agent for Stage 2
- `/agent-dev-execute` - Execute agent for Stage 3

**Output**: `docs/[milestone-slug]-[task-slug]-overview.md`, `docs/[milestone-slug]-[task-slug]-implementation.md`, `docs/[milestone-slug]-[task-slug]-results.md`

## Workflow

```
1. Use dev-design to create your plan (5 stages)
   → /design-northstar: Vision document
   → /design-architecture: Technical design
   → /design-milestones-overview: Strategic roadmap
   → /design-milestone-design: Detailed milestone design
   → /design-poc-design: Atomic proof-of-concepts

2. Use dev-cycle to execute the plan
   → /dev-overview: Analyze first task (optional)
   → /dev-plan: Plan implementation
   → /dev-execute: Implement step-by-step
   → /dev-lessons: Consolidate lessons
   → Repeat for each task

3. After completing work
   → /small-win-check: Update PROJECT_STATE.md
```

## Key Principles

- **dev-design is NO-CODE** - Pure design and planning
- **dev-cycle allows code** - Stage 1 is design-only, Stages 2-3 allow code
- **One task at a time** - Plan and execute incrementally
- **Production-grade quality** - OOP, Pydantic, type hints, tests required
- **Self-contained work** - Each item works independently

## File Structure

```
idea-to-mvp/
├── deploy.sh                   # Deploy both skills and commands
├── verify.sh                   # Verify deployment is correct
├── sync-from-user.sh           # Sync changes from deployed skills
├── commands/                   # Global commands
│   ├── verify-doc.md           # Document verification
│   ├── design-northstar.md     # Stage 1 command
│   ├── design-architecture.md  # Stage 2 command
│   ├── design-milestones-overview.md  # Stage 3 command
│   ├── design-milestone-design.md     # Stage 4 command
│   ├── design-poc-design.md    # Stage 5 command
│   ├── dev-overview.md         # Dev Stage 1 command
│   ├── dev-plan.md             # Dev Stage 2 command
│   ├── dev-execute.md          # Dev Stage 3 command
│   ├── dev-lessons.md          # Lessons consolidation
│   ├── small-win-check.md      # Health check
│   ├── agent-dev-plan.md       # Plan agent command
│   └── agent-dev-execute.md    # Execute agent command
├── dev-design/                 # Design skill (5 stages)
│   ├── SKILL.md                # Main skill definition
│   ├── assets/templates/       # 5 templates
│   └── references/             # 5 stage guides (1-5)
└── dev-cycle/                  # Development skill (3 stages)
    ├── SKILL.md                # Main skill definition
    ├── assets/templates/       # 5 templates
    ├── agents/                 # Subagent definitions
    └── references/             # 3 stage guides (1-3)
```

**Deployed to**:
- `~/.claude/skills/dev-design/`
- `~/.claude/skills/dev-cycle/`
- `~/.claude/commands/`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
