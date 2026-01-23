# Blocker Spec Template

Use this structure when a P0 blocker is identified that gates all other activities.

---

```markdown
# [Blocker Name] Spec

> **Status:** Design  
> **Version:** 1.0  
> **Created:** [Date]  
> **Priority:** P0 — Blocks all business validation PoCs

---

## Why This Is Priority 0

Every business validation activity requires [what the blocker provides]:

| Activity | Needs |
|----------|-------|
| [Activity 1] | [What it needs from blocker] |
| [Activity 2] | [What it needs from blocker] |
| [Activity 3] | [What it needs from blocker] |

**Without [blocker], we can't run any PoCs.** This is the foundation.

---

## Architecture Overview

```
[ASCII diagram showing how blocker fits into system]
```

**Principle:** [Key architectural decision]

---

## Minimum Viable Scope

Ship the smallest thing that unblocks the PoCs.

### Required Components

| Component | Purpose | Priority |
|-----------|---------|----------|
| [component] | [why needed] | P0 |
| [component] | [why needed] | P0 |
| [component] | [why needed] | P1 (can wait) |

---

## Component Specs

### [Component 1]

[Detailed spec - wireframe, API contract, behavior description]

---

### [Component 2]

[Detailed spec]

---

## Technical Approach

### Tech Stack

| Component | Choice | Rationale |
|-----------|--------|-----------|
| [layer] | [tech] | [why] |

### Integration Points

[How this connects to existing infrastructure]

---

## Implementation Tasks

### Phase 1: [Name]

| Task | Description | Effort |
|------|-------------|--------|
| [task] | [description] | [time] |

**Phase 1 total: ~[X] hours**

---

### Phase 2: [Name]

| Task | Description | Effort |
|------|-------------|--------|
| [task] | [description] | [time] |

**Phase 2 total: ~[X] hours**

---

## Success Criteria

**[Blocker] complete when:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
- [ ] End-to-end: [user journey works]

---

## Open Questions

1. [Question needing decision]
2. [Question needing decision]

---

## Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | [date] | Initial spec |

---

*This is Priority 0. Nothing else moves until this ships.*
```
