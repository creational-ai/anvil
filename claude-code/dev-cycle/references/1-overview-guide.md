# Overview Guide (Stage 1)

## Goal
Analyze a task (PoC, Feature, Issue, or Refactor) and design how to implement it.

## Code Allowed
NO

## When This Stage Happens

This stage is **user-initiated**:

1. **User discovers new requirement**: "I found an issue/feature we need to handle"
2. **User requests analysis**: "Are there any new features/issues we should address?"

**Important**: This is NOT automatic. Claude should only create an overview when explicitly asked by the user.

## Input
- Understanding of current architecture (from implemented work)
- New feature or issue identified
- Existing `docs/[slug]-poc-design.md` (if applicable)

## Process

### 1. Document Current Architecture

**What to capture:**
- What components/systems exist today
- How they currently work
- Current dependencies and integrations
- Limitations or constraints

### 2. Define Target Architecture

**What to capture:**
- Desired end state
- How it should work
- What changes from current
- Configuration or extensibility points

### 3. Identify What Needs to Change

**Break down by component/file:**
- Which files need modification
- What currently exists (with code examples)
- What should exist (proposed code)
- How to verify changes work

### 4. Define Scope

**Terminology**:
- **Task** = a unit of work with a Type (PoC, Feature, Issue, Refactor) - this overview is for a single task
- **Step** = implementation sub-unit - only used in Implementation Plans (Stage 2)
- **Scope** = what this task delivers

**Critical requirement**: This task must be self-contained and **production-grade**

**Why self-contained matters:**
- Task is complete within its scope (works independently)
- System remains functional after this task (no breaking changes to existing functionality/tests)
- Prevents cascading failures
- Clearly shows what it proves/delivers
- Safe to pause work after task completion

**Strategy: Add Alongside, Don't Replace**

When new capability could break existing code, add new functions/classes alongside existing ones rather than modifying them. This keeps the system working during implementation.

### 5. Evaluate Implementation Approaches

**Compare options:**
- List 2-4 viable approaches
- For each: Pros, Cons
- Recommend one with rationale

### 6. Document Design Decisions

**Capture key decisions:**
- ✅ What was decided
- Why that choice was made
- What alternatives were considered

### 7. Update Plan

**Final critical step:**
- Add new tasks to `docs/[slug]-poc-design.md`
- **DO NOT renumber existing items** - just add new sequential numbers (e.g., if last item is #5, new items are #6, #7, #8)
- Update dependency graph to show where new items fit
- Verify dependencies still make sense

## Output

**Overview document**: `docs/[milestone-slug]-[task-slug]-overview.md` using `assets/templates/overview.md`

Contents:
- Executive summary (goal, strategy)
- Current vs target architecture
- What needs to change
- Scope (what this task delivers)
- Success criteria
- Implementation approaches
- Risks and mitigations
- Design decisions

**Examples**: `docs/core-poc6-overview.md`, `docs/cloud-auth-fix-overview.md`

## Verification Checklist

- [ ] Overview document created with all sections
- [ ] Current architecture documented with code examples
- [ ] Target architecture clearly defined
- [ ] All files requiring changes identified
- [ ] Scope clearly defined (what this task delivers)
- [ ] Success criteria are specific and measurable
- [ ] Task is self-contained (works independently, doesn't break existing functionality/tests)
- [ ] Implementation approaches evaluated
- [ ] Recommended approach selected with rationale
- [ ] Risks identified with mitigations
- [ ] Design decisions documented

## Common Pitfalls

- **Forgetting self-contained requirement**: Task must work independently
- **Breaking changes**: Use "add alongside" strategy, not "replace"
- **Vague scope**: Be specific about what this task delivers
- **Using "Step" terminology**: Steps are for Implementation Plan, not Overview
- **Listing multiple tasks**: Overview is for a single task only

## Next Stage

→ Stage 2: Implementation Planning (use 2-planning-guide.md)
