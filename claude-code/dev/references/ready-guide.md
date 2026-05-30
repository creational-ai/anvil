# Readiness Gate Guide (`/dev-ready`)

## Purpose

The dev ceremony (Goal → Design → Plan → Execute) hands off **informally** between stages, so non-autonomous work (spikes, human-gates, operator-driven steps) leaks into plans and surfaces only at execution. `/dev-ready` sits at each break, runs a **directed** readiness check on the one artifact for that break, and emits a **bounded decision** — READY / NOT-READY + the shortest in-scope action list, or "escalate: re-scope." It never dumps findings, never ranges beyond the artifact, and never mutates the artifact itself.

**Thesis: direction, not power.** This guide is the *base* — the invariant 7-step flow, the five leashes, and the profile schema that every gate fills. Each gate (G1–G5) is a small concrete profile under `assets/ready/gN.md` that fills the schema; the `/dev-ready` command is the dispatcher that resolves the break, binds the profile, and runs this flow with it bound. Adding or retuning a gate is **editing one profile file** — the base flow never changes.

## Code Allowed

NO — this guide runs an inline check and PROPOSES edits; the operator applies them.

---

## The five gates (the breaks)

```
/dev-goal → [G1] → /dev-design → [G2] → /review-doc → [G3] → /dev-plan → [G4] → /review-doc → [G5] → /dev-execute-run
            ▲                    ▲                     ▲                   ▲                     ▲
            ready to design?     ready for review?     ready to plan?      ready for review?     ready to execute?
```

Each gate is one profile (`assets/ready/g1.md … g5.md`) filling this guide's schema. The shared flow below runs identically for all five; only the bound profile (step 2) differs.

---

## The shared flow (7 steps — invariant)

Steps **1, 3, 4, 5, 6, 7 are invariant** — the leashes live in them and step 4 always runs **inline** (one agent, one context, no sub-agents, no fan-out). **Only step 2 is parameterized** — it binds the gate's rubric / inputs / verdict from the profile.

