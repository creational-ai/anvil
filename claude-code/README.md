# Claude Code Skills

Stage-gated design and development skills for the Claude Code CLI. 4-stage no-code design, 3-stage spec-driven dev loop, market validation, and quality review.

* `/design-vision` → `/design-tasks` — 4-stage design pipeline (Vision → Architecture → Milestones → Tasks). Each stage produces a doc from a mandatory template and is gated by `/review-doc`.
* `/dev-usecases` (Stage 0, optional) → `/dev-design` → `/dev-execute-run` — Spec-driven dev loop. Per-step test enforcement; `/dev-ready` readiness gate (G1–G5) between stages; auto-finalize with timestamp, lessons, diagram, and health check.
* `/market-research` and `/naming-research` — Go/Pivot/Kill recommendation; scored name evaluation.
* `/review-doc-run` — Parallel scatter-gather review with optional `--auto` fix-apply.
* `/review-loop` — Single-session additive critic-sandwich (`E1 → R1 → E2`, default 2 rounds); the go-forward replacement for the `/review-doc-loop` ↔ `/exam-loop` tick-loops.
* `/review-triangulate` — Heavyweight multi-lane cross-validated deep review (critic sandwich + repo-grounding + path-correctness + optional empirical probes).
* `/spawn-*` — Background-agent variants for the dev, research, and review commands.
* `./deploy.sh` deploys to `~/.claude/`; `./deploy-genesis.sh` mirrors to a remote host (Raspberry Pi) via SSH.

## Table of Contents

