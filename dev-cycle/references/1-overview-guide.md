# Overview Guide (Stage 1)

## Goal
Analyze features, bugs, issues, or milestones and plan how to address them through structured implementation.

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
- Existing `docs/[name]-poc-design.md` (if applicable)

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

### 4. Break Down into Self-Contained PoCs

**Critical requirement**: Each PoC must be self-contained and **production-grade**

**Why self-contained matters:**
- Each PoC is complete within its scope (doesn't need non-dependent PoCs to work)
- System remains functional between PoCs (no breaking changes to existing functionality/tests)
- Prevents cascading failures
- Clearly shows what it proves and what capabilities it opens up for dependent PoCs
- Safe to pause work at any PoC boundary

**⚠️ CRITICAL: Minimize the Number of PoCs**

**Golden Rule**: One feature = One PoC (unless it spans the entire stack)

**When to use ONE PoC:**
- Feature contained in one layer (frontend OR backend OR database)
- Related tasks that test the same capability together
- CRUD operations for a single entity

**When to split:**
- Feature spans entire stack and each layer needs independent testing
- Clear dependency boundaries (PoC B cannot start until PoC A proven)
- Different technical risks requiring separate validation
- **BUT STILL MINIMIZE** - If you can test 2 layers together, do it

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
- Add new work items to `docs/[name]-poc-design.md`
- **DO NOT renumber existing items** - just add new sequential numbers (e.g., if last item is #5, new items are #6, #7, #8)
- Update dependency graph to show where new items fit
- Verify dependencies still make sense

## Output

Two documents:

1. **Overview**: `docs/[name]-overview.md` using `assets/templates/overview.md`
   - Executive summary
   - Current vs target architecture
   - What needs to change
   - Work item breakdown
   - Implementation approaches
   - Risks and mitigations
   - Design decisions

2. **Updated Plan**: `docs/[name]-poc-design.md`
   - Incorporate new work items
   - Add new sequential numbers
   - Maintain dependency graph

## Verification Checklist

- [ ] Overview document created with all sections
- [ ] Current architecture documented with code examples
- [ ] Target architecture clearly defined
- [ ] All files requiring changes identified
- [ ] Each new PoC is self-contained (works independently, doesn't break existing functionality/tests)
- [ ] PoC dependency order makes sense
- [ ] Implementation approaches evaluated
- [ ] Recommended approach selected with rationale
- [ ] Risks identified with mitigations
- [ ] Design decisions documented
- [ ] `docs/[name]-poc-design.md` updated with new work items

## Common Pitfalls

- **Forgetting self-contained requirement**: Each work item must work independently
- **Breaking changes**: Use "add alongside" strategy, not "replace"
- **Vague definitions**: Be specific about what each item proves
- **Missing dependencies**: Ensure prerequisites are clear
- **Skipping plan update**: Must update plan with new work items

## Next Stage

→ Stage 2: Implementation Planning (use 2-planning-guide.md)