1. **Establish where we've been, where we are, and where we're going.** Derive the task slug from the `<doc>` argument, then read that slug's artifact trail (which docs exist on disk) to fix the current break — this *deterministically* binds the gate and the next stage. Always the first act, before any check runs. (See the Resolution rule below.)
2. **Bind the gate's profile.** Load `assets/ready/gN.md` for the resolved break: its inputs, rubric, verdict semantics, and remedy classes. *This is the only parameterized step.*
3. **Seed the givens preamble + scope fence** (constant across gates — leashes 1 and 2). Establish up front: harness primitives / mature toolkit / conventions are ambient and out of bounds to flag; the check ranges over the one bound artifact only.
4. **Run the gate's rubric — inline.** Walk the profile's fixed checklist in one context. No sub-agents, no fan-out, no workflow script. (Heavy parallel analysis is the review layer's job — `/review-doc-run`, one step downstream of G2/G4 — the gate does not duplicate it.)
5. **Verify survivors with a bias-to-READY materiality pass** (leash 4). For each candidate finding, ask "is this a genuine autonomy/correctness break, or a nit?" Nits and stylistic preferences drop out; the default disposition is "nit — proceed."
6. **Synthesize** → READY / NOT-READY + the **shortest in-scope action list** (leash 5, minimal-diff output), or **"escalate: re-scope"** when the path to ready is a sprawl rather than a short diff. Never a finding dump.
7. **PROPOSE to the operator.** Present the decision + the minimal in-scope diff. The gate **never self-mutates** — the operator approves and applies. The gate holds no write authority over the artifact.

---

## The five leashes (defined once, inherited by every gate)

These convert raw checking capability into bounded forward motion. They live here, in the base flow — every gate inherits all five.

1. **Givens preamble.** Harness primitives, the mature toolkit, and existing conventions are **ambient**. Flagging "there is no Workflow engine" or any given is out of bounds. (Seeded in flow step 3.)
2. **Scope fence.** The check ranges over **the one artifact for this break** only. Re-architecture, cross-skill ranging, or recommendations against other docs/skills are out of bounds. (Seeded in flow step 3.)
3. **Fixed rubric.** The gate scores against the **profile's published checklist**, not an open "find everything" mandate. (Flow step 4.)
4. **Bias to READY.** Block only on genuine autonomy/correctness breaks; the default disposition is "nit — proceed." (Flow step 5.)
5. **Minimal-diff output.** The output is a decision + the **shortest in-scope action list** to reach ready, or "escalate: re-scope" if the path is a sprawl. **Never a finding dump.** (Flow step 6.)

Cost is what the leashes produce, not a sixth knob to tune — a fenced scope + a short fixed rubric on one artifact, run inline, has no open hunt to run up a bill. **There are no token or agent budget numbers.**

---

## The profile schema (the slot contract every gate fills)

Each `assets/ready/gN.md` is a concrete profile that fills this schema and **references this guide** rather than restating the flow or leashes.

### Required slots — every gate MUST define (no sensible default)

- **inputs** — which doc(s) the gate reads (e.g., `…-design.md`, or `…-plan.md` + `…-plan-review.md`).
- **rubric** — the gate's fixed checklist; this is the gate's identity.
- **verdict semantics** — what READY means at this break (e.g., ready-for-`/review-doc`, ready-to-plan, ready-to-execute).

### Tunable slots — the flow ships a default; a gate overrides only if it differs

- **allowed remedy classes** — default: **doc-edit / spike / scope-out / escalate**. A gate overrides only when it needs more (e.g., G3 adds **archive / don't-plan**).

> **There is no "weight" slot.** Every gate runs **inline** — gates differ only in **rubric, inputs, verdict, and remedy classes**. Check depth follows from which inputs exist (a light smell test where no executable steps exist yet; a load-bearing per-step verdict where they do), not from a tunable knob.

---

## The autonomy check (a rubric element shared by every gate)

An item/step is **autonomous** if the executor can carry it with **no exploration turn (spike)** and **no human turn (go-ahead / operator-driven step)**. The three exclusions — spike / human-gate / operator-driven step — must not appear in the artifact **as work**. Validation that genuinely needs a human or live environment is permitted only as a **labeled, bounded post-execution acceptance activity**; if too much real work is deferred that way, the gate **withholds READY** (closing the "relabel-to-pass" hatch).

The *concern* is shared by every gate; the *depth* tracks whether executable steps are present — a light "does this obviously force non-autonomous work?" smell test at G1–G3, the load-bearing per-step verdict at G4, the end-to-end pass at G5.

---

## Resolution rule (flow step 1)

`/dev-ready <doc>` binds the **furthest-along** break. It derives the task slug **and directory** from the `<doc>` argument (strip the `-goal` / `-design` / `-plan` / `-review` suffix and `.md`), globs the doc's sibling artifacts in that directory (`<dir>/<slug>-*.md` — normally `docs/`, but a `/tmp/` fixture resolves against `/tmp/`), walks the artifact ladder, and selects the last gate whose inputs are present:

```
goal → design → design-review → plan → plan-review
 G1       G2          G3          G4        G5
```

- **G1 is the floor** — it fires when no `…-design.md` exists yet.
- Each **`-review.md` twin advances the cursor one gate** (a `…-design-review.md` advances G2 → G3; a `…-plan-review.md` advances G4 → G5). Detector = `-review.md` twin presence (the review skill persists a `-review.md` sidecar alongside each reviewed doc).
- The gate is **always computed**, never operator-supplied — the `<doc>` argument selects the *task*, the ladder selects the *gate*.

---

## PROPOSE-only mutation (flow step 7)

The gate **never edits the artifact itself.** It surfaces the minimal in-scope diff, the operator approves, the operator applies. This sidesteps atomicity, rollback, and stale-review concerns entirely — the gate's only output is a decision + a proposed diff, with no write authority over the artifact.

---

## Inline-only execution

Every gate completes **inline**: one agent, one context, a fixed rubric. **No sub-agents, no fan-out, no workflow script, and no dependency on the Workflow primitive** anywhere in the flow. Heavy parallel analysis is the review layer's job (`/review-doc-run`), which runs one step after G2/G4 — the gate neither duplicates it nor depends on it.

---

## Anti-pattern — the dogfood dud (why the leashes exist)

This layer exists because an **undirected** version of the gate was built and run on a real design doc. The outcome: two ~98-agent runs (~196 agents), ~6M tokens, 30 "findings," **zero forward progress** — fireworks, no outcome. Each leash above closes one of its failure modes:

| The dud did this | The leash that closes it |
|---|---|
| Flagged "Anvil has no Workflow engine" as a HIGH blocker | **Givens preamble** (leash 1) — ambient primitives are out of bounds to flag. |
| Ranged over re-architecting the whole toolkit | **Scope fence** (leash 2) — checks the one artifact; re-architecture is out of bounds. |
| Open-ended "find everything" → 30 findings | **Fixed rubric** (leash 3) — scores against the profile's published checklist. |
| Over-blocked (7 "blockers," most self-induced) | **Bias to READY** (leash 4) — blocks only on genuine breaks; default "nit — proceed." |
| 30 findings, no path to ready | **Minimal-diff output** (leash 5) — a decision + shortest action list, never a dump. |
| ~6M tokens, ~196 agents (open fan-out hunt) | **Inline-only execution** — no fan-out to multiply cost; cost falls out of direction. |

The dud is the named failure mode this flow is built to prevent. A gate run that flags a harness given, recommends re-architecture, dumps findings, or fans out has regressed to the dud — that is the anti-pattern, not the target.

---

## Next Stage

A gate's PROPOSE output hands back to the operator, who applies the minimal diff (if any) and proceeds to the next dev stage the resolution rule named (design / review / plan / execute). The gate does not advance the pipeline itself.
