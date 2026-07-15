---
description: Create or update a usecases doc (Stage 0, optional). Value-first, use-case-structured operator-facing doc. Runs in main conversation.
argument-hint: [notes-or-slug-or-doc-path] [update]
disable-model-invocation: true
---

# /dev-usecases

Create or update a usecases doc for a task (Stage 0 of dev workflow — optional).

## What This Does

Stage 0 of dev: Capture the **operator-facing target** for a task as a value-first, use-case-structured doc. It subsumes the Stage-0 goal layer — goals, quantified pain, and the real-artifact anchor live inside it — and describes externally observable behavior as **main success scenarios plus extensions** (UP/RUP / Cockburn use cases). Two audiences, both load-bearing:

- **The operator**, who confirms direction before the team commits.
- **Downstream agents** (design → review → plan → review → execute → monitor), who use it as a fixed alignment anchor across the pipeline.

A usecases doc is NOT a design doc — it carries no schemas, no signatures, no risks list, no decisions log. Those live in `docs/[milestone-slug]-[task-slug]-design.md`, which stays the single normative source. The usecases doc is **descriptive**; on disagreement, design wins and the usecases doc gets fixed in the same change set.

## Resources

**Read these for guidance** (the method lives in the guide — this command is thin):
- `~/.claude/skills/dev/SKILL.md` - See "Stage 0: Usecases (Optional)" section
- `~/.claude/skills/dev/references/0-usecases-guide.md` - Full method: goal levels, the three drafting flows, parity sweep, cohesion pass, evergreen rule
- `~/.claude/skills/dev/assets/templates/0-usecases.md` - Five-section shape (goals-at-a-glance / artifact / Use Case N / one-sentence contract); single-use-case degenerate form noted inline

## Input modes

Stage 0 supports three input modes. **In Mode 1, notes MUST begin with `<milestone-slug>-<task-slug>:`** so the output path `docs/[milestone-slug]-[task-slug]-usecases.md` is unambiguous. If the prefix is missing, the command prompts the operator for the slug rather than guessing.

**Mode 1 — Notes only (before-design alignment artifact):**
- Argument: free-form notes describing the goals/behavior, must begin with `<milestone-slug>-<task-slug>:`.
- Example: `/dev-usecases "core-placements: declare ad-slot placements per app as config-as-code with audit trail"`
- Runs the guide's **Flow A** (before-design scenario walk): works the behavior through with the operator one scenario at a time, clusters by actor goal, drafts the goals table + artifact section before the use cases. QA passes are deferred (no normative vocabulary yet).

**Mode 2 — Existing doc + `update` (reformat OR legacy conversion):**
- Argument: a path to an existing doc, followed by `update`.
- A `-usecases.md` path → **reformat**: read the current template + guide, restructure the existing doc to the latest five-section shape, preserve semantic content. Re-confirm with the operator before writing (per the guide's Closing step).
- A legacy `-goal.md` path → **legacy conversion** (guide's **Flow C**): map the legacy fields into the usecases shape, seed each use case as a skeleton with `[extensions TBD]` markers (conversion is seeding, not completion), write to `-usecases.md`, leave the original in place, and walk the missing scenarios with the operator before treating it as real. Mandatory operator re-confirmation.
- Examples: `/dev-usecases docs/core-placements-usecases.md update` · `/dev-usecases docs/core-placements-goal.md update`

**Mode 3 — Task slug with existing design (after-design distillation):**
- Argument: `<milestone-slug>-<task-slug>` where `docs/[milestone-slug]-[task-slug]-design.md` already exists (and optionally a plan).
- Example: `/dev-usecases core-placements`
- Globs `docs/<m>-<t>-{design,plan}.md`, reads all hits, runs the guide's **Flow B** (distillation): compresses the value + behavior layer using the design's literal outcome vocabulary, then runs the **vocabulary parity sweep** + **cohesion pass**. Invocable at ANY break — the shape never changes; only the inputs and runnable QA passes scale with what's on disk.

**User notes (optional, when invoked with `--notes`):**
```
{{notes}}
```

## Process

**Run in main conversation. Do NOT spawn a subagent or fork — Stage 0's operator-interactive confirmation loop requires the main conversation; no `/spawn-dev-usecases` variant exists by design.** Follow `0-usecases-guide.md` exactly. The guide branches on what exists on disk; all flows close with operator confirmation.

The command will:
1. Read the guide and template.
2. Determine which input mode applies (notes-prefixed-with-slug / doc-path + `update` / task-slug-with-existing-design).
3. Execute the matching flow from `0-usecases-guide.md` (Flow A before-design walk / Flow B after-design distillation / Flow C legacy conversion or reformat).
4. Draft the usecases doc using the template's five-section shape, with real portfolio data for the artifact section (degenerate single-use-case form if N=1).
5. **Present the draft to the operator and obtain confirmation.** Until the operator confirms, downstream agents have no stable anchor. If the operator pushes back, revise and re-confirm.
6. Write to `docs/[milestone-slug]-[task-slug]-usecases.md`.

## Output

Create one document:
- `docs/[milestone-slug]-[task-slug]-usecases.md`

**Examples**: `docs/core-placements-usecases.md`, `docs/cloud-auth-fix-usecases.md`, `docs/integrations-slack-usecases.md`

## After Completion

User will proceed to Stage 1 (Design) with the confirmed usecases doc as the alignment anchor.

Optionally run `/dev-ready docs/[milestone-slug]-[task-slug]-usecases.md` at this break for a bounded readiness check — it resolves the **G1** gate (a light de-risking judgment: are the high-risk issues that would shape the design de-risked enough to proceed, or is a spike warranted first?). Later breaks compute their own gate. See `references/ready-guide.md`.
