# A N V I L  -  🔥 Forges raw ideas into polished products. 🔥

A product engineering toolkit for Claude Code and Claude Desktop — built by a developer, for developers. Anvil applies software engineering discipline to AI-assisted development: mandatory templates prevent structural drift, stage gates enforce design-before-code, spec-driven plans eliminate hallucinated implementations, test loops catch failures on every step, and a 5-check conceptual review targets the failure modes unique to AI — silent assumptions, unsurfaced trade-offs, and architectural drift. The result is production-grade code, not demo code.

## Design Workflow

5 stages from raw idea to executable task plan. **Strictly no-code** — forces
architectural thinking before any implementation.

```
         ┌──────────────────────┐
         │      Raw Idea         │
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │  1. Vision            │  Problem, solution, feasibility
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │  2. Architecture      │  Tech stack, data flows, integrations
         └──────────┬───────────┘
                    │
              ┌─────┴──────┐
              │  Market     │
              │  Research   │  Go / Pivot / Kill?
              └─────┬──────┘
                    │ GO
                    ▼
         ┌──────────────────────┐
         │  3. Roadmap           │  Strategic milestone breakdown
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │  4. Milestone Spec    │  Detailed per-milestone design
         └──────────┬───────────┘
                    │
                    ▼
         ┌──────────────────────┐
         │  5. PoC Spec          │  Atomic tasks + success criteria
         └──────────┬───────────┘
                    │
                    ▼
              Hand off tasks
```

Each stage produces a document from a **mandatory template** — no freeform output.
User runs `/verify-doc` between stages to catch gaps before moving forward.

## Development Workflow

3-stage loop per task. Spec-driven plans mean the AI implements from
specifications, not from pre-written code it might hallucinate.

```
         ┌──────────────────────┐
    ┌───▶│  Pick task from plan  │
    │    └──────────┬───────────┘
    │               │
    │               ▼
    │    ┌──────────────────────┐
    │    │  1. Design (no code)  │  Analyze, risk profile, constraints
    │    │     /verify-doc ✓     │  Approach per item, sequence
    │    └──────────┬───────────┘
    │               │
    │               ▼
    │    ┌──────────────────────┐
    │    │  2. Plan              │  Spec-driven steps (no code blocks)
    │    │     /verify-doc ✓     │  Acceptance criteria per step
    │    └──────────┬───────────┘
    │               │
    │               ▼
    │    ┌──────────────────────────────┐
    │    │  3. Execute + Finalize       │
    │    │                              │
    │    │    Implement ──▶ Test ──┐    │
    │    │        ▲          FAIL  │    │
    │    │        └────────────────┘    │
    │    │                   PASS       │
    │    │                    ▼         │
    │    │             Document + STOP  │
    │    │            ▼ next step       │
    │    │    ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄    │
    │    │    all steps done:           │
    │    │    Timestamp, lessons,       │
    │    │    diagram, health check     │
    │    └──────────────┬───────────────┘
    │                   │
    │                   ▼
    │    ┌──────────────────────┐
    │    │  Review (opt-in)      │  5 checks: intent, assumptions,
    │    │                       │  trade-offs, complexity, drift
    │    └──────────┬───────────┘
    │               │
    └───────────────┘
          next task
```

The test loop enforces **implement → test → fix → retest** on every single step.
The 5-check review catches AI-specific failures: silent assumptions, unsurfaced
trade-offs, and architectural drift from the design.

## Quick Start

### Claude Desktop

1. Download `.skill` files from [`claude-desktop/releases/`](claude-desktop/releases/)
2. In Claude Desktop: **Settings > Skills > Import Skill**

See [`claude-desktop/README.md`](claude-desktop/README.md) for details.

### Claude Code

```bash
cd claude-code
./deploy.sh
./verify.sh
```

See [`claude-code/README.md`](claude-code/README.md) for details.

## Workflow

### Full Workflow (Both Environments)

