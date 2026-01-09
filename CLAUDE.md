# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repo contains two complementary Claude Code skills:

1. **dev-design** - Design phase (concept to executable plan)
2. **dev-cycle** - Development loop (plan to working code)

## Repo Structure

```
idea-to-mvp/
├── deploy.sh                   # Deploy both skills and commands
├── verify.sh                   # Verify deployment is correct
├── sync-from-user.sh           # Sync changes from deployed skills
├── commands/                   # Global commands (deployed by both skills)
│   ├── verify-doc.md          # Document verification
│   ├── dev-overview.md        # Create high-level design
│   ├── dev-plan.md            # Plan implementation steps
│   ├── dev-execute.md         # Execute step-by-step
│   └── small-win-check.md     # Project health check
├── dev-design/                 # Design skill (5 stages)
│   ├── SKILL.md               # Main skill definition
│   ├── assets/templates/      # Templates (5 templates)
│   └── references/            # Stage guides (1-5)
└── dev-cycle/                  # Development skill
    ├── SKILL.md               # Main skill definition
    ├── assets/templates/      # Templates (overview, implementation, results, PROJECT_STATE)
    ├── references/            # Stage guides (1-3)
    └── docs/                  # Design docs for this skill
```

## Development Workflow

### Making Changes

1. **Edit files in this repo** (not in `~/.claude/skills/`)
2. **Test locally** if needed
3. **Deploy**:
   ```bash
   ./deploy.sh
   ```
4. **Commit and push**: Standard git workflow

### Sync from Deployed Skills

If you made changes in `~/.claude/skills/dev-design/`, `~/.claude/skills/dev-cycle/`, or `~/.claude/commands/`:

```bash
./sync-from-user.sh
git status  # Review changes
```

## Key Commands

```bash
# Deploy both skills and all commands
./deploy.sh

# Verify deployment is correct
./verify.sh

# Sync changes back from deployed skills and commands
./sync-from-user.sh

# Check git status
git status
```

## File Naming Conventions

**dev-design creates:**
- `[slug]-north-star.md` - Vision and goals (e.g., `mc-north-star.md`)
- `[slug]-architecture.md` - Architecture (e.g., `mc-architecture.md`)
- `[slug]-milestones-overview.md` - Strategic milestone roadmap (e.g., `mc-milestones-overview.md`)
- `[slug]-milestone.md` - Detailed milestone design (e.g., `core-milestone.md`)
- `[slug]-poc-design.md` - PoC plan (e.g., `core-poc-design.md`)

**dev-cycle creates:**
- `PROJECT_STATE.md` - Task and milestone tracking
- `docs/[milestone-slug]-[task-slug]-overview.md` - Feature/bug design analysis (e.g., `core-poc6-overview.md`)
- `docs/[milestone-slug]-[task-slug]-implementation.md` - Implementation guide (evergreen)
- `docs/[milestone-slug]-[task-slug]-results.md` - Progress tracking (live status)
- `tests/test_[task-slug]_*.py` - Tests grouped by task

## Templates

**dev-design** (`dev-design/assets/templates/`):
- `north-star.md` - Stage 1 template
- `architecture.md` - Stage 2 template
- `milestones-overview.md` - Stage 3 template
- `milestone-design.md` - Stage 4 output
- `poc-design.md` - Stage 5 output

**dev-cycle** (`dev-cycle/assets/templates/`):
- `overview.md` - Stage 1 output
- `implementation-plan.md` - Stage 2 output (implementation guide)
- `implementation-results.md` - Stage 2 output (progress tracking)
- `PROJECT_STATE.md` - Project tracking

## Reference Guides

**dev-design** (`dev-design/references/`):
- `1-north-star-guide.md` through `5-poc-design-guide.md` (5 stages)

**dev-cycle** (`dev-cycle/references/`):
- `1-overview-guide.md` through `3-execution-guide.md`

## Slash Commands

**All commands** (`commands/`):
- `verify-doc.md` - Document verification
- `dev-overview.md` - Create high-level design
- `dev-plan.md` - Plan implementation steps
- `dev-execute.md` - Execute step-by-step
- `small-win-check.md` - Project health check

Commands are global and deployed by both skills to `~/.claude/commands/`

## Deployment

Single `deploy.sh` script at root deploys everything:
- `dev-design/` → `~/.claude/skills/dev-design/`
- `dev-cycle/` → `~/.claude/skills/dev-cycle/`
- `commands/` → `~/.claude/commands/`

Single `sync-from-user.sh` script syncs everything back

## Git Workflow

```bash
# Standard workflow
git add .
git commit -m "Description"
git push
```

**Remote**: `git@github-creational:creational-ai/idea-to-mvp.git`

## Contributing Guidelines

- Keep each skill's SKILL.md as the source of truth
- Templates should be generic (no project-specific content)
- References provide detailed stage guidance
- Test slash commands after changes
- Deploy before pushing to verify changes work
- dev-design is pure design (NO CODE)
- dev-cycle allows code (Stage 1 is design-only, Stages 2-3 allow code)
