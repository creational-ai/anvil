# Stage 4: Tasks

## Goal
Define atomic tasks with dependencies and success criteria -- with PRODUCTION-GRADE thin slices.

## Code Allowed
NO

## Timeline Estimates
NOT NEEDED - Focus on WHAT and WHY, not WHEN. Avoid timeline estimates (e.g., "Week 1-2", "2 weeks", "3 months"). Design phases don't need schedules.

## Input
- Milestones doc from `docs/[project-slug]-milestones.md` (Stage 3 output)
- Architecture doc (`docs/[project-slug]-architecture.md`) (Stage 2 output)

**Note**: Run this stage once per milestone, starting with Core.

## Process
1. Refine architecture with implementation perspective
2. Identify atomic tasks
3. Map dependencies between tasks
4. Create task diagram
5. Define success criteria for each task

## Output
`docs/[milestone-slug]-tasks.md` using `assets/templates/4-tasks.md`

Example: `docs/core-tasks.md`, `docs/cloud-tasks.md`

## Section Descriptions

The template carries 2 milestone-bounding sections (Prerequisite, Scope) that frame the milestone before tasks are enumerated. Use this section to understand what each should contain and when to fill it.

### Prerequisite
**Purpose**: Describe the prior milestone's exit state -- what must already be true before this milestone's tasks can start. Gives the reader (and executor) a clear entry condition.

**When to fill**: For any milestone that has a dependency on a prior milestone's output. For the very first milestone (no prior), either list environmental/account/access prerequisites or write a single bullet stating "No prior milestone -- project-level prerequisites only."

**Example content**:
- Authentication service from Core milestone deployed and callable from the frontend
- Users table populated with at least the 4 seed accounts used for integration testing
- `API_BASE_URL` env var set in staging environment

### Scope
**Purpose**: Draw a bounded box around what this milestone covers. `In` lists capabilities the milestone delivers; `Out` lists capabilities explicitly deferred (including forward-looking work that might live in a later milestone).

**When to fill**: Always. Scope is the primary scope-creep guard -- every task in the Tasks section should map to an In bullet, and every "we're not doing this yet" conversation should resolve to an Out bullet.

**Example content**:
- **In**: User CRUD end-to-end, role-based authorization, password reset email flow
- **Out**: SSO / OAuth integration (later milestone); admin audit log UI (later milestone); rate-limiting middleware (cross-cutting, handled at the architecture level)

## What This Doc Does NOT Contain

The 4-tasks template is intentionally lean. The following sections — common in heavier per-milestone design templates and in levelplay's real-usage pattern — are explicitly NOT included in 4-tasks:

**Explicit cuts (8 sections)** -- each with relocation target if any:

| Cut section | Origin | Relocation target |
|-------------|--------|-------------------|
| Executive Summary | per-milestone design template | None -- duplicates Milestone Overview |
| Architecture Overview + Technology Stack | per-milestone design template | `docs/[project-slug]-architecture.md` (Stage 2 output -- structural decisions live there) |
| Core Components Design | per-milestone design template | `docs/[project-slug]-architecture.md` (Stage 2 output) |
| Testing Strategy | per-milestone design template | Per-task Success Criteria + dev-skill's plan.md Prerequisites (test identification happens at execution time) |
| Design Decisions & Rationale | per-milestone design template | `docs/[project-slug]-architecture.md` (Stage 2 output) or per-task design doc in dev skill |
| Open Questions | per-milestone design template | None -- resolved during planning, not tracked as a doc section |
| Exit Checklist | levelplay real-usage pattern | Per-task Success Criteria (for the 7 of 9 levelplay entries that restate per-task completion); Feedback Loops Checkpoint Questions (for the 2 unique cross-milestone regression entries) |
| After [Milestone] | levelplay real-usage pattern | Scope's `Out` subsection (as forward-looking / deferred notes -- answers the same "what's not in this milestone" question) |

**Group-handled drops (7 canonical-template H2s, never used in real milestones)**:
- Implementation Phases
- Success Metrics
- Key Outcomes
- Why [This Approach]?
- Risks & Mitigation -- maps to the existing `## Risk Assessment` in this template
- Next Steps
- Related Documents

Of these 7, only `Risks & Mitigation` has a relocation target (`## Risk Assessment` in the tasks template). The remaining 6 are silently dropped -- levelplay's real milestone docs never carried them, so they never provided value to retain.

## Verification Checklist
- [ ] Template read from `assets/templates/4-tasks.md`
- [ ] Output follows template structure exactly
- [ ] Each task validates one specific thing
- [ ] Dependencies mapped (which tasks unlock others)
- [ ] Success criteria measurable
- [ ] Order of execution clear
- [ ] Feedback loop guidance included
- [ ] Run `/review-doc docs/[milestone-slug]-tasks.md`

## What Makes a Good Task

### A Task Should:
- Validate ONE specific technical or business assumption
- Be small enough to complete in 1-3 sessions
- Have clear, measurable success criteria
- Build toward the final MVP

### A Task Should NOT:
- Try to validate multiple things at once
- Be so large it feels like a project itself
- Have vague "it works" success criteria
- Be disconnected from the end goal

