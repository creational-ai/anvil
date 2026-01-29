---
description: Bump Python package version and create git tag
disable-model-invocation: true
argument-hint: [patch | minor | major | X.Y.Z]
---

# Bump Version

Bump the Python package version, create a git tag, and commit/push.

## Arguments (optional)

- `patch` - Bump patch version (0.1.0 → 0.1.1)
- `minor` - Bump minor version (0.1.0 → 0.2.0)
- `major` - Bump major version (0.1.0 → 1.0.0)
- `X.Y.Z` - Set specific version (e.g., `1.2.3`)
- (no argument) - Auto-detect appropriate bump based on changes

## Instructions

1. **Check for uncommitted changes**:
   ```bash
   git status
   ```
   - If uncommitted changes exist: ABORT
   - "Uncommitted changes. Run `/commit-and-push` or `/commit-bump-push` first."

3. **Find current version** in `pyproject.toml`:
   ```
   version = "X.Y.Z"
   ```

4. **Check if current version is already tagged**:
   ```bash
   git tag -l "vX.Y.Z"
   ```
   - If tag does NOT exist for current version → just create the tag (no bump needed)
   - If tag exists → proceed with version bump

5. **Determine bump type** based on argument ($ARGUMENTS):
   - If `patch`: increment Z
   - If `minor`: increment Y, reset Z to 0
   - If `major`: increment X, reset Y and Z to 0
   - If specific version (X.Y.Z format): use that version
   - If no argument: default to `patch`

6. **Update version** in:
   - `pyproject.toml` - the `version = "..."` line
   - `__init__.py` with `__version__` (if exists)

7. **Commit version bump**:
   ```bash
   git add -A
   git commit -m "Bump to vX.Y.Z"
   ```

8. **Create tag**:
   ```bash
   git tag vX.Y.Z
   ```

9. **Push**:
   ```bash
   git push && git push --tags
   ```

10. **Report**:
    - `Version: X.Y.Z → A.B.C`
    - `Tagged: vA.B.C`
    - `Pushed`
