# design

Structured workflow for taking ideas from concept to executable task plan.

**Version**: 2.0.0

## Hierarchy

```
Project (e.g., "mission-control")
├── Milestone (grouping layer, e.g., "core", "cloud")
│   ├── Task (e.g., "poc-1", "auth-feature", "fix-bug-42")
│   └── Task ...
└── Milestone (e.g., "integrations")
    └── Task ...
```

**Task Types**: PoC (validate approach) | Feature | Issue | Refactor

**Philosophy**: design handles the **design phase** (0 to 1). Once you have a task plan, hand off to the **dev skill** for the **development loop** (1 to N).

## Stage Overview

| Stage | Output | Purpose |
|-------|--------|---------|
| 1. Vision | `docs/[project-slug]-vision.md` | Vision & feasibility |
| 2. Architecture | `docs/[project-slug]-architecture.md` | Technical design |
| 3. Milestones | `docs/[project-slug]-milestones.md` | Strategic milestone breakdown |
| 4. Tasks | `docs/[milestone-slug]-tasks.md` | Atomic tasks with dependencies (per milestone) |

**File Naming** (two rules):

1. **Scope prefix**: `[project-slug]-*` for project-level docs (vision, architecture, milestones); `[milestone-slug]-*` for milestone-level docs (tasks).
2. **Noun number**: singular noun for project-level / aggregate-of-one docs (`vision`, `architecture`); plural noun for docs that enumerate multiple items (`milestones` enumerates milestones; `tasks` enumerates tasks within a milestone).

Examples:
- `docs/mc-vision.md` — project `mc`, singular aggregate-of-one
- `docs/mc-architecture.md` — project `mc`, singular
- `docs/mc-milestones.md` — project `mc`, plural (enumerates milestones)
- `docs/core-tasks.md` — milestone `core`, plural (enumerates tasks)
- `docs/cloud-tasks.md` — milestone `cloud`, plural (enumerates tasks)

## Commands

- `/design-vision` - Create or refine Vision document (Stage 1)
- `/design-architecture` - Create architecture and integration plan (Stage 2)
- `/design-milestones` - Create milestones doc with strategic milestone breakdown (Stage 3)
- `/design-tasks` - Define atomic tasks per milestone with dependencies and success criteria (Stage 4)

---

## CRITICAL: TEMPLATE & OUTPUT RULES

**THIS IS NOT FREEFORM DOCUMENTATION.**

Templates are mandatory. They define the exact structure curated over months of iteration.

**For EVERY stage output:**
1. **READ the template FIRST** from `assets/templates/[name].md`
2. **FOLLOW the template structure EXACTLY** -- every section, every heading, in order
3. **Fill in project-specific content** within that structure
4. **Write to `docs/` directory** using the naming convention for that stage

**DO NOT:** Skip template | Invent structure | Omit sections | Reorder sections | Add sections

---

## Design Philosophy: 200 Users First

**This skill is for inception** -- structuring ideas into well-defined milestones and tasks.

**Production-grade, but right-sized:**
- Build with production-quality from day one
- BUT size everything for your first 200 users
- Security, data modeling, HA -- include them, but don't over-engineer
- Break 200 paying users, THEN dedicate a milestone to scale

**Why 200?** Enough to validate product-market fit. No users = scaling is a problem you don't have.

---

## CRITICAL: NO-CODE SKILL

**All stages (1-4) are strictly NO-CODE zones.**

**Allowed**: Architecture diagrams, data flow descriptions, workflow descriptions, pseudocode (sparingly), API contracts, tech stack decisions

**NOT allowed**: Implementation code, function definitions, class implementations, copy-paste snippets

**If asked for code**: "We're in design stage -- code comes later in the dev skill. Let me describe how this would work at a high level..."

---

## Stage 1: Vision

**Goal**: Refine the idea into a clear, feasible vision

**Input**: Idea (verbal, notes, rough sketch)
**Template**: `assets/templates/1-vision.md`
**Output**: `docs/[project-slug]-vision.md` (e.g., `docs/mc-vision.md`)

> See `references/1-vision-guide.md` for detailed process

### Stage 1 Complete Checklist
- [ ] `docs/[project-slug]-vision.md` created using template
- [ ] Problem clearly stated
- [ ] Solution approach makes sense
- [ ] Technical feasibility seems reasonable
- [ ] No obvious blockers identified
- [ ] Run `/review-doc docs/[project-slug]-vision.md`

