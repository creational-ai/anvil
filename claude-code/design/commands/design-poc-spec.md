---
description: "Define atomic PoCs with success criteria (Stage 5 of design skill)"
argument-hint: "<milestone-slug-or-path>"
disable-model-invocation: true
---

# /design-poc-spec

Define what needs to be proven and in what order -- with PRODUCTION-GRADE thin slices.

## What This Does

Stage 5 of design skill: Plan atomic PoCs with clear success criteria and dependencies.

## Resources

**Read these for guidance**:
- `~/.claude/skills/design/SKILL.md` - See "Stage 5: PoC Spec" section
- `~/.claude/skills/design/references/5-poc-spec-guide.md` - Detailed process
- `~/.claude/skills/design/assets/templates/5-poc-spec.md` - Output template

## Prerequisites

Must complete before running this command:
- [ ] Stage 4: Milestone Spec (`docs/[milestone-slug]-milestone-spec.md`)
- [ ] Stage 3: Roadmap (`docs/[project-slug]-roadmap.md`)

## Input

**First argument (optional):**
- Milestone slug (e.g., "core", "cloud") → Finds `docs/[milestone-slug]-milestone-spec.md`
- If not provided, uses first milestone from `docs/[project-slug]-roadmap.md`
- OR path to existing PoC spec (e.g., `docs/core-poc-spec.md`) → Update mode

**Required docs (auto-read):**
- `docs/[milestone-slug]-milestone-spec.md` - Detailed milestone design
- `docs/[project-slug]-roadmap.md` - Milestone context

**User notes (optional):**
```
{{notes}}
```

**Mode Detection:**
- If argument is milestone name (or empty) → **Create mode** (new PoC spec from milestone spec)
- If argument is `docs/*-poc-spec.md` → **Update mode** (add new PoCs)

**Output naming:**
- Derives from milestone slug → `docs/[slug]-poc-spec.md`
- Example: `docs/web-core-milestone-spec.md` → `docs/web-core-poc-spec.md`

## Key Requirements

⛔ **NO CODE** - This is design only (PoC planning, dependencies, success criteria)

## Process

**Create Mode** - Follow the guidance in `5-poc-spec-guide.md`:
1. Read the detailed milestone spec (`docs/[slug]-milestone-spec.md`)
2. Identify atomic things to prove (PoCs) from the design
3. Map dependencies between PoCs
4. Create PoC diagram
5. Define success criteria for each PoC

**Update Mode** - Add new PoCs to existing design:
1. Read existing `docs/[slug]-poc-spec.md`
2. Identify new PoCs needed based on user notes
3. **Append** new PoCs with next sequential numbers
4. Update dependency diagram to show where new PoCs fit
5. **DO NOT renumber** existing PoCs

## Examples

**Create PoC spec** (after `/design-milestone-spec`):
```bash
# After completing docs/web-core-milestone-spec.md

# Design PoCs for milestone
/design-poc-spec "web-core"

# Later, design PoCs for another milestone
/design-poc-spec "cloud"
```

**Update existing PoC spec** (add new PoCs):
```bash
/design-poc-spec docs/web-core-poc-spec.md \
  --notes "Add PoCs for rate limiting discovered during planning"
```

## PoC Requirements

Each PoC must be:
- **Atomic**: Proves one specific thing
- **Measurable**: Clear success criteria
- **Self-contained**: Works independently; doesn't break existing functionality and existing tests

## Output

Creates:
- `docs/[slug]-poc-spec.md` - PoC plan derived from milestone spec

## After Completion

Run `/verify-doc docs/[slug]-poc-spec.md` to validate, then hand off to **dev** skill for implementation.

**Next Stage**: Implementation via **dev** skill.
