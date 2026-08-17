# Skillwright — Knowledge

Durable per-project knowledge for the skillwright role. Re-read on every activation.

*See `~/.claude/skills/session-agents/references/knowledge.md` for what belongs here vs. doesn't.*

**Inventory last verified:** 2026-08-17

---

## Authoritative refs (re-read on activation)

- Main-docs CC guides: `~/Development/docs/claude-code/{skills,slash-commands,subagents,skill-naming-conventions,hooks}.md`
- `~/Development/docs/claude-code/long-running-loops.md` — the loop-variant taxonomy (A tick-driven / B notification-driven / C sequential orchestrator) this repo's loop commands are classified against
- `skill-creator:skill-creator`, `plugin-dev:skill-development` (+ companion `plugin-dev:*` skills — the bare handles are not the registered names)
- Project-local: `claude-code/loop-commands.md` — the loop-command index (see staleness note under Anti-patterns)

---

## Component inventory

Source of truth is `claude-code/`. **Never edit `~/.claude/skills|commands|agents|workflows/` directly** — deploy overwrites.

| Kind | Count | Location |
|---|---|---|
| Skills | 4 — `design`, `dev`, `research`, `review` | `claude-code/<skill>/SKILL.md` |
| Commands | 32 | `claude-code/<skill>/commands/*.md` + `claude-code/common/commands/*.md` |
| Subagents | 13 | `claude-code/<skill>/agents/*.md` (dev 7, research 2, review 4) |
| Workflows | 1 (`review-loop.js` + `review-loop-guard.sh`) | `claude-code/review/workflows/` |
| Hooks | 0 | — |

**`common/` is a fourth command source with no owning skill** — `bump-version`, `commit-and-push`, `commit-bump-push`. `deploy.sh` handles it via a separate `if [ -d "$SCRIPT_DIR/common/commands" ]` block (~line 210), not via the `SKILLS` array. CLAUDE.md's repo-structure tree does not mention it.

### Deploy / verify

- `deploy.sh` → `~/.claude/{skills,commands,agents,workflows}/`. Config arrays at the top: `SKILLS`, `OLD_SKILLS`, `OLD_AGENTS`, `OLD_COMMANDS` (the `OLD_*` arrays are *cleanup* lists for retired components — pruning a component means adding it there, not just deleting the source).
- `verify.sh` → asserts `OLD_*` are gone, `REQUIRED_COMMANDS` / `REQUIRED_AGENTS` exist, and each deployed workflow `.js` is byte-identical to source. `*-guard.sh` stays in source and is run by `verify.sh`.
- `deploy-genesis.sh` / `verify-genesis.sh` mirror the pair over SSH. **Config arrays verified in sync as of 2026-08-17** — re-diff after any array edit:
  ```bash
  X='/^(SKILLS|OLD_SKILLS|OLD_AGENTS|OLD_COMMANDS|REQUIRED_COMMANDS|REQUIRED_AGENTS)=\(/,/^\)/'
  diff <(awk "$X" deploy.sh) <(awk "$X" deploy-genesis.sh)
  diff <(awk "$X" verify.sh) <(awk "$X" verify-genesis.sh)
  ```
- `deploy-genesis.sh` is a **separate manual action** — never part of a routine "deploy and verify".

---

## Project authoring conventions

- **Command naming**: `<skill>-<verb>` (`dev-plan`, `review-doc`, `design-vision`). Skill-less utilities in `common/` carry no prefix. **There is no `spawn-*` command class** — retired 2026-08-17 (see rationale below); background execution = spawn the agent by `subagent_type`.
- **Command frontmatter house style**: `description`, `argument-hint`, and `disable-model-invocation: true` on operator-driven / long-running commands. All 42 commands carry frontmatter (verified 2026-08-17).
- **Subagent `tools` field**: agents needing MCP (e.g. `dev-executor`) must **omit** `tools` entirely — specifying it creates an allowlist that excludes all MCP tools.
- **Severity labels**: `HIGH / MED / LOW`, uppercase, always.
- **Doc naming**: scope prefix (`[project-slug]-` project-level, `[milestone-slug]-` milestone-level); singular noun for aggregate-of-one, plural for enumerations.
- **Adding a component means updating wiring in the same change**: source file → `deploy.sh`/`deploy-genesis.sh` arrays if applicable → `verify.sh` REQUIRED lists → `CLAUDE.md` command list → `claude-code/README.md`. A command the deploy script doesn't copy is a silent no-ship.

