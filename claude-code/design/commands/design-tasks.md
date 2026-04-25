---
description: "Define atomic tasks with dependencies and success criteria (Stage 4)"
argument-hint: "<milestone-slug-or-path>"
disable-model-invocation: true
---

# /design-tasks

Break a milestone into atomic, executable tasks -- with PRODUCTION-GRADE thin slices.

## What This Does

Stage 4 of design skill: Define atomic tasks with clear success criteria and dependencies.

## Resources

**Read these for guidance**:
- `~/.claude/skills/design/SKILL.md` - See "Stage 4: Tasks" section
- `~/.claude/skills/design/references/4-tasks-guide.md` - Detailed process
- `~/.claude/skills/design/assets/templates/4-tasks.md` - Output template

## Prerequisites

Must complete before running this command:
- [ ] Stage 3: Milestones (`docs/[project-slug]-milestones.md`)

## Input

**First argument (optional):**
- Milestone slug (e.g., "core", "cloud") → Identifies which milestone in `docs/[project-slug]-milestones.md` to break down
- If not provided, uses first milestone from `docs/[project-slug]-milestones.md`
- OR path to existing tasks doc (e.g., `docs/core-tasks.md`) → Update mode

**Required docs (auto-read):**
- `docs/[project-slug]-milestones.md` - Milestone context (Stage 3 output)

**User notes (optional):**
```
{{notes}}
```

**Mode Detection:**
- If argument is milestone name (or empty) → **Create mode** (new tasks doc for the given milestone)
- If argument is `docs/*-tasks.md` → **Update mode** (add new tasks)

**Output naming:**
- Derives from milestone slug → `docs/[milestone-slug]-tasks.md`
- Example: `docs/mc-milestones.md` (project `mc`, milestone `core`) → `docs/core-tasks.md`

## Key Requirements

⛔ **NO CODE** - This is design only (task planning, dependencies, success criteria)

## Process

**Create Mode** - Follow the guidance in `4-tasks-guide.md`:
1. Read the milestones doc (`docs/[project-slug]-milestones.md`) and locate the target milestone
2. Identify atomic tasks from the milestone's scope and capabilities
3. Map dependencies between tasks
4. Create task diagram
5. Define success criteria for each task

**Update Mode** - Add new tasks to existing tasks doc:
1. Read existing `docs/[milestone-slug]-tasks.md`
2. Identify new tasks needed based on user notes
3. **Append** new tasks (identified by name, not number)
4. Update dependency diagram to show where new tasks fit

## Examples

**Create tasks doc** (after `/design-milestones`):
```bash
# After completing docs/mc-milestones.md

# Design tasks for the "core" milestone
/design-tasks "core"

# Later, design tasks for another milestone
/design-tasks "cloud"
```

**Update existing tasks doc** (add new tasks):
```bash
/design-tasks docs/core-tasks.md \
  --notes "Add tasks for rate limiting discovered during planning"
```

## Task Requirements

Each task must be:
- **Atomic**: Validates one specific thing
- **Measurable**: Clear success criteria
- **Self-contained**: Works independently; doesn't break existing functionality and existing tests

## Output

Creates:
- `docs/[milestone-slug]-tasks.md` - Tasks doc derived from the milestones doc

## After Completion

Run `/review-doc docs/[milestone-slug]-tasks.md` to validate, then hand off to **dev** skill for implementation.

**Next Stage**: Implementation via **dev** skill.
