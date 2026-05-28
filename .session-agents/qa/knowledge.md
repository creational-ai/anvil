# QA — Knowledge

Durable per-project QA knowledge for anvil.

*See `~/.claude/skills/session-agents/references/knowledge.md` for what belongs here vs. doesn't.*

---

## Project type

Anvil is a **skills/commands/agents repository** (markdown + shell), not a service. Production "code" = `claude-code/dev/SKILL.md`, command files, agent files, references, templates, and the `deploy.sh` / `verify.sh` pair. There is no pytest/Jest unit suite — the "test framework" is `deploy.sh + verify.sh + structural greps`.

## Test layer mapping

- **L1 unit** — N/A. No code. Skill-modification tasks are exercised by structural greps against the post-deploy state.
- **L2 integration** — `claude-code/verify.sh` (75 structural checks as of 2026-05-27). Per-task ACs add anchored greps (e.g., `grep -E '^> \*\*Goal doc\*\*' template.md`) — anchored regexes catch structural drift that bare greps miss.
- **L3 live** — Operator-driven slash-command invocations in main conversation. Any command marked `disable-model-invocation: true` cannot be exercised by a spawned executor or QA agent; smoke is operator-only.
- **L4 real-substrate** — N/A. No external services or paid APIs.

## Authoritative refs (cross-layer constants)

Modules that own values spanning multiple surfaces — verify by import or grep against the source-of-truth, never by literal copy.

- **`verify.sh` `REQUIRED_COMMANDS` array** — pair-synced byte-identical with `verify-genesis.sh`. Check via `diff <(sed -n '/^REQUIRED_COMMANDS=(/,/^)/p' verify.sh) <(sed -n '/^REQUIRED_COMMANDS=(/,/^)/p' verify-genesis.sh)`. The plan-prescribed `grep -A N` form is leaky (matches consumer-loop site too); always use sed-range extraction. Pair-sync is array-content-level, not whole-file-equality (consumer-loop bodies legitimately differ: `COMMANDS_DIR` vs `r_file_exists`).
- **`deploy.sh` `SKILLS` / `OLD_SKILLS` / `OLD_AGENTS` / `OLD_COMMANDS` arrays** — same pair-sync rule. **OLD_COMMANDS is a deletion list** (runs `rm -f` on every entry); never add a still-live command to it. Auto-discovery via `cp -r commands/*.md` means new command files in source are deployed automatically — no deploy-script edit needed.
- **Goal-doc file path `docs/[milestone-slug]-[task-slug]-goal.md`** — no single SoT module; literal duplicated across SKILL.md (4 sites), CLAUDE.md (2 sites), 4 dev agents, `1-design.md` template, `dev-goal.md` command. Any future rename must propagate to all surfaces (WATCH item W4 in `docs/QA.md`).

## QA standing rules specific to anvil

- **Never declare a skill-modification task GO if source artifacts are untracked in git.** PROJECT_STATE.md saying "Complete" is necessary but not sufficient — `git ls-files` must show the new files. A fresh clone deploying must be able to reach 75/75. Filed as MED against core-goal-doc (2026-05-27).
- **Operator-only smoke for `disable-model-invocation: true` commands.** Stage 0 (`/dev-goal`) and any other operator-interactive command cannot be exercised by a spawned executor or QA. Document the smoke pattern in the per-task QA memo; let the operator run it. Don't try to fake it.
- **Anchored greps for placement assertions.** When verifying "the right string is in the right place," use regexes that anchor BOTH content AND structural context (e.g., `^> \*\*X\*\*` anchors the blockquote prefix + bold marker). Bare `grep "X"` is paper-test territory.
- **Conditional-emission templates need agent-side strip-on-absence instruction.** When a template carries an unconditional line that should only appear under a condition (e.g., the `> **Goal doc**:` citation), the consuming agent's body must explicitly instruct strip-on-absence. Without it, every task that doesn't meet the condition carries an orphan citation. Verify the agent paragraph exists with the exact "remove the line" instruction.

## Open WATCH list

See `docs/QA.md` § Open WATCH list for the live state. As of 2026-05-27: W1 (untracked source files), W2 (test-count delta), W3 (Step 8 operator gate), W4 (goal-doc path cross-layer duplication), W5 (`/dev-design --notes` dependency).

## Known-flaky / quarantined tests

*— none currently —*