---

## Primitive-choice rationale anchors

- **Loop mechanics live in one reference, not per-command.** `review/references/review-loop-guide.md` is the single source of truth for `/review-doc-loop` and `/exam-loop`; the commands are thin entry points. Progressive disclosure applied at the *guide* layer, not just SKILL.md.
- **`/review-loop` chose a single-session sequencer over the two-session tick-loop pair.** It replaces the `/review-doc-loop` ↔ `/exam-loop` coordination (two panes syncing through a shared review doc) with one session running `E1 → R1 → E2`. Rationale recorded in `claude-code/README.md` §  loop note. `/review-triangulate` is its heavyweight variant (adds repo-grounding + path-correctness + optional probe lanes) and is the explicit opt-in point for the Workflow tool.
- **`spawn-*` wrapper commands retired (2026-08-17) — the agent IS the primitive.** All 10 were thin `context: fork` + `agent: <name>` shims whose bodies restated the agent's own description; the two that carried extra logic (`spawn-dev-finalizer`'s "ALL 4 STEPS", `spawn-skill-reviewer`'s arg parsing) duplicated text already in `dev-finalizer.md:33` and `skill-reviewer.md:26-29`. No orchestrator depended on them — `/dev-execute-run`, `/dev-review-run`, `/review-doc-run`, `review-loop.js` all launch by `subagent_type`. **Rule going forward: a command that only forks to an agent is not a primitive worth shipping** — it doubles the maintenance surface and drifts from the agent it wraps. `skill-review-guide.md` Check 2 now flags this shape.

- **Every dev stage ships as command + agent (2026-08-17).** The invariant: a stage is a `/dev-<verb>` command running in the main conversation *plus* a `dev-<role>` agent for background execution. Stage 0 was the lone exception; `dev-usecase-author` closed it, and `dev-usecases.md`'s "there is no background-agent variant by design" line was retired. **`/dev-ready` is a deliberate exception that stays** — the gate is one agent, one context, a fixed rubric, and heavy parallel analysis is the review layer's job. When adding a dev stage, ship both halves.
  - **Agent naming**: `dev-<role>`, role derived from the command verb (`design`→`designer`). When the command is a noun with no verb form (`/dev-usecases`), use a compound role noun — `dev-usecase-author`, precedent `dev-milestone-summarizer`. Never coin a non-word (`dev-usecaser`).
  - **Interactive stages: the agent drafts, never confirms.** Stage 0's operator confirmation is mandatory for all three flows and can only happen in the main conversation. `dev-usecase-author` marks unwalked scenarios `[extensions TBD — walk with operator]` and reports `AWAITING OPERATOR CONFIRMATION`. Apply this shape to any future stage whose value comes from an operator conversation — the agent handles the mechanical draft, the conversation stays upstream.

- **Optional-stage integration scope**: a new optional dev-workflow stage gets soft-reference integration in the 4 main pipeline stages only; utility commands stay untouched. (Established for Stage 0 / `/dev-usecases`.)

---

## Anti-patterns to flag

- **SKILL.md with no YAML frontmatter** — *all 4 skills are currently in this state* (verified 2026-08-17). Canon (`docs/claude-code/skills.md:49`) requires `---`-delimited frontmatter with `description`; without it CC falls back to the folder name, so the skill listing reads `design: design` and the skill can never model-trigger on user phrasing. Highest-value open defect in the repo.
- **Deprecated-in-README-only components.** `/exam-loop` and `/review-doc-loop` are declared superseded in `claude-code/README.md` but carry no deprecation notice in their own frontmatter/body and are still fully deployed. Supersession must be visible at the component, not just the index.
- **Stale `loop-commands.md`.** Its header still says "Six commands. Three variants." and it predates `/review-loop` and `/review-triangulate` (last updated 2026-04-24). Any loop-command add/remove must update this index in the same change.
- **Local/genesis script drift.** Editing one of `deploy.sh`↔`deploy-genesis.sh` or `verify.sh`↔`verify-genesis.sh` without its pair leaves genesis stale or skipping cleanup.
- **Pruning by deletion alone.** Removing a command/agent/skill without adding it to the `OLD_COMMANDS`/`OLD_AGENTS`/`OLD_SKILLS` arrays leaves a stale copy live in `~/.claude/` forever.
