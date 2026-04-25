# Claude Code Skills

Stage-gated design and development skills for the Claude Code CLI. 4-stage no-code design, 3-stage spec-driven dev loop, market validation, and quality review.

* `/design-vision` → `/design-tasks` — 4-stage design pipeline (Vision → Architecture → Milestones → Tasks). Each stage produces a doc from a mandatory template and is gated by `/review-doc`.
* `/dev-design` → `/dev-execute-run` — Spec-driven dev loop. Per-step test enforcement; auto-finalize with timestamp, lessons, diagram, and health check.
* `/market-research` and `/naming-research` — Go/Pivot/Kill recommendation; scored name evaluation.
* `/review-doc-run` — Parallel scatter-gather review with optional `--auto` fix-apply.
* `/review-doc-loop` ↔ `/exam-loop` — Tick-driven critic-sandwich (`E1 → R1 → E2`) coordinated across two sessions via a shared review doc.
* `/spawn-*` — Background-agent variants for every command above.
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
  ✓ Copied 10 commands
  ✓ Copied 4 agents
...
==============================================
Verification Summary
==============================================
  ✅ Passed: 74
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

3-stage development loop per task. Stage 1 is design-only; Stages 2-3 allow code. Each step writes its own tests and loops until tests pass.

| Command | Purpose |
|---------|---------|
| `/dev-design` | Create design document (Stage 1, NO CODE) |
| `/dev-plan` | Plan implementation steps (Stage 2) |
| `/dev-execute` | Execute one step with tests (Stage 3) |
| `/dev-execute-run` | Run all remaining steps to completion (auto-finalize) |
| `/dev-review` | Review completed step against design |
| `/dev-review-run` | Review all completed steps in parallel |
| `/dev-diagram` | Generate ASCII summary diagram |
| `/dev-finalize` | Wrap up task (timestamp + lessons + diagram + health) |
| `/dev-milestone-summary` | Generate milestone summary document |
| `/dev-health` | Project health check |

> `/dev-execute-run --auto` adds parallel review + Mission Control sync after finalize.

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
| `/review-doc-loop` | Tick-driven loop that pairs with `/exam-loop`; long-running, main conversation only |
| `/exam-loop` | Tick-driven loop that pairs with `/review-doc-loop`; long-running, main conversation only |
| `/exam` | Independent critical examination of a document |
| `/monitor` | Periodic execution monitor with per-step analysis |
| `/walkthrough` | Operator-facing pedagogical walkthrough of a doc |
| `/review-skill` | Audit a skill for structure, frontmatter, and consistency |

> The loop pair runs an asymmetric critic-sandwich by default: `/exam-loop` leads (`N=2`) and `/review-doc-loop` follows (`N=1`), producing the sequence `E1 → R1 → E2`. Use paired flags (`--first` on one side AND `--follow` on the other) to invert.

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
- `docs/[milestone-slug]-[task-slug]-design.md`
- `docs/[milestone-slug]-[task-slug]-plan.md`
- `docs/[milestone-slug]-[task-slug]-results.md`
- `docs/[milestone-slug]-milestone-summary.md`

**research skill creates:**
- `docs/[project-slug]-market-research.md`
- `docs/naming-research.md`

**review skill creates:**
- `docs/[slug]-review.md` (from `/review-doc`, `/review-doc-run`, `/exam`, and the loop pair)
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
| `verify.sh` | Verify local deployment (74 checks) |
| `sync-from-user.sh` | Pull changes from deployed `~/.claude/` back into the repo |
| `deploy-genesis.sh` | Deploy to `genesis:/home/pi/.claude/` via SSH |
| `verify-genesis.sh` | Verify remote deployment via SSH |

> Local and genesis script pairs (`deploy.sh` ↔ `deploy-genesis.sh`, `verify.sh` ↔ `verify-genesis.sh`) must stay mirrored. Their `OLD_COMMANDS`, `OLD_AGENTS`, `REQUIRED_COMMANDS`, and `REQUIRED_AGENTS` arrays must match.

## License

MIT — see root [LICENSE](../LICENSE).