**Next**: Stage 2: Architecture

---

## Stage 2: Architecture

**Goal**: Create technical architecture and integration plan

**Input**: Vision doc (`docs/[project-slug]-vision.md`)
**Template**: `assets/templates/2-architecture.md`
**Output**: `docs/[project-slug]-architecture.md` (e.g., `docs/mc-architecture.md`)

> See `references/2-architecture-guide.md` for detailed process

### Market Research Checkpoint (Optional)

Once you have enough context (typically after Stage 2 or 3), consider validating the market:

*"Do market research for this product. Do we have a play in this space? Is it worth pursuing?"*

Validate early. The more context you have, the better the research -- but don't over-design before confirming market fit.

### Stage 2 Complete Checklist
- [ ] `docs/[project-slug]-architecture.md` created using template
- [ ] Architecture diagram complete
- [ ] Tech stack justified
- [ ] Data flows documented
- [ ] Integration points identified
- [ ] Data model documented
- [ ] Security considerations addressed
- [ ] Observability approach defined
- [ ] No code written (only diagrams and descriptions)
- [ ] Run `/review-doc docs/[project-slug]-architecture.md`

**Next**: Stage 3: Milestones

---

## Stage 3: Milestones

**Goal**: Break Vision + Architecture into strategic milestones with clear progression

**Input**:
- Vision doc (`docs/[project-slug]-vision.md`)
- Architecture doc (`docs/[project-slug]-architecture.md`)

**Template**: `assets/templates/3-milestones.md`
**Output**: `docs/[project-slug]-milestones.md` (e.g., `docs/mc-milestones.md`)

> See `references/3-milestones-guide.md` for detailed process

### Stage 3 Complete Checklist
- [ ] `docs/[project-slug]-milestones.md` created using template
- [ ] Milestone Progression diagram shows overall strategy
- [ ] First milestone (Core) fully defined with all sections
- [ ] Each milestone has Goal, Architecture, What Gets Built, Metrics, Outcomes, Why
- [ ] Strategic Decisions section explains milestone order
- [ ] Success Criteria defined for each milestone
- [ ] Next Steps clear
- [ ] Run `/review-doc docs/[project-slug]-milestones.md`

**Next**: Stage 4: Tasks (break each milestone into atomic tasks)

---

## Stage 4: Tasks

**Goal**: Define atomic tasks per milestone with dependencies and success criteria -- PRODUCTION-GRADE thin slices

**Input**:
- Milestones doc (`docs/[project-slug]-milestones.md`)
- Architecture doc (`docs/[project-slug]-architecture.md`)

**Template**: `assets/templates/4-tasks.md`
**Output**: `docs/[milestone-slug]-tasks.md` (e.g., `docs/core-tasks.md`)

**Task Requirements** (critical):
- **Atomic**: Validates ONE specific thing
- **Measurable**: Clear success criteria
- **Self-contained**: Works independently, doesn't break existing functionality

**Golden Rule**: One capability = One task (minimize tasks; group related work)

> See `references/4-tasks-guide.md` for detailed process

### Stage 4 Complete Checklist
- [ ] `docs/[milestone-slug]-tasks.md` created using template
- [ ] Prerequisite section describes prior milestone's exit state
- [ ] Scope section has In/Out subsections (Out absorbs forward-looking items)
- [ ] Each task validates one specific thing
- [ ] Dependencies mapped (which tasks unlock others)
- [ ] Success criteria measurable
- [ ] Order of execution clear
- [ ] Feedback loop guidance included
- [ ] Run `/review-doc docs/[milestone-slug]-tasks.md`

**Next**: Hand off to **dev skill** for implementation

---

## Handoff to dev

Once `docs/[milestone-slug]-tasks.md` is complete, hand off to the **dev skill** for implementation.

**dev** handles all development work through a repeating cycle: plan tasks, execute step-by-step, test, repeat.

---

## Reference Guides

Read when you need detailed process, examples, or edge case handling.

| When to Read | Reference File |
|--------------|----------------|
| Starting Stage 1 or refining vision | `references/1-vision-guide.md` |
| Starting Stage 2 or designing architecture | `references/2-architecture-guide.md` |
| Starting Stage 3 or breaking into milestones | `references/3-milestones-guide.md` |
| Starting Stage 4 or defining tasks per milestone | `references/4-tasks-guide.md` |
