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
- **Command frontmatter house style**: `description`, `argument-hint`, and `disable-model-invocation: true` on operator-driven / long-running commands (30 of 32). All 32 commands carry frontmatter. **Four deliberate `false` exceptions** — `review-skill.md`, the two commit commands, and `review-loop.md` (all explicit `false`; see the rationale anchors below before touching any).
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

- **The two commit commands are DELIBERATELY model-invocable — do not "fix" this.** `common/commands/commit-and-push.md` and `commit-bump-push.md` carry an explicit `disable-model-invocation: false`, against the house convention (30 of 32 commands set it `true`). **This is a decision, not the oversight it looks like.** The operator's workflow: other agents `comms` the **git pane** in plain English ("commit the taskcreate work"), and the git pane then decides to invoke `/commit-and-push` itself — which requires model-invocability. Set to `false` explicitly rather than omitted precisely so it reads as intentional.
  - I originally argued the opposite (2026-08-20) from strong-looking evidence: 30/32 convention, `review-skill.md` being the only *documented* exception, and `bump-version.md` in the same folder carrying `true` while being strictly less dangerous. The evidence was real; the conclusion was wrong, because **convention-fit cannot see a workflow that lives outside the file**. Before ruling "oversight" on a frontmatter deviation, ask who or what invokes the component in practice — not just how its siblings are configured.
  - Consequence worth remembering: because an invoking agent is no longer gated by a human typing the command, the **scope fence in those two commands is load-bearing**, not cosmetic. It is the only thing standing between "commit this" and a pane re-running a test suite, deploy-parity checks, and three review subagents. Treat any request to soften it as a safety change.

- **A command and its agent are TWO callers — a method placed in only one leaves the other blind.** Named invariant (2026-08-27), found the hard way. `/dev-usecases` is agent-invocable and its Process says *"Follow `0-usecases-guide.md` exactly"* — so the **command path reads the guide, the agent path reads the agent file**. A method written only into `dev-usecase-author.md` therefore never runs for `/dev-usecases`, and vice versa. This is why the thin-agent invariant (method in the guide, agent is a pointer) is load-bearing rather than stylistic: **the guide is the only home both callers read.**
  - I nearly shipped the bug: proposed a self-contradiction check as "one clause, agent-only, no new pass" to avoid over-engineering. That would have fired for the agent and silently never fired for the command — worse than missing, because the completion template has a report slot for it, so "never ran" would have rendered as "ran, found nothing". The architect's guide+checklist placement fixed both paths at once.
  - Generalize: **before placing any method, enumerate the callers.** For dev stages that is always at least two (command + agent). Ask "which file does each caller actually read?" — not "where does this feel like it belongs".

- **Do not assert a cause from a number that merely matches.** Twice this stream I ran a check, got a figure that fit a tidy story, and reported the story as fact: (a) `--diff-filter=A` returning empty → "the path never existed" (it cannot see untracked paths at all); (b) architect's run-count `41` equalling my file count `41` → "they reported files, not runs" (coincidence — 41 was a real run count at a narrower scope; verified: narrow scope = 41 runs, full 47-file tree = 76). Both were confidently wrong corrections aimed at future readers. **Before correcting someone's number, reproduce it at their scope and filter** — a matching integer is not a shared definition.

- **`git log --diff-filter=A` cannot detect untracked paths.** An untracked file/dir never enters history, so the probe returns empty whether or not the path ever existed — it cannot distinguish "never existed" from "existed but was never committed". `docs/_to_delete/` really did exist as `??` during the 2026-08-20 session; my history check "confirming" it never existed proved nothing. To reason about untracked paths use `git status --short | grep '^??'` (present tense only) or accept that the past is unknowable, and argue from `.gitignore` coverage instead.

- **Optional-stage integration scope**: a new optional dev-workflow stage gets soft-reference integration in the 4 main pipeline stages only; utility commands stay untouched. (Established for Stage 0 / `/dev-usecases`.)

---

