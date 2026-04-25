# [Milestone Name] Tasks

## Milestone Overview
[What does completing this Milestone prove? What capability does it unlock?]

## Prerequisite
[Describe the prior milestone's exit state -- what must be true before this milestone starts. Compact list, 3-6 bullets typical.]

- [Prior-milestone output or deliverable the upcoming tasks consume]
- [Capability or system state that must already be validated]
- [Any environmental / account / access prerequisite needed up front]

## Scope

### In
[What this milestone explicitly covers. Keep to capabilities and outcomes, not task-level detail -- the Tasks section below carries the task-level breakdown.]

- [In-scope capability 1]
- [In-scope capability 2]
- [In-scope capability 3]

### Out
[What is explicitly NOT in this milestone -- including forward-looking / deferred items that belong to later milestones. Naming the exclusions here prevents scope creep.]

- [Out-of-scope capability or concern, with brief reason it's deferred]
- [Forward-looking item that will be picked up in a later milestone]

## Task Dependency Diagram

```
┌──────────────────────┐              ┌──────────────────────┐
│  Task 1: [Name]      │              │  Task 2: [Name]      │
│  [Description]       │              │  [Description]       │
└──────────┬───────────┘              └──────────┬───────────┘
           │                                     │
           └─────────────────┬───────────────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │  Task 3: [Name]      │
                  │  [Description]       │
                  └──────────┬───────────┘
                             │
                 ┌───────────┴───────────┐
                 │                       │
                 ▼                       ▼
      ┌──────────────────────┐   ┌──────────────────────┐
      │  Task 4: [Name]      │   │  Task 5: [Name]      │
      │  [Description]       │   │  [Description]       │
      └──────────┬───────────┘   └──────────┬───────────┘
                 │                           │
                 └───────────┬───────────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │  Task 6: [Name]      │
                  │  [Description]       │
                  └──────────────────────┘
```

**Parallel tracks**: [Describe which tasks can run in parallel]

## Tasks

### Task 1: [Name]
- **Type**: [PoC / Feature / Issue / Refactor]
- **Validates**: [What this task proves/delivers/fixes]
- **Unlocks**: [Which tasks depend on this]
- **Success Criteria**: [Measurable outcome]

### Task 2: [Name]
- **Type**: [PoC / Feature / Issue / Refactor]
- **Validates**: [What this task proves/delivers/fixes]
- **Unlocks**: [Which tasks depend on this]
- **Success Criteria**: [Measurable outcome]

### Task 3: [Name]
...

## Execution Order
1. Task 1: [Name] (no dependencies)
2. Task 2: [Name] (no dependencies)
3. Task 3: [Name] (requires Task 1, Task 2)
4. ...

## Integration Points
[How will these tasks eventually connect?]

## Risk Assessment
| Task | Risk Level | Mitigation |
|------|------------|------------|
| Task 1: [Name] | [HIGH/MED/LOW] | [Strategy] |

## Feedback Loops

### If a Task Fails

**A failed task is valuable information, not wasted effort.**

When a task doesn't meet success criteria:

1. **Document what we learned** — What specifically failed? Why?
2. **Assess impact** — Does this invalidate the milestone approach? Or just this task?
3. **Decide next action**:
   - **Retry with different approach** — Update task design and re-attempt
   - **Pivot the milestone** — Revisit milestones doc with new constraints
   - **Revisit architecture** — If fundamental assumption was wrong
   - **Kill the milestone** — If the capability isn't achievable/valuable

### Checkpoint Questions

After each task, ask:
- Did we learn something that changes our assumptions?
- Should we update subsequent task designs based on this learning?
- Is the milestone still viable and valuable?