- [Getting started](#getting-started)
- [Workflow](#workflow)
- [Most common workflow](#most-common-workflow)
- [design](#design)
- [dev](#dev)
- [research](#research)
- [review](#review)
- [Spawn commands](#spawn-commands)
- [Output files](#output-files)
- [Development](#development)
- [License](#license)

## Getting started

Requires the [Claude Code CLI](https://github.com/anthropics/claude-code).

```bash
cd claude-code
./deploy.sh
./verify.sh
```

Real output (tail):

```
--- Deploying review skill ---
Target: /Users/you/.claude/skills/review
  ✓ Copied SKILL.md
  ✓ Copied assets/templates/
  ✓ Copied references/
  ✓ Copied 12 commands
  ✓ Copied 4 agents
  ✓ Copied 1 workflow(s)
...
==============================================
Verification Summary
==============================================
  ✅ Passed: 79
  ❌ Failed: 0

🎉 All checks passed! Deployment is correct.
```

> Source of truth lives in this repo. Never edit `~/.claude/skills/` directly — those files are overwritten on every deploy. Edit here, then re-run `./deploy.sh`.

After deploy, slash commands are immediately available in any Claude Code session. Type `/design-vision`, `/dev-design`, etc.

## Workflow

```
DESIGN PHASE (design skill)
─────────────────────────
/design-vision              → Vision document
        ↓
/design-architecture        → Technical design
        ↓
/design-milestones          → Strategic milestones doc
        ↓
/design-tasks               → Atomic tasks per milestone with dependencies

DEVELOPMENT PHASE (dev skill)
─────────────────────────────
/dev-usecases               → (Stage 0, optional) Operator-facing usecases doc
        ↓
/dev-design                 → Analyze task (NO CODE)
        ↓
/dev-plan                   → Plan implementation steps
        ↓
/dev-execute                → Execute one step with tests
        ↓ (or)
/dev-execute-run            → Run all steps to completion (auto-finalize)
        ↓
/dev-finalize               → Wrap up (timestamp + lessons + diagram + health)
        ↓
Repeat for next task

/dev-ready                  → Readiness gate (G1–G5) at any stage break;
                              READY / NOT-READY decided from docs on disk
```

## Most common workflow

The typical dev task workflow with review loops:

```
1.  /dev-design <description>                Design analysis (no code)
2.  /review-doc-run <design doc> --auto      Review until solid (repeat as needed)
3.  /dev-plan <design doc>                   Create implementation steps
4.  /review-doc-run <plan doc> --auto        Review until solid (repeat as needed)
5.  /dev-execute-run                         Execute all steps + auto-finalize
6.  /dev-review-run <results doc>            Conceptual review of completed work
```

> Steps 2 and 4 are iterative — re-run reviews until all items are clean. The `--auto` flag auto-applies suggested fixes. Step 5 runs all plan steps sequentially then auto-finalizes. Step 6 catches intent drift, silent assumptions, and architectural issues across the completed implementation.
>
> Optionally begin with `/dev-usecases <milestone>-<task>: <notes>` (Stage 0) to capture operator-facing use cases before design. Run `/dev-ready <any task doc>` at any stage break for a bounded READY / NOT-READY readiness check (G1–G5) before advancing. For deeper scrutiny than `/review-doc-run`, use `/review-loop` (critic-sandwich) or `/review-triangulate` (multi-lane cross-validation).

## design

4-stage no-code design pipeline. Each stage produces a single doc from a mandatory template and is reviewed via `/review-doc` before moving forward.

| Command | Purpose |
|---------|---------|
| `/design-vision` | Vision document (Stage 1) |
| `/design-architecture` | Architecture document (Stage 2) |
| `/design-milestones` | Strategic milestone breakdown (Stage 3) |
| `/design-tasks` | Atomic tasks per milestone with dependencies and success criteria (Stage 4) |

> The design skill is **NO-CODE**. Pattern signatures and diagrams allowed; full implementations are not.

## dev

3-stage development loop per task, wrapped by an optional Stage 0 (usecases) and readiness gates between stages. Stage 1 is design-only; Stages 2-3 allow code. Each step writes its own tests and loops until tests pass.

| Command | Purpose |
|---------|---------|
| `/dev-usecases` | Create/update an operator-facing usecases doc (Stage 0, optional, NO CODE) — 3 modes: before-design notes walk, existing-doc update / legacy conversion, after-design distillation |
| `/dev-design` | Create design document (Stage 1, NO CODE) |
| `/dev-plan` | Plan implementation steps (Stage 2) |
| `/dev-execute` | Execute one step with tests (Stage 3) |
| `/dev-execute-run` | Run all remaining steps to completion (auto-finalize) |
| `/dev-ready` | Readiness gate (G1–G5) — emits a bounded READY / NOT-READY decision, computing which gate applies from the docs on disk |
| `/dev-review` | Review completed step against design |
| `/dev-review-run` | Review all completed steps in parallel |
| `/dev-diagram` | Generate ASCII summary diagram |
| `/dev-finalize` | Wrap up task (timestamp + lessons + diagram + health) |
| `/dev-milestone-summary` | Generate milestone summary document |
| `/dev-health` | Project health check |

> `/dev-execute-run --auto` adds parallel review + Mission Control sync after finalize. `/dev-ready` runs inline in the main conversation and never mutates the artifact — it proposes, you apply.

## research

| Command | Purpose |
|---------|---------|
| `/market-research` | Market validation with Go/Pivot/Kill recommendation |
| `/naming-research` | Name candidate evaluation with scoring matrix |

## review

| Command | Purpose |
|---------|---------|
| `/review-doc` | Sequential document review (supports `--auto`) |
| `/review-doc-run` | Parallel document review with background subagents (supports `--auto`) |
| `/exam` | Independent critical examination of a document — deeper than automated review (supports `--auto`) |
| `/review-loop` | Single-session additive critic-sandwich: N exams + N-1 reviews, ending on an exam (`E1 → R1 → E2`, default 2 rounds) |
| `/review-triangulate` | Multi-lane cross-validated deep review — critic sandwich + repo-grounding + path-correctness lanes (+ optional empirical probes), consolidated via a convergence map |
| `/review-doc-loop` | Tick-driven loop that pairs with `/exam-loop`; long-running, main conversation only |
| `/exam-loop` | Tick-driven loop that pairs with `/review-doc-loop`; long-running, main conversation only |
| `/monitor` | Periodic execution monitor with per-step analysis (read-only) |
| `/walkthrough` | Operator-facing pedagogical walkthrough of a doc |
| `/review-skill` | Audit a skill for structure, frontmatter, and consistency |

> `/review-loop` is the go-forward replacement for the `/review-doc-loop` ↔ `/exam-loop` tick-loop pair — it runs the same additive critic-sandwich (`E1 → R1 → E2`) in a single top-level session instead of coordinating two. `/review-triangulate` is its heavyweight variant, adding read-only repo-grounding and web-verified path-correctness lanes plus optional execute-but-don't-write probe lanes. Both require running in a top-level session (they spawn background subagents).

## Spawn commands

Background-agent variants. Each runs the corresponding command in a subagent so it doesn't consume the main conversation context.

| Command | Purpose |
|---------|---------|
| `/spawn-dev-designer` | Design agent for Stage 1 |
| `/spawn-dev-planner` | Plan agent for Stage 2 |
| `/spawn-dev-executor` | Execute agent for Stage 3 |
| `/spawn-dev-reviewer` | Review agent for conceptual review |
| `/spawn-dev-finalizer` | Finalize agent (timestamp + lessons + diagram + health) |
| `/spawn-dev-milestone-summarizer` | Milestone summary agent |
| `/spawn-market-researcher` | Market research agent |
| `/spawn-naming-researcher` | Naming research agent |
| `/spawn-doc-reviewer` | Document review agent (supports `--auto`) |
| `/spawn-skill-reviewer` | Skill review agent |

## Output files

**design skill creates:**
- `docs/[project-slug]-vision.md`
- `docs/[project-slug]-architecture.md`
- `docs/[project-slug]-milestones.md`
- `docs/[milestone-slug]-tasks.md`

**dev skill creates:**
- `PROJECT_STATE.md` (task + milestone tracking)
- `docs/[milestone-slug]-[task-slug]-usecases.md` (Stage 0, optional)
- `docs/[milestone-slug]-[task-slug]-design.md`
- `docs/[milestone-slug]-[task-slug]-plan.md`
- `docs/[milestone-slug]-[task-slug]-results.md`
- `docs/[milestone-slug]-milestone-summary.md`

**research skill creates:**
- `docs/[project-slug]-market-research.md`
- `docs/naming-research.md`

**review skill creates:**
- `docs/[slug]-review.md` (from `/review-doc`, `/review-doc-run`, `/exam`, `/review-loop`, `/review-triangulate`, and the loop pair)
- `docs/[slug]-monitor-issues.md` (lazy-created by `/monitor` on first verifiable issue)

## Development

### Making changes

Edit files in this folder, then redeploy:

```bash
./deploy.sh
./verify.sh
```

Never edit `~/.claude/skills/` directly — those files are overwritten on deploy.

### Sync from deployed

If you made changes directly in `~/.claude/`:

```bash
./sync-from-user.sh
```

### Deploy to genesis

`./deploy-genesis.sh` mirrors the same skills to a remote host (default: `genesis`, a Raspberry Pi accessed via SSH alias). Verify with `./verify-genesis.sh`. Run only when explicitly needed — it is not part of the local deploy.

| Script | Purpose |
|--------|---------|
| `deploy.sh` | Deploy to local `~/.claude/` |
| `verify.sh` | Verify local deployment (79 checks) |
| `sync-from-user.sh` | Pull changes from deployed `~/.claude/` back into the repo |
| `deploy-genesis.sh` | Deploy to `genesis:/home/pi/.claude/` via SSH |
| `verify-genesis.sh` | Verify remote deployment via SSH |

> Local and genesis script pairs (`deploy.sh` ↔ `deploy-genesis.sh`, `verify.sh` ↔ `verify-genesis.sh`) must stay mirrored. Their `OLD_COMMANDS`, `OLD_AGENTS`, `REQUIRED_COMMANDS`, and `REQUIRED_AGENTS` arrays must match.

## License

MIT — see root [LICENSE](../LICENSE).
