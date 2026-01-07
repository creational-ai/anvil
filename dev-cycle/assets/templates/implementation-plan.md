# [Name] Implementation Plan

> **Track Progress**: See `docs/[name]-results.md` for implementation status, test results, and issues.

## Overview

| Attribute | Value |
|-----------|-------|
| **Name** | [Name] |
| **Proves** | [What this validates] |
| **Production-Grade Because** | [Why this isn't a toy/mock] |

> ⚠️ **Self-Contained Requirement**: This work must be complete and functional on its own. All existing functionality must continue working. If adding new capability could break existing code, add alongside (don't replace). See `references/2-planning-guide.md` for details.

---

## Prerequisites

Complete these BEFORE starting implementation steps.

### 1. [Prerequisite Name]

**Why Needed**: [Why this PoC requires it]

**Steps**:
1. [Setup step 1]
2. [Setup step 2]
3. [Setup step 3]

**Commands**:
```bash
# [Description]
[actual commands to run]
```

**Verification**:
```bash
# [What to verify]
[command to verify it's working]
# Expected: [what success looks like]
```

### 2. [Prerequisite Name]
...

---

## Success Criteria

From `docs/[source-doc].md`:

- [ ] [Criterion 1 - specific, measurable]
- [ ] [Criterion 2 - specific, measurable]
- [ ] [Criterion 3 - specific, measurable]
- [ ] [Criterion 4 - specific, measurable]

---

## Architecture

### File Structure
```
[project-root]/
├── [new-folder]/
│   ├── __init__.py           # [Purpose]
│   ├── [file1.py]            # [Purpose]
│   └── [file2.py]            # [Purpose]
├── [existing-file.py]        # Updated
└── tests/
    └── test_[name]_*.py # All tests
```

### Design Principles
1. **OOP Design**: Use classes with single responsibility and clear interfaces
2. **Pydantic Models**: All data structures (configs, payloads, records) use Pydantic BaseModel
3. **Strong Typing**: Type hints on all functions, methods, and class attributes
4. **[Additional Principle]**: [Description if needed]

---

## Implementation Steps

**Approach**: [Brief description of implementation strategy - e.g., "Build bottom-up", "Test each layer independently", etc.]

### Step 0: [Setup/Infrastructure]

**Goal**: [What this step accomplishes]

**Tasks**:
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

**Code**:
```bash
# [Description of what these commands do]
[actual commands to run]
```

**Verification**:
```bash
[command to verify step is complete]
# Expected: [what success looks like]
```

**Output**: [What's created/changed]

---

### Step 1: [Name] + Tests

**Goal**: [What this step accomplishes]

**Tasks**:
- [ ] [Implementation task 1]
- [ ] [Implementation task 2]
- [ ] [Write tests]

**Code** (add to `[file-path]`):
```python
"""[Description]."""

[actual code to write]
```

**Tests** (add to `tests/test_[name]_*.py`):
```python
"""Tests for [what this step does]."""

class Test[ClassName]:
    """Tests for [component]."""

    def test_[what_it_tests](self):
        """[Description]."""
        # Arrange
        [setup]

        # Act
        [action]

        # Assert
        [verification]
```

**Verification**:
```bash
cd [directory] && uv run pytest tests/test_[name]_*.py::Test[ClassName] -v
```

**Output**: [X]/[X] tests passing

---

### Step 2: [Name] + Tests

**Goal**: [What this step accomplishes]

**Tasks**:
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Write tests]

**Code** (update `[file-path]`):
```python
[actual code to write]
```

**Tests** (add to `tests/test_[name]_*.py`):
```python
class Test[ClassName]:
    """Tests for [component]."""

    def test_[scenario](self):
        """[Description]."""
        [test code]
```

**Verification**:
```bash
cd [directory] && uv run pytest tests/test_[name]_*.py::Test[ClassName] -v
```

**Output**: [X]/[X] tests passing

---

### Step [N]: [Final Integration/Validation]

**Goal**: [What this final step accomplishes]

**Tasks**:
- [ ] [Integration task 1]
- [ ] [Integration task 2]
- [ ] [Final validation]

**Tests** (add to `tests/test_[name]_*.py`):
```python
class Test[Integration]:
    """Integration tests for [PoC name]."""

    def test_[end_to_end_scenario](self):
        """[Description]."""
        [test code]
```

**Verification**:
```bash
# Run all tests for this work
cd [directory] && uv run pytest tests/test_[name]_*.py -v

# Verify existing tests still pass
cd [directory] && uv run pytest tests/ -v --ignore=tests/test_[name]_*.py
```

**Output**: All tests passing ([total-new] new + [total-existing] existing = [total] tests)

---

## Test Summary

### After Implementation Complete

| Test File | Tests | What It Covers |
|-----------|-------|----------------|
| `tests/test_[existing]_*.py` | X | [Description] |
| `tests/test_[name]_*.py` | X | [This work] |

**Total Expected: [X] tests**

**Test Breakdown ([Name])**:
- Test[Class1]: X tests
- Test[Class2]: X tests
- Test[Integration]: X tests

---

## Production-Grade Checklist

Before marking PoC complete, verify:

- [ ] **OOP Design**: Classes with single responsibility and clear interfaces
- [ ] **Pydantic Models**: All data structures use Pydantic (no raw dicts for structured data)
- [ ] **Strong Typing**: Type hints on all functions, methods, and class attributes
- [ ] **No mock data**: All data comes from real sources (DB, API, files)
- [ ] **Real integrations**: External services are actually connected, not stubbed
- [ ] **Error handling**: Failures are handled, not ignored
- [ ] **Scalable patterns**: Code structure would work at 10x scale
- [ ] **Tests exist**: pytest covers the critical paths
- [ ] **Config externalized**: No hardcoded secrets or environment-specific values
- [ ] **Clean separation**: Each file has single responsibility
- [ ] **Self-contained**: Works independently; all existing functionality still works; doesn't require future PoCs

---

## What "Done" Looks Like

```bash
# 1. All new tests pass
cd [directory] && uv run pytest tests/test_[name]_*.py -v

# 2. All existing tests still pass
cd [directory] && uv run pytest tests/ -v --ignore=tests/test_[name]_*.py

# 3. [Specific functionality works]
[command to demonstrate]
# Expected output:
[what success looks like]

# 4. [Clean imports work]
cd [directory] && uv run python -c "
[import statements to verify]
print('✓ All imports successful')
"
```

---

## Files to Create/Modify

| File | Action | Status |
|------|--------|--------|
| `[path/to/new-file.py]` | Create | Pending: [purpose] |
| `[path/to/existing-file.py]` | Modify | Pending: [what changes] |
| `tests/test_[name]_*.py` | Create | Pending: all tests |
| `pyproject.toml` | Modify | Pending: [dependencies] |

---

## Dependencies

Update `[path/to/pyproject.toml]`:

```toml
dependencies = [
    "[existing-dep]>=X.Y.Z",
    "[new-dep]>=X.Y.Z",  # Add for [reason]
    ...
]
```

Then run:
```bash
cd [directory] && uv sync
```

---

## Risks & Mitigations

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| [Risk 1] | H/M/L | [Strategy] |
| [Risk 2] | H/M/L | [Strategy] |

---

## Error Codes Reference

_(Optional - only if this PoC introduces new error codes)_

| Code | Meaning | Used By |
|------|---------|---------|
| `[ERROR_CODE]` | [Description] | [function/tool] |

---

## Next Steps After Completion

1. ✅ Verify all tests pass ([total] total)
2. ✅ Verify [specific success criteria]
3. → Proceed to next task: [Next task]
