# Design Guide (Stage 1)

## Goal

Analyze problems and design solutions for a task (PoC, Feature, Issue, or Refactor) before implementation planning.

## Code Allowed

NO

## When This Stage Happens

This stage is **user-initiated**:

1. **User discovers new requirement**: "I found an issue/feature we need to handle"
2. **User requests analysis**: "Are there any new features/issues we should address?"

**Important**: This is NOT automatic. Claude should only create a design when explicitly asked by the user.

## Input

- Understanding of current architecture (from implemented work)
- New feature or issue identified
- Existing `docs/[slug]-poc-design.md` (if applicable)

## Key Concept: Two-Section Structure

Stage 1 produces a design document with two distinct sections:

### Part A: Problem Analysis (Non-Sequential)

- Each problem gets its own subsection
- Analyzed independently - no implied order
- Can be read in any sequence
- Format for each problem:
  - **What**: Description of the issue
  - **Why**: Impact and importance
  - **Approach**: How we'll solve it (concepts only, NO CODE)

### Part B: Proposed Steps (Sequential)

- Synthesizes Problem Analysis into ordered implementation steps
- Each step references which problem(s) it addresses
- Shows logical flow and dependencies
- Format for each step:
  - **Addresses**: Which problem(s) this step solves
  - **What**: What this step accomplishes
  - **Why Here**: Why this step comes at this position
  - **Dependencies**: What must exist before this step

## Process

### 1. Establish Context

**Document current state:**
- What components/systems exist today
- How they currently work
- Limitations or issues

**Define target state:**
- Desired end state
- How it should work
- Benefits achieved

### 2. Analyze Problems (Non-Sequential)

For each distinct problem or issue:

**Create a subsection with:**
- **What**: Clear description of the issue
- **Why**: Why it matters (impact, importance)
- **Approach**: How we'll solve it (concepts, not code)

**Guidelines:**
- Each problem is independent - no implied order
- Don't reference "first we do X, then Y" - that's for Proposed Steps
- Focus on understanding before sequencing
- Include all problems, even small ones

**Example:**
```markdown
### Problem 1: Misleading Document Name

**What**: "Overview" suggests a summary, but Stage 1 is core design work.

**Why**: Users may skip or undervalue Stage 1, thinking it's optional.

**Approach**: Rename from "overview" to "design" throughout all files.
```

### 3. Synthesize Proposed Steps (Sequential)

After analyzing all problems, synthesize into ordered steps:

**For each step:**
- **Addresses**: List which problem(s) from Part A
- **What**: What this step accomplishes
- **Why Here**: Why this position in the sequence
- **Dependencies**: What must exist first (prior steps or "None")

**Guidelines:**
- Order matters - logical flow
- Each step should address one or more problems
- Show traceability back to Problem Analysis
- Still NO CODE - just ordering and rationale

**Example:**
```markdown
### Step 1: Create New Template

**Addresses**: Problem 4 (Template Structure)
**What**: Create new design.md template with two-section structure
**Why First**: Template is the foundation - drives all other changes
**Dependencies**: None
```

### 4. Ensure Self-Contained Scope

**Critical requirement**: This task must be self-contained and **production-grade**

**Why self-contained matters:**
- Task is complete within its scope (works independently)
- System remains functional after this task (no breaking changes)
- Prevents cascading failures
- Safe to pause work after task completion

**Strategy: Add Alongside, Don't Replace**

When new capability could break existing code, add new functions/classes alongside existing ones rather than modifying them.

### 5. Document Decisions

**Capture key decisions:**
- What was decided
- Why that choice was made
- What alternatives were considered

Use the Decisions Log table in the template.

### 6. Update Plan (If Applicable)

**If this task relates to a PoC plan:**
- Add new tasks to `docs/[slug]-poc-design.md`
- **DO NOT renumber existing items** - just add new sequential numbers
- Update dependency graph
- Verify dependencies still make sense

## Output

**Design document**: `docs/[milestone-slug]-[task-slug]-design.md` using `assets/templates/1-design.md`

**Contents:**
- Executive summary (problem + solution one-liners)
- Context (current state, target state)
- Problem Analysis (non-sequential, each problem independently)
- Proposed Steps (sequential, synthesized from analysis)
- Success criteria
- Risks and mitigations
- Open questions
- Decisions log

**Examples**: `docs/core-poc6-design.md`, `docs/cloud-auth-fix-design.md`

## Verification Checklist

- [ ] Design document created with all sections
- [ ] Current and target state clearly defined
- [ ] Each problem analyzed with What/Why/Approach
- [ ] Problems are independent (no sequencing in Problem Analysis)
- [ ] Proposed Steps synthesized from Problem Analysis
- [ ] Each step references which problem(s) it addresses
- [ ] Step order is logical with clear dependencies
- [ ] Task is self-contained (works independently, doesn't break existing functionality/tests)
- [ ] Risks identified with mitigations
- [ ] Design decisions documented
- [ ] No code written (only concepts and descriptions)

## Common Pitfalls

- **Mixing analysis with sequencing**: Keep Problem Analysis non-sequential; save ordering for Proposed Steps
- **Forgetting traceability**: Each Proposed Step should reference which Problem(s) it addresses
- **Writing code**: Stage 1 is NO CODE - save implementation details for Stage 2
- **Breaking changes**: Use "add alongside" strategy, not "replace"
- **Vague problems**: Be specific about What and Why for each problem
- **Listing multiple tasks**: Design is for a single task only

## Next Stage

→ Stage 2: Planning (use `references/2-planning-guide.md`)

User should review design, run `/verify-doc`, fix issues, then request Stage 2.
