# Planning Guide (Stage 2)

## Goal
Break the work item (PoC, feature, bug fix) into bite-sized, production-grade implementation steps.

## Code Allowed
YES

## ⚠️ ONE WORK ITEM AT A TIME

Only generate implementation plan for:
- The next logical work item (based on dependency graph), OR
- The specific item you explicitly choose

**Why one at a time?**
- Learnings from one work item often change subsequent items
- Keeps planning nimble and agile
- Avoids wasted effort on plans that become obsolete

## Input
- Single work item from `docs/[name]-poc-design.md` OR feature/bug to implement

## Process
1. List all prerequisites (setup Supabase, configure AWS, API keys, etc.)
2. Break implementation into bite-sized steps (max 30 min each)
3. Define verification for EACH step (not just end result)
4. Include specific code snippets, commands, configs
5. Identify what makes this "production-grade" vs "demo"

## Output

One document is created:

**Implementation Plan**: `docs/[name]-implementation.md` using `assets/templates/implementation-plan.md`
- Prerequisites with setup instructions
- Step-by-step implementation guide
- Code snippets, commands, configs
- Verification commands
- **NO status indicators** - keep it clean and focused on "how to implement"

**Note**: The results tracking document (`docs/[name]-results.md`) will be created later during Stage 3 (Execution) when `/dev-execute` is run.

## Verification Checklist
- [ ] Implementation doc created (`docs/[name]-implementation.md`)
- [ ] Prerequisites explicitly listed with setup instructions
- [ ] Each step is small enough to verify independently
- [ ] Each step has clear verification criteria (with code)
- [ ] No step relies on mock data where real data is needed
- [ ] Implementation would work in production context
- [ ] Implementation doc contains NO status indicators (keep it clean)
- [ ] **PoC is self-contained** - fully functional without requiring future PoCs

## What CODE IS Allowed

Unlike Stage 1, implementation planning gets into specifics:
- Concrete code snippets for each step
- Specific function signatures
- Exact commands to run
- Configuration examples
- Test code structure

## Code Quality Principles

**Write production-grade, maintainable code from the start:**

### Object-Oriented Design
- **Classes over functions**: Encapsulate related behavior and state
- **Single Responsibility**: Each class has one clear purpose
- **Composition**: Build complex behavior from simple, composable classes
- **Clear interfaces**: Public methods are intuitive and well-documented

### Strong Typing with Pydantic
- **Use Pydantic models** for all data structures (configs, API payloads, database records)
- **Type everything**: All function signatures, class attributes, variables
- **Validation built-in**: Pydantic handles validation, serialization, and documentation
- **No dictionaries for structured data**: Use Pydantic models instead

## Step Size Guidelines

Each step should be:
- **Completable in ~30 minutes or less**
- **Independently verifiable** (you can prove it works)
- **Self-contained** (doesn't require other steps to test)

If a step is too big, break it into sub-steps (3a, 3b, 3c).

## Self-Contained PoC Requirement

**CRITICAL**: Each PoC must be complete and functional on its own.

**What this means:**
- All existing functionality continues working after PoC completes
- New capability can be tested/verified immediately
- No "TODO: will work after PoC N+1" comments
- Tests pass at end of PoC

**Strategy: Add Alongside, Don't Replace**

When implementing something that could break existing code, add new functions/classes alongside existing ones rather than modifying them. Migration happens in next PoC, not this one.

## Production-Grade Checklist

For each step, ensure:
- [ ] **OOP Design**: Classes with single responsibility, clear interfaces
- [ ] **Pydantic Models**: All data structures use Pydantic (no raw dicts for structured data)
- [ ] **Strong Typing**: Type hints on all functions, methods, and attributes
- [ ] No mock data where real data is needed
- [ ] Real integrations, not stubs
- [ ] Error handling included
- [ ] Would work at 10x scale
- [ ] Tests can be written
- [ ] No breaking changes to existing functionality

## Common Pitfalls
- Steps that are too large
- Missing prerequisites
- No verification criteria
- Mock data that hides real complexity
- Skipping error handling
- **Using raw dicts instead of Pydantic models** (loses validation, type safety, documentation)
- **Procedural code instead of OOP** (harder to test, maintain, extend)
- **Missing type hints** (reduces IDE support, increases bugs)
- **Breaking self-contained requirement** (add alongside don't replace; PoC must work independently without future PoCs)

## Next Stage
→ Stage 3: Execution (use 3-execution-guide.md)

## After Work Complete
→ Return to Stage 2 for next work item