```
CLAUDE DESKTOP
──────────────
1. design Stages 1-2
   → Vision artifact
   → Architecture artifact

2. Market Research Checkpoint
   → "Do market research for [project]"
   → Go / Pivot / Kill?

3. design Stages 3-5 (if GO)
   → Roadmap artifact
   → Milestone Spec artifact
   → PoC Spec artifact

CLAUDE CODE
───────────
4. Import design docs to project

5. dev loop (per task)
   → /dev-design
   → /dev-plan
   → /dev-execute-run (all steps + auto-finalize)
   → /dev-review-run (parallel reviews, opt-in)
   → Repeat
```

### Claude Code Only Workflow

```
1. /design-vision → Vision document
2. /design-architecture → Technical design
3. /design-roadmap → Strategic milestone roadmap
4. /design-milestone-spec → Detailed milestone design
5. /design-poc-spec → Atomic proof-of-concepts

6. /dev-design → Analyze first task
7. /dev-plan → Plan implementation
8. /dev-execute-run → Execute all steps + finalize
9. /dev-review-run → Review all steps (opt-in)
10. Repeat 6-9 for each task
```

## Skills

### Claude Code

| Skill | Purpose |
|-------|---------|
| **design** | 5-stage design workflow: Vision, Architecture, Roadmap, Milestone Spec, PoC Spec |
| **dev** | Development loop: design analysis, planning, step-by-step execution with tests, review, finalization |
| **market-research** | Market validation with Go/Pivot/Kill recommendation |
| **skill-reviewer** | Audit skills for structure, frontmatter, cross-references, and consistency |

### Claude Desktop

| Skill | Purpose |
|-------|---------|
| **design** (v2.0.0) | Same 5-stage design workflow (outputs as artifacts) |
| **market-research** (v1.1.0) | Market validation with Go/Pivot/Kill recommendation |
| **business-validation** (v1.1.0) | Business validation roadmaps with PoC-based experiments |
| **framework-alignment** (v1.0.0) | Strategic framework analysis (Four Loops, Flywheel, Dangerous Intelligence) |

## Key Principles

- **design skill is NO-CODE** — Pure design and planning
- **dev skill allows code** — Stage 1 is design-only, Stages 2-3 allow code
- **One task at a time** — Plan and execute incrementally
- **Production-grade quality** — OOP, validated data models, type hints, tests required
- **200-users-first** — Right-sized for early users, scale comes later
- **Validate early** — Market research before heavy investment

## Repository Structure

```
anvil/
├── README.md
├── CLAUDE.md
├── LICENSE
│
├── claude-code/                # Claude Code skills
│   ├── README.md
│   ├── deploy.sh              # Deploy skills and commands (local)
│   ├── deploy-genesis.sh      # Deploy skills to genesis (Raspberry Pi)
│   ├── verify.sh              # Verify deployment
│   ├── sync-from-user.sh      # Sync from deployed skills
│   ├── design/                # 5-stage design workflow
│   ├── dev/                   # Development loop
│   ├── market-research/       # Market validation
│   └── skill-reviewer/        # Skill auditing
│
└── claude-desktop/             # Claude Desktop skills
    ├── README.md
    ├── package.sh             # Build .skill files
    ├── unpackage.sh           # Extract .skill files
    ├── design/                # Design skill (v2.0.0)
    ├── market-research/       # Market validation (v1.1.0)
    ├── business-validation/   # Business validation (v1.1.0)
    ├── framework-alignment/   # Framework analysis (v1.0.0)
    └── releases/              # Packaged .skill files
```

## License

MIT License - see [LICENSE](LICENSE) for details.

```
                               ┌────────────────────────────┐
         ╭─────────────────────┤                            │
          ╰──╮                 │      🔨 A N V I L 🔨        │
             ╰──╮              └───┐                  ┌─────┘
                ╰──────────────────┤                  │
                                   └────┐        ┌────┘
                                        │        │
                                   ┌────┘        └────┐
                                   │                  │
                                   └──────────────────┘
```
