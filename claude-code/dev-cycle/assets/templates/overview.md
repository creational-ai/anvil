# [Milestone-Slug]-[Task-Slug] Overview

> **Purpose**: Analyze and design a task before implementation
>
> **Important**: This task must be self-contained (works independently; doesn't break existing functionality and existing tests)

## Executive Summary

**Goal**: [What needs to be achieved]

**Strategy**: [High-level approach]

**Migration Approach**: [How to transition from current to target state]

---

## Current Architecture

### What We Have Today

**1. [Component/System 1]**
- [Current implementation details]
- [Dependencies]
- [Limitations]

**2. [Component/System 2]**
- [Current implementation details]
- [What it does]

**3. Current Dependencies**
```[language]
# [File/module]
[code example showing current implementation]
```

---

## Target Architecture

### Desired State

```
[High-level architecture diagram or description]
Component A
    ↓
Component B (NEW)
    ↓
    ├─→ Implementation 1
    └─→ Implementation 2
```

### Configuration-Based Behavior

```bash
# .env for Option 1
[config examples]

# .env for Option 2
[config examples]
```

---

## What Needs to Change

### 1. [Component/File 1] ([N] files)

#### `[file-path]`
**Current**: [What it does now]
```[language]
[current code]
```

**New**: [What it should do]
```[language]
[proposed code]
```

**Validation**: [How to verify changes work]

---

### 2. [Component/File 2]

#### `[file-path]`
...

---

## Scope

What this task delivers:

- [Capability/change 1]
- [Capability/change 2]
- [Capability/change 3]

**Self-Contained Strategy**:
- **Keep** [existing function/behavior] unchanged
- **Add** [new function/behavior] alongside
- **Why**: Ensures all existing functionality continues working

---

## Success Criteria

- [ ] [Criterion 1 - specific, measurable]
- [ ] [Criterion 2 - specific, measurable]
- [ ] [Criterion 3 - specific, measurable]
- [ ] All existing tests pass
- [ ] New functionality works independently

---

## Implementation Approaches

### Option A: [Approach Name] (Recommended)

**Pros**:
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

**Cons**:
- [Drawback 1]
- [Drawback 2]

---

### Option B: [Alternative Approach]

**Pros**:
- [Benefit 1]
- [Benefit 2]

**Cons**:
- [Drawback 1]
- [Drawback 2]

---

### Option C: [Another Alternative]

**Pros**:
...

**Cons**:
...

---

## Recommended Approach

**[Option Name] (Option [A/B/C])** for these reasons:

1. **[Reason 1]**: [Explanation]
2. **[Reason 2]**: [Explanation]
3. **[Reason 3]**: [Explanation]
4. **[Reason 4]**: [Explanation]
5. **[Reason 5]**: [Explanation]

---

## Files Requiring Changes

| File | Change Type | Complexity |
|------|-------------|------------|
| `[file-path]` | [Create/Modify/Refactor] | [Low/Medium/High] |
| `[file-path]` | [Create/Modify/Refactor] | [Low/Medium/High] |

---

## Testing Strategy

### 1. [Testing Approach 1]

```[language]
# [test file or approach]
[example test code or description]
```

### 2. [Testing Approach 2]

...

---

## Risks & Mitigations

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| [Risk 1] | H/M/L | [How to mitigate] |
| [Risk 2] | H/M/L | [How to mitigate] |
| [Risk 3] | H/M/L | **Out of scope**. [Why deferring is acceptable] |

---

## Design Decisions Made

1. ✅ **[Decision 1]**: [Description and rationale]
2. ✅ **[Decision 2]**: [Description and rationale]
3. ✅ **[Decision 3]**: [Description and rationale]
4. ✅ **[Decision 4]**: [Description and rationale]

---

## Open Questions (For Later)

1. **[Question 1]**: [What needs to be decided later and when]
2. **[Question 2]**: [What needs to be decided later and when]
3. **[Question 3]**: [What needs to be decided later and when]

---

## Next Steps

1. Review this overview and confirm approach
2. Run `/verify-doc` to check for issues
3. Create implementation plan (`/dev-plan`)
4. Execute implementation (`/dev-execute`)