## Task Requirements

Each task must be:
- **Atomic**: Validates one specific thing (one capability/assumption, NOT one sub-task - may include multiple related sub-tasks)
- **Measurable**: Clear success criteria
- **Self-contained**: Works independently; doesn't break existing functionality and existing tests

**Why self-contained matters:**
- Each task is complete within its scope (doesn't need non-dependent tasks to work)
- System remains functional between tasks (no breaking changes to existing functionality/tests)
- Prevents cascading failures
- Clearly shows what it validates and what capabilities it opens up for dependent tasks
- Safe to pause work at any task boundary

## Task Types

Each task has a Type that determines its framing:

| Type | Purpose | Validates |
|------|---------|-----------|
| **PoC** | Validate technical approach or assumption | "Can we do X?" |
| **Feature** | Deliver new capability | "X works end-to-end" |
| **Issue** | Fix a bug | "X no longer occurs" |
| **Refactor** | Improve code structure | "X works the same but better" |

**New projects** typically start with PoC-type tasks (proving technical feasibility).
**Established projects** mix Feature, Issue, and Refactor tasks.
**A single tasks doc can contain mixed types** -- e.g., Database Schema (PoC), User Management (Feature).

**CRITICAL: Minimize the Number of Tasks**

**Golden Rule**: One capability = One task (unless it spans the entire stack)

**When to use ONE task:**
- Feature is contained in one layer (frontend OR backend OR database)
- Related sub-tasks that test the same capability together
- CRUD operations for a single entity (Create + Read + Update + Delete users)
- All sub-tasks validate the same technical assumption

**When to split into multiple tasks:**
- Feature spans entire stack (database + API + frontend) and each layer needs independent testing
- Clear dependency boundaries (Task B literally cannot start until Task A is validated)
- Different technical risks that should be validated separately
- **BUT STILL MINIMIZE** - If you can test 2 layers together, do it

**GOOD - Minimized tasks:**
```
Task 1: User Management (One task)
   - Database schema for users
   - CRUD API endpoints
   - Authentication logic
   - Tests for all operations
   - Validates: "We can manage users end-to-end"
```

**BAD - Too many micro-tasks:**
```
Task 1: User Database Schema
Task 2: Create User API
Task 3: Read User API
Task 4: Update User API
Task 5: Delete User API
Task 6: User Authentication
```

**When forced to split (e.g., full-stack feature):**
```
Task 1: User Management Backend
   - Database + API + Auth (grouped)
   - Validates: "Backend handles users correctly"

Task 2: User Management Frontend
   - UI components + forms + state
   - Validates: "Frontend integrates with user API"
```

**Remember**: Every additional task adds overhead. Group related work aggressively.

## Task Dependency Mapping

Create a diagram showing:
- Which tasks can run in parallel (no dependencies)
- Which tasks depend on others
- The critical path to MVP

**Format**: Use boxes for each task with clear names. No status indicators (this is a plan, not status tracking).

Example:
```
+-----------------------------+              +-----------------------------+
|  Task 1: Database Schema    |              |  Task 2: API Server Basic   |
+-------------+---------------+              +-------------+---------------+
              |                                            |
              +--------------------+-----------------------+
                                   |
                                   v
                     +-----------------------------+
                     |  Task 3: CRUD Operations    |
                     +-------------+---------------+
                                   |
                      +------------+------------+
                      |                         |
                      v                         v
        +-----------------------------+   +-----------------------------+
        |  Task 4: Analytics          |   |  Task 5: Reports            |
        +-------------+---------------+   +-------------+---------------+
                      |                                 |
                      +------------+------------+-------+
                                   |
                                   v
                     +-----------------------------+
                     |  Task 6: E2E Integration    |
                     +-----------------------------+
```

**Key Points**:
- Each task gets a box with its name and brief description
- Use vertical flow (top to bottom) for main dependency path
- Show parallel tasks side by side at the same level
- Use arrows to show dependencies
- Keep it clean - NO status indicators in the plan diagram


## Production-Grade Reminder

Even at planning stage, think production:
- Real databases, not mock data
- Real APIs, not stubs
- Real error handling, not happy-path only
- Patterns that scale

## Feedback Loops: When Tasks Fail

**A failed task is valuable information, not wasted effort.**

When a task doesn't meet success criteria:

1. **Document what we learned** -- What specifically failed? Why?
2. **Assess impact** -- Does this invalidate the milestone approach? Or just this task?
3. **Decide next action**:
   - **Retry with different approach** -- Update task design and re-attempt
   - **Pivot the milestone** -- Revisit the milestones doc with new constraints
   - **Revisit architecture** -- If fundamental assumption was wrong
   - **Kill the milestone** -- If the capability isn't achievable/valuable

**Checkpoint Questions** (after each task):
- Did we learn something that changes our assumptions?
- Should we update subsequent task designs based on this learning?
- Is the milestone still viable and valuable?

## Common Pitfalls
- Planning too many tasks
- Tasks that are too large
- Missing critical dependencies
- Vague success criteria

## Next Stage
-> Hand off to dev skill for implementation
