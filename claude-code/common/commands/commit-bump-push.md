---
description: Commit all changes, bump version, tag, and push
argument-hint: [patch | minor | major | X.Y.Z]
disable-model-invocation: false
---

# Commit Bump Push

Commit all changes, bump version, create tag, and push everything.

**Scope:** commit, bump, tag, and push what is already in the working tree. Do NOT test, lint, deploy, verify, review, spawn agents, or wait on anything. If the tree needs work before committing, that is a separate request.

**This one pushes tags.** A tag is the hardest thing here to retract once it is on the remote, and this command makes two commits and mutates version files before it pushes. Re-read the version source you are about to edit; never force-push; never retag an existing version.

## Arguments (optional)

- `patch` - Bump patch version (0.1.0 → 0.1.1) **default**
- `minor` - Bump minor version (0.1.0 → 0.2.0)
- `major` - Bump major version (0.1.0 → 1.0.0)
- `X.Y.Z` - Set specific version

## Instructions

1. **Check for changes**:
   ```bash
   git status
   ```
   - If no changes: ABORT with "Nothing to commit"

2. **Show what will be committed** (for user awareness)

3. **Commit all changes**:
   - List **untracked** paths separately first — `git add -A` sweeps them in and `.gitignore` covers almost nothing; leave out scratch, logs, `*_to_delete*`, `.env`/keys unless plainly part of the change.
   - `git config --local user.email` — unset → ABORT. Identity is set per-repo here; committing without it silently falls back to whatever global identity exists and attributes the commit to the wrong account.
   ```bash
   git add -A
   git commit -m "[concise summary of changes]"
   ```

4. **Find current version** — check in priority order:
   - `pyproject.toml` → `version = "X.Y.Z"`
   - `VERSION` file → contains just `X.Y.Z`
   - If neither exists: create `VERSION` with `0.0.0` and use that

5. **Determine new version**:
   - If argument provided: use it
   - If no argument: patch bump (default)

6. **Update version** in whichever source was found in step 4:
   - `pyproject.toml` → update the `version = "..."` line
   - `VERSION` → overwrite file with new version string
   - Also update `__init__.py` with `__version__` (if exists)

7. **Commit version bump**:
   ```bash
   git add -A
   git commit -m "Bump to vX.Y.Z"
   ```

8. **Create tag**:
   ```bash
   git tag vX.Y.Z
   ```

9. **Push everything**:
   ```bash
   git push && git push --tags
   ```

10. **Report**:
    ```
    Committed: [summary]
    Version: X.Y.Z → A.B.C
    Tagged: vA.B.C
    Pushed
    ```
