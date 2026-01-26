# [Milestone-Slug]-[Task-Slug] Design

> **Purpose**: Analyze problems and design solutions before implementation planning
>
> **Important**: This task must be self-contained (works independently; doesn't break existing functionality and existing tests)

## Executive Summary

| Attribute | Value |
|-----------|-------|
| **Created** | [YYYY-MM-DDTHH:MM:SS-TZ] |
| **Task** | [Brief description of what needs to be done] |
| **Type** | [PoC / Feature / Issue / Refactor] |
| **Scope** | [What areas/components are affected] |
| **Code** | NO - This is a design document |

**Problem**: [One sentence describing the core problem]

**Solution**: [One sentence describing the proposed solution approach]

---

## Context

### Current State

[Describe what exists today - the starting point]

- [Current behavior/implementation 1]
- [Current behavior/implementation 2]
- [Limitations or issues]

### Target State

[Describe the desired end state]

- [Desired behavior 1]
- [Desired behavior 2]
- [Benefits achieved]

---

## Problem Analysis

> Each problem is analyzed independently. No implied order - read in any sequence.

### Problem 1: [Problem Name]

**What**: [Description of the issue]

**Why**: [Impact and importance - why this matters]

**Approach**: [How we'll solve it - NO CODE, concepts only]

---

### Problem 2: [Problem Name]

**What**: [Description of the issue]

**Why**: [Impact and importance]

**Approach**: [How we'll solve it]

---

### Problem N: [Problem Name]

**What**: [Description of the issue]

**Why**: [Impact and importance]

**Approach**: [How we'll solve it]

---

## Proposed Steps

> Synthesized from Problem Analysis above. Sequential order matters here.

Based on the problem analysis above, here is the proposed implementation sequence:

### Step 1: [Step Name]

**Addresses**: [Problem 1, Problem 3, etc.]
**What**: [What this step accomplishes]
**Why Here**: [Why this step comes at this position in the sequence]
**Dependencies**: [What must exist before this step - or "None"]

### Step 2: [Step Name]

**Addresses**: [Problem X, Problem Y]
**What**: [What this step accomplishes]
**Why Here**: [Why this step comes here]
**Dependencies**: [Step 1, or specific outputs needed]

### Step N: [Final Step Name]

**Addresses**: [Remaining problems]
**What**: [What this step accomplishes]
**Why Last**: [Why this is the final step]
**Dependencies**: [Steps 1 through N-1]

---

## Success Criteria

- [ ] [Criterion 1 - specific, measurable]
- [ ] [Criterion 2 - specific, measurable]
- [ ] [Criterion 3 - specific, measurable]
- [ ] All existing tests pass
- [ ] New functionality works independently

---

## Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | H/M/L | H/M/L | [How to mitigate] |
| [Risk 2] | H/M/L | H/M/L | [How to mitigate] |

---

## Open Questions

1. **[Question 1]**: [What needs to be decided and when]
2. **[Question 2]**: [What needs to be decided and when]

---

## Decisions Log

| Decision | Choice | Rationale |
|----------|--------|-----------|
| [Decision 1] | [What was chosen] | [Why] |
| [Decision 2] | [What was chosen] | [Why] |

---

## Next Steps

1. Review this design and confirm approach
2. Run `/verify-doc` to check for issues
3. Create implementation plan (`/dev-plan`)
4. Execute implementation (`/dev-execute`)