## Anti-patterns to flag

- **SKILL.md with no YAML frontmatter** — *all 4 skills are currently in this state* (verified 2026-08-17). Canon (`docs/claude-code/skills.md:49`) requires `---`-delimited frontmatter with `description`; without it CC falls back to the folder name, so the skill listing reads `design: design` and the skill can never model-trigger on user phrasing. Highest-value open defect in the repo.
- **Deprecated-in-README-only components.** `/exam-loop` and `/review-doc-loop` are declared superseded in `claude-code/README.md` but carry no deprecation notice in their own frontmatter/body and are still fully deployed. Supersession must be visible at the component, not just the index.
- **Stale `loop-commands.md`.** Its header still says "Six commands. Three variants." and it predates `/review-loop` and `/review-triangulate` (last updated 2026-04-24). Any loop-command add/remove must update this index in the same change.
- **Local/genesis script drift.** Editing one of `deploy.sh`↔`deploy-genesis.sh` or `verify.sh`↔`verify-genesis.sh` without its pair leaves genesis stale or skipping cleanup.
- **Pruning by deletion alone.** Removing a command/agent/skill without adding it to the `OLD_COMMANDS`/`OLD_AGENTS`/`OLD_SKILLS` arrays leaves a stale copy live in `~/.claude/` forever.

## Verification blind spots (2026-08-27, concept-surface episode)

- **String sweeps are blind to semantic re-encoding.** A rule can be re-expressed as a procedure step or a report field with none of its original vocabulary surviving. Grepping the old wording finds instances 1..N-1 and misses the ones that matter. On any deprecation, rename, or default-inversion, sweep for the *concept*: intersect the topic terms with the coupling terms and read every hit for meaning. Found 3 stale ceiling instances this way after two clean string sweeps.
- **You cannot verify an automated check by performing it manually.** Performing it is the one action that makes its absence invisible — the check succeeds either way, so success carries no information about whether the *system* performs it. The `Illustrates` staleness tripwire had no consumer anywhere; its author had verified it by hand every time. To test a claimed automatic check, grep for its *consumer*, never run the check.
- **Agent-bloat diagnostic: "restates a value the guide can change," not rule count.** `dev-usecase-author` and `dev-concept-author` both carry 9 Critical Rules; only the latter was defective. The former's rules are behavioral contract and literal output tokens (`[extensions TBD — walk with operator]`) — nothing that churns. The latter restated a number plus its rationale, so one ceiling change had to land in 8 sites across 4 files. Count is a proxy and a bad one; thinning by count would strip correctly-specified agents and miss churning ones.
- **Do not generalize from a two-sample comparison.** Claimed "heaviest restatement in the dev skill" after checking 2 of 7 siblings; it was tied, not heaviest. Same error class as asserting a cause from a matching number — check the full set before ranking.

## Comms write hazards (2026-08-27)

- **Never blind-truncate my own inbox.** My clear was `text.split('## Open')[0] + '## Open\n\n_(empty)_\n'` — a read-modify-write that discards anything a peer wrote between my read and my write. It cannot distinguish "nothing new" from "a message arrived while I worked." **Delete only the specific entries I actually processed, by matching their headers**; leave everything else standing. Silently destroying a peer's message is worse than dropping my own, because neither side sees it happen.
- **File-then-ping must be `&&`, not two statements.** Architect's write failed (stale cwd from a persisted `cd`) while the doorbell fired anyway, so the wire promised "see comms" against an entry that was never on disk. The protocol says file before firing; nothing enforces that the file write *succeeded*. Chain them so a failed write cannot emit a wire. Same class as the F3 tripwire: a promised step that nothing verifies.
- **A persisted `cd` is the mechanism.** The shell working directory survives across Bash calls, so a `cd` in an earlier command silently relocates later ones. Global CLAUDE.md already says not to `cd` into the working directory; the cost of ignoring it is writes landing somewhere unintended. Use absolute paths in file writes rather than relying on cwd.
