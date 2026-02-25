# [Milestone Name] Task Spec

## Milestone Overview
[What does completing this Milestone prove? What capability does it unlock?]

## Project
[Parent project name - link to [slug]-vision.md]

## Task Dependency Diagram

```
┌──────────────────────┐              ┌──────────────────────┐
│  [Name]              │              │  [Name]              │
│  [Description]       │              │  [Description]       │
└──────────┬───────────┘              └──────────┬───────────┘
           │                                     │
           └─────────────────┬───────────────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │  [Name]              │
                  │  [Description]       │
                  └──────────┬───────────┘
                             │
                 ┌───────────┴───────────┐
                 │                       │
                 ▼                       ▼
      ┌──────────────────────┐   ┌──────────────────────┐
      │  [Name]              │   │  [Name]              │
      │  [Description]       │   │  [Description]       │
      └──────────┬───────────┘   └──────────┬───────────┘
                 │                           │
                 └───────────┬───────────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │  [Name]              │
                  │  [Description]       │
                  └──────────────────────┘
```

**Parallel tracks**: [Describe which tasks can run in parallel]

**Note**: This is a plan - NO status indicators (✅ ⬜) in diagram.

## Tasks

### [Name]
- **Type**: [PoC / Feature / Issue / Refactor]
- **Validates**: [What this task proves/delivers/fixes]
- **Unlocks**: [Which tasks depend on this]
- **Success Criteria**: [Measurable outcome]

### [Name]
- **Type**: [PoC / Feature / Issue / Refactor]
- **Validates**: [What this task proves/delivers/fixes]
- **Unlocks**: [Which tasks depend on this]
- **Success Criteria**: [Measurable outcome]

### [Name]
...

## Execution Order
1. [Name] (no dependencies)
2. [Name] (no dependencies)
3. [Name] (requires [Name])
4. ...

## Integration Points
[How will these tasks eventually connect?]

## Risk Assessment
| Task | Risk Level | Mitigation |
|------|------------|------------|
| [Name] | [H/M/L] | [Strategy] |

## Feedback Loops

### If a Task Fails

**A failed task is valuable information, not wasted effort.**

When a task doesn't meet success criteria:

1. **Document what we learned** — What specifically failed? Why?
2. **Assess impact** — Does this invalidate the milestone approach? Or just this task?
3. **Decide next action**:
   - **Retry with different approach** — Update task design and re-attempt
   - **Pivot the milestone** — Revisit milestone spec with new constraints
   - **Revisit architecture** — If fundamental assumption was wrong
   - **Kill the milestone** — If the capability isn't achievable/valuable

### Checkpoint Questions

After each task, ask:
- Did we learn something that changes our assumptions?
- Should we update subsequent task designs based on this learning?
- Is the milestone still viable and valuable?
