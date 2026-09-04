---
description: Commit all changes and push to remote
disable-model-invocation: false
---

# Commit and Push

**Scope:** commit and push what is already in the working tree. Do NOT test, lint, deploy, verify, review, spawn agents, or wait on anything. If the tree needs work before committing, that is a separate request.

## Instructions

1. `git status --short` — nothing to commit → ABORT "Nothing to commit."
2. Show what will be committed. List **untracked** paths separately — `git add -A` sweeps them in and `.gitignore` covers almost nothing; leave out scratch, logs, `*_to_delete*`, `.env`/keys unless plainly part of the change.
3. `git config --local user.email` — unset → ABORT. Identity is set per-repo here; committing without it silently falls back to whatever global identity exists and attributes the commit to the wrong account.
4. `git add -A` (or explicit paths if step 2 excluded any), then `git commit -m "<one line, imperative>"`. No signatures, no co-author lines.
5. `git push` — new branch: `git push -u origin <branch>`. Never switch or create branches. Never force-push.
6. Report: `<short-sha> <message>` · `<n> files` · `<branch> → <remote>`
