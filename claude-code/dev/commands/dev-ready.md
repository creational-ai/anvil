---
description: Run a directed readiness check at a dev-stage break (G1–G5). Takes a doc path, resolves the furthest-along gate for that task from docs on disk, runs inline, emits a bounded READY / NOT-READY decision. Runs in main conversation.
argument-hint: <doc>
disable-model-invocation: false
---

# /dev-ready

Run a **directed readiness check** at the break between two dev stages and emit a **bounded decision** — READY / NOT-READY + the shortest in-scope action list, or "escalate: re-scope." Never a finding dump, never ranges beyond the one artifact, never mutates the artifact itself.

## What This Does

The dev ceremony (Usecases → Design → Plan → Execute) hands off **informally** between stages, so non-autonomous work (spikes, human-gates, operator-driven steps) leaks into plans and surfaces only at execution. `/dev-ready` sits at each break, resolves which gate applies from the docs on disk, binds that gate's profile, and runs **one shared inline flow** to decide whether the work is ready to advance.

Five gates, one flow:

```
/dev-usecases → [G1] → /dev-design → [G2] → /review-doc → [G3] → /dev-plan → [G4] → /review-doc → [G5] → /dev-execute-run
                ▲                    ▲                     ▲                   ▲                     ▲
                ready to design?     ready for review?     ready to plan?      ready for review?     ready to execute?
```

## Resources

**Read these for guidance**:
- `~/.claude/skills/dev/SKILL.md` - See the "Readiness Gates" section
- `~/.claude/skills/dev/references/ready-guide.md` - The base: the invariant 7-step flow, the five leashes, the profile schema, and the resolution rule
- `~/.claude/skills/dev/assets/ready/g1.md … g5.md` - The five concrete gate profiles (inputs / rubric / verdict semantics / remedy classes)

## Input

**Argument (required):** `<doc>` — a path to any artifact of the task being gated (its usecases, design, or plan doc, or a `-review.md` twin). The command derives the **task slug** from it and computes which gate applies from the docs on disk. **The gate is never passed by the operator** — resolving it is the command's job (see Resolution rule). Any artifact of the same task resolves to the same gate.

**Examples:**
```bash
# Gate the design-stage break (resolves G2 pre-review, or G3 once a design-review twin exists)
/dev-ready docs/core-foo-design.md

# Gate the plan-stage break (resolves G4 pre-review, or G5 once a plan-review twin exists)
/dev-ready docs/core-foo-plan.md

# Any artifact of the task works — the slug is what matters
/dev-ready docs/core-foo-usecases.md
```

## Resolution rule (furthest-along)

From the `<doc>` argument, derive the **task slug** and its **directory** — strip the stage suffix (`-usecases` / `-design` / `-plan`, and any `-review`) and the `.md` extension (e.g. `docs/core-foo-design.md` → slug `core-foo`, dir `docs/`). Then glob the doc's **sibling artifacts** in that same directory (`<dir>/<slug>-*.md` — normally `docs/`, but a fixture under `/tmp/` resolves against `/tmp/`), walk the artifact ladder, and bind the **last gate whose inputs are present**:

```
usecases → design → design-review → plan → plan-review
   G1         G2          G3          G4        G5
```

A legacy `-goal.md` argument is **rejected** (its suffix is not in the strip list — it would mis-derive the slug and match no siblings); convert it first via `/dev-usecases <goal-doc> update`, then gate the resulting `-usecases.md`.

- **G1 is the floor** — it fires when no `…-design.md` exists yet.
- Each **`-review.md` twin advances the cursor one gate**: a `…-design-review.md` advances G2 → G3; a `…-plan-review.md` advances G4 → G5. Detector = `-review.md` twin presence (the review skill persists a `-review.md` sidecar alongside each reviewed doc).
- The gate is **always computed**, never operator-supplied — the `<doc>` argument selects the *task*, the ladder selects the *gate*.

## Process

**Run in main conversation — inline. Do NOT spawn a subagent, fork, or fan out.** The gate is one agent, one context, a fixed rubric. There is no background-agent variant by design: heavy parallel analysis is the review layer's job (`/review-doc-run`), one step downstream of G2/G4 — the gate neither duplicates it nor depends on the Workflow primitive.

Follow `references/ready-guide.md` exactly. It carries the invariant 7-step flow; the command's job is the first two steps (resolve the break, bind the profile), then run the flow with that profile bound:

1. **Establish where we've been, are, and are going.** Derive the task slug from the `<doc>` argument, then read the artifact trail for that slug (which docs exist on disk) to fix the current break — this deterministically binds the gate and the next stage.
2. **Bind the gate's profile** — load `assets/ready/gN.md` for the resolved (or overridden) break: its inputs, rubric, verdict semantics, and remedy classes.
3. **Seed the givens preamble + scope fence** (leashes 1 and 2): harness primitives / mature toolkit / conventions are ambient and out of bounds to flag; the check ranges over the one bound artifact only.
4. **Run the gate's rubric — inline.** Walk the profile's fixed checklist in one context. No sub-agents, no fan-out.
5. **Verify survivors with a bias-to-READY materiality pass** (leash 4): nits and stylistic preferences drop out; default disposition is "nit — proceed."
6. **Synthesize** → READY / NOT-READY + the shortest in-scope action list (leash 5), or "escalate: re-scope" when the path to ready is a sprawl. Never a finding dump.
7. **PROPOSE to the operator** — present the decision + the minimal in-scope diff. The gate **never self-mutates**; the operator approves and applies.

## Output

A **bounded decision** surfaced inline in the conversation (no file written, no artifact mutated):

- **READY** + the verdict semantics for this gate (e.g., ready-for-`/review-doc`, ready-to-plan, ready-to-execute), or
- **NOT-READY** + the shortest in-scope action list (the minimal diff to reach ready), or
- **escalate: re-scope** when the path to ready is a sprawl rather than a short diff.

The operator applies any proposed diff and proceeds to the next dev stage the resolution named.
