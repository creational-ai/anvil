# Business Validation Roadmap Template

Use this structure for the main roadmap output.

---

```markdown
# [Project Name] — Business Validation Roadmap

> **Status:** Draft  
> **Version:** 1.0  
> **Created:** [Date]  
> **Purpose:** Prove or disprove business assumptions through sequenced PoCs before committing to a growth strategy

---

## Critical Blocker

[If P0 blocker identified, state it clearly here]

**[Blocker name] blocks all business validation PoCs.**

The dependency chain:
- [Activity A] → needs blocker resolved
- [Activity B] → needs blocker resolved
- [Activity C] → needs blocker resolved

**Priority 0:** [What must ship first]

See: **[Blocker Spec](./[blocker-spec].md)** for detailed implementation plan.

---

## Current State

### From Mission Control

| Field | Value |
|-------|-------|
| **Project** | [name] |
| **Phase** | [current phase] |
| **Objective** | [objective] |
| **Monthly Cost** | [cost] |
| **Projected MRR** | [projection from MC] |

### Milestones

| Milestone | Status | Notes |
|-----------|--------|-------|
| [name] | ✅ Complete / ⏸️ On Hold / 🔄 Active | [key info] |

### Velocity Evidence

[Pull from completed tasks - execution times, lessons learned]

---

## Assumptions to Validate

| ID | Assumption | Challenge | Validation Method |
|----|------------|-----------|-------------------|
| A1 | [assumption] | [why it might be wrong] | [which PoC tests this] |
| A2 | [assumption] | [why it might be wrong] | [which PoC tests this] |

---

## Realistic Traffic Assessment

| Channel | Effort | Year 1 Volume | Quality | Notes |
|---------|--------|---------------|---------|-------|
| [channel] | Low/Med/High | X-Y users | Intent level | [constraints] |

**Realistic Year 1 total: [X-Y] users**

At [X]% conversion, $[Y] ARPU: **$[Z] MRR** by end of Year 1.

[Compare to original projections if different]

---

## Strategic Paths

### Path A: [Name]

[Description of this strategy]

**Indicators pointing here:**
- [What PoC results would indicate this path]

**Revenue potential:** [estimate]

---

### Path B: [Name]

[Description]

**Indicators pointing here:**
- [What PoC results would indicate this path]

**Revenue potential:** [estimate]

---

### Path C: [Name] (Fallback)

[Description]

**Indicators pointing here:**
- [What PoC results would indicate this path]

---

### Path D: Personal Tool (No SaaS)

[When to stop trying to monetize]

**Indicators pointing here:**
- [Kill criteria]

---

## PoC Sequence

```
Phase 1: [Name] (Week X-Y)
├── PoC 1: [Name]
└── PoC 2: [Name]

Phase 2: [Name] (Week X-Y)
├── PoC 3: [Name]
└── PoC 4: [Name]

Phase 3: [Name] (Week X-Y)
└── PoC 5: [Name]
```

---

## Phase 1: [Name]

**Goal:** [What this phase validates]

### PoC 1: [Name]

**Assumption tested:** [ID from table above]

**Objective:** [What we're proving/disproving]

**Actions:**
- [Step 1]
- [Step 2]

**Success Criteria:**

| Outcome | Metric | Interpretation | Next Step |
|---------|--------|----------------|-----------|
| Strong signal | [metric] | [meaning] | [action] |
| Moderate signal | [metric] | [meaning] | [action] |
| Weak signal | [metric] | [meaning] | [action] |
| No signal | [metric] | [meaning] | [action] |

**Effort:** [time]

**Dependencies:** [what must exist first]

---

[Repeat for each PoC]

---

## Decision Framework

```
                    [Start]
                       │
                       ▼
                [PoC 1: Name]
                       │
          ┌────────────┴────────────┐
          │                         │
     [Result A]                [Result B]
          │                         │
          ▼                         ▼
    [Next PoC]                 [Different PoC]
          │                         │
    [Continue tree...]        [Continue tree...]
```

---

## Prerequisites

| Prerequisite | Status | Blocks |
|--------------|--------|--------|
| [item] | ✅ / ☐ | [what it blocks] |

---

## Success Definition

At the end of this roadmap, we will know:

1. [Question 1 answered]
2. [Question 2 answered]
3. [Question 3 answered]

We will **not** have:
- [What we're explicitly deferring]

---

## Revision History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | [date] | Initial draft |
```
