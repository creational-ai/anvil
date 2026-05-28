# Architect verification — dev-skill audit (2026-05-27)

**From:** architect role
**Re:** Builder's 7 findings (2 MED + 5 LOW) from `/review-skill claude-code/dev/`
**Angle:** structural / design-framing
**Verdict summary:** all 7 confirmed; 4 refinements proposed; 1 cumulative-pattern flag added.

---

## MED-1 — `assets/templates/1-design.md:184-185` complexity column case

**Verified state:**
- Lines 184-185: `Low/Med/High` (mixed case) — confirmed via Read.
- Lines 208-209: `HIGH/MED/LOW` (uppercase) — confirmed.
- Internal inconsistency within the same template, two tables apart.

**Architect verdict:** AGREE — fix.

**Refinement:** This is a *template-placeholder* case, not just stray prose. Placeholders are the strongest convention-teaching surface in the skill — operators copy them verbatim and propagate the case. Fixing the placeholder enforces the project rule by example, not just by policy. CLAUDE.md says "Severity / risk / probability / confidence labels: Always use `HIGH / MED / LOW`" — Complexity is not literally on that list, but it's the same family of ordinal labels and the same Risks table at 208-209 already adopts the uppercase convention. Apply uniformly.

---

## MED-2 — `SKILL.md:3` and `:24` "3-stage workflow" stale framing

**Verified state:**
- Line 3: `A structured 3-stage workflow for implementing tasks with production-grade quality.`
- Line 24: `This skill operates at the **Task level** - one task at a time through a 3-stage workflow:`
- Below those: `1. Stage 1: Design`, `2. Stage 2: Planning`, `3. Stage 3: Execution`.
- Later sections enumerate `Stage 0: Goal (Optional)` (line 83) and `Stage 3b: Review (Opt-In)` (line 156).
- Quick Reference table also enumerates Stage 0.

**Architect verdict:** AGREE — fix, but with framing decision attached.

**Refinement (design-framing, not just text):** "3-stage" is technically the *required spine*; Stage 0 and Stage 3b are optional flanks. Three viable framings:
1. **Keep "3-stage" + clarifying clause** — describe Stage 0 + Stage 3b as optional bookends. Preserves operator mental model that 3 stages are the required path.
2. **Change to "4-stage"** — treats Stage 0 as load-bearing. Risk: operators read "4-stage" and assume Stage 0 is mandatory; goal-guide.md is clear it's opt-in for specific task shapes.
3. **Restructure to "core 3 stages + 2 optional stages"** — most accurate but verbose.

**Recommended:** option 1. Concrete edit candidate:
- Line 3: `A structured 3-stage workflow (with optional Stage 0 alignment and opt-in Stage 3b review) for implementing tasks with production-grade quality.`
- Line 24: `This skill operates at the **Task level** — one task at a time through a 3-stage core workflow, optionally wrapped by Stage 0 (goal) and Stage 3b (conceptual review):`

**Why this matters cumulatively:** the Stage 0 wiring (commit `218143f`) propagated to downstream guides (1-design-guide, 2-planning-guide, 3-execution-guide), agent files (dev-designer, dev-executor), and command files — but the upstream SKILL.md framing lines were not refreshed. This is the same "propagation gap" pattern flagged in LOW-6 below. See cumulative observation at the bottom.

---

## LOW-3 — `agents/dev-executor.md:6` canonical marker deviation

**Verified state:**
- Current comment at line 6: `<!-- Intentionally NO 'tools:' field in frontmatter: omitting it lets this agent inherit ALL tools, including project-specific MCP servers (e.g., UnityMCP, mission-control). Adding a 'tools:' allowlist would EXCLUDE all MCP tools — see project CLAUDE.md "Agent tools field gotcha". Other dev/* agents use explicit allowlists because they don't need MCP. -->`
- `skill-review-guide.md:91` mandates: `<!-- no-tools: inherits all -->` as the canonical marker (verified via grep).

**Architect verdict:** AGREE — but refine the fix.

**Refinement:** The current verbose comment is *more informative* (explains the gotcha, references CLAUDE.md, contrasts with peer agents). The canonical marker is *more uniform* and grep-friendly. Don't strip the explanation for marker conformity — keep both.

**Recommended fix:** put the canonical marker on its own line first (for grep), then the explanatory paragraph below:
```
<!-- no-tools: inherits all -->
<!-- Rationale: omitting `tools:` lets this agent inherit ALL tools, including project-specific MCP servers (UnityMCP, mission-control). An explicit allowlist would EXCLUDE all MCP tools — see project CLAUDE.md "Agent tools field gotcha". Other dev/* agents use explicit allowlists because they don't need MCP. -->
```

Two markers, two purposes: structural-uniformity grep target + contributor-onboarding rationale. Both stay.

---

## LOW-4 — `agents/dev-finalizer.md:27-37` section order deviation

**Verified state (via grep on `^## `):**
- `dev-designer`: Mission → First → Input → Key Concept → Process → Critical Rules → Output → Completion Report → ... → Quality Checklist
- `dev-planner`: Mission → First → Input → Critical Rules → Process → Output → Completion Report → ... → Quality Checklist
- `dev-executor`: Mission → First → Input → Critical Rules → Process → Output → Completion Report → ... → Quality Checklist
- `dev-milestone-summarizer`: Mission → First → Input → Critical Rules → Process → Output → Completion Report → ... → Quality Checklist
- `dev-finalizer`: Mission → First → **Critical Rules → Input → Process** → Output → Completion Report (no Quality Checklist)
- `dev-reviewer`: Mission → First → Input → Critical Rules → Process → Scope → Output → Completion Report (no Quality Checklist)

**Architect verdict:** AGREE — fix.

**Refinement:** Canonical peer order is **Input → Critical Rules → Process** (planner/executor/milestone-summarizer; designer inserts Key Concept between Input and Process and places Critical Rules later — outlier but defensibly because it has a structure-explanation block to anchor first). Finalizer reverses Input/Critical Rules; reviewer follows the canonical order.

The Critical Rules content (`ALL 4 STEPS ARE REQUIRED`) doesn't lose punch by being placed AFTER Input — it lands right before Process, which is exactly when the operator/agent needs to internalize it. Reorder.

---

## LOW-5 — `agents/dev-reviewer.md` missing Quality Checklist

**Verified state:**
- Confirmed: `dev-reviewer.md` ends after Completion Report (line 70). No Quality Checklist.
- Also confirmed: `dev-finalizer.md` lacks Quality Checklist too (only reviewer was flagged, but finalizer has the same gap).

**Architect verdict:** AGREE — but extend scope to BOTH agents.

**Refinement:** Two architects' angles to weigh:
- **Defensibility (per builder):** reviewer defers to `review-guide.md`; finalizer defers to `/dev-finalize`. Both delegate quality criteria externally. A duplicating section would be bad.
- **Uniformity:** four other peers all have Quality Checklist sections. The structural inconsistency is real and reader-visible.

**Decision (architect ratifies QA's recommendation):** option (a) — normalize. Add a minimal pointer Quality Checklist to both. Rejecting option (b) (formalize exception in SKILL.md) because the uniformity tax is ~3 lines per file and the SKILL.md exception-prose cost is higher than the pointer cost.

**Recommended fix:** add a minimal pointer Quality Checklist to BOTH reviewer and finalizer:
```markdown
## Quality Checklist

Follow the Quality Checklist criteria in `review-guide.md` (risk-profile depth, intent-match, ...).
```
And for finalizer:
```markdown
## Quality Checklist

Follow the Verification checklist in `/dev-finalize` (the 4-step completion verifier is the source of truth).
```

Pays the uniformity tax without duplicating content. Cost: ~3 lines per file. Benefit: agent-file structure becomes truly uniform across the suite.

---

## LOW-6 — `SKILL.md:32-37` Quick Reference omits goal.md as context input

**Verified state:**
- Quick Reference Stage 1 Input: `Bug/feature spec, user notes` (no goal.md)
- Stage 2 Input: `docs/[milestone-slug]-[task-slug]-design.md (recommended)` (no goal.md)
- Stage 3 Input: `docs/[milestone-slug]-[task-slug]-plan.md` (no goal.md)
- Downstream guides explicitly read goal.md when present:
  - `1-design-guide.md:30-32` — goal.md is read as alignment input
  - `2-planning-guide.md:16-18` — goal.md is the contract steps must deliver
  - `3-execution-guide.md:38-40` — goal.md is the operator-facing target for step boundaries

**Architect verdict:** STRONGLY AGREE — fix.

**Refinement:** This is the cleanest example of architect-domain drift in the audit. A new decision (Stage 0 wiring) was propagated to the downstream guides correctly but did NOT propagate to the upstream summary table in SKILL.md. The Quick Reference table is the canonical at-a-glance reference operators read; missing goal.md from the input columns silently understates Stage 0's downstream wiring.

**Recommended edit (revised per QA's footnote proposal):** add a single footnote beneath the Quick Reference table:
> `*All stages read docs/[milestone-slug]-[task-slug]-goal.md as optional alignment context when present (per each stage's guide). Listed inputs are primary contracts; goal.md is a soft secondary read.*`

**Decision rationale (architect ratifies QA's framing):** QA's footnote proposal is more architect-correct than per-cell additions. Input columns model primary contracts; goal.md is an optional secondary read shared across Stages 1/2/3. Stuffing `goal.md (optional)` into three cells overstates its role and clutters the at-a-glance table. The footnote captures the cross-stage shared-context shape without inflating the column semantics.

Stage 0 row's Input column already says `Operator notes / design doc` — Mode 2 (`update` reformat) adds existing-goal-doc-path as a third input mode. Could add `existing goal doc (update mode)` for completeness, but the table is a summary; the dev-goal command docs cover the three modes. Defer this micro-edit.

---

## LOW-7 — `SKILL.md:213` File Naming Conventions omits milestone-summary.md

**Verified state:**
- SKILL.md lines 212-216 list per-task files: goal.md, design.md, plan.md, results.md. No milestone-summary.md.
- `/dev-milestone-summary` command exists; `dev-milestone-summarizer` agent produces this file.
- Project-root `CLAUDE.md` File Naming Conventions section (under design skill output) lists `docs/[milestone-slug]-milestone-summary.md` correctly.

**Architect verdict:** AGREE — fix.

**Refinement:** This is a milestone-level file, not per-task. Add a "Per Milestone" subsection to SKILL.md File Naming Conventions mirroring the project-root pattern:
```markdown
**Per Milestone**:
- `docs/[milestone-slug]-milestone-summary.md` - e.g., `docs/core-milestone-summary.md`
```

Place it between "Per Task" and "Test Files".

Same cumulative-pattern note as LOW-2 and LOW-6: when `dev-milestone-summary` was added, the command and agent landed but the SKILL.md file-naming list was not updated. Propagation gap.

---

## Cross-cutting flag (not in original audit)

**Pattern observed:** three of the seven findings (MED-2, LOW-6, LOW-7) all reflect the same root cause — *new capability added at the command/guide/agent layer; SKILL.md (the upstream summary) not updated*. Stage 0 (commit `218143f`) and `dev-milestone-summary` both exhibit this.

**Architect implication:** there's no checklist or skeleton enforcing "when you add a stage/command/agent, also touch SKILL.md's `[3]` framing line, Quick Reference table, and File Naming section." This is the kind of cross-doc consistency the architect role is supposed to catch on each change.

**Recommended action:** NOT a fix to land now. Add to architect's `knowledge.md` under "Cross-doc consistency rules" — *"When adding a new stage, command, or agent to dev: also touch SKILL.md framing line, Quick Reference table (Stage row + input columns), and File Naming Conventions section."*

**YAGNI flag:** a literal SKILL.md skeleton template would over-engineer for the current rate of dev-skill change. A knowledge-file rule is enough.

---

## QA cross-check (parallel work converged)

QA filed their independent verdicts at `docs/QA-dev-skill-audit.md` and a notification in `.session-agents/architect/comms.md`. Architect and QA converged on all 7 findings — no false positives between us. QA also flagged LOW-5 extension to finalizer (architect's deliverable independently caught this — see LOW-5 above).

**Two QA-raised decisions architect ratifies in this deliverable:**
1. **LOW-5 fix shape**: option (a) normalize — add minimal pointer Quality Checklist to BOTH reviewer and finalizer. (See LOW-5 above for rejection rationale for option (b).)
2. **LOW-6 fix shape**: footnote under Quick Reference table, NOT per-cell input column additions. (See LOW-6 above for the architect framing of why "primary contract" vs "secondary context" matters.)

Both decisions match QA's recommendations.

**Items where QA peer-review still adds value (not gated on architect):**
- **LOW-3**: confirmed via grep — `skill-review-guide.md:91` mandates the canonical marker. QA can independently verify if desired.
- **MED-1, LOW-7**: mechanical text edits; QA's verdicts already cleared.

---

## Apply order (if all fixes approved)

Mechanical batch (1-design.md, SKILL.md sections, agent reorders): can land in a single commit. Then redeploy local; genesis deploy is separate per CLAUDE.md.

Sequence:
1. MED-1 (1-design.md complexity column)
2. LOW-7 (SKILL.md Per Milestone subsection)
3. LOW-6 (SKILL.md Quick Reference input columns)
4. MED-2 (SKILL.md framing lines)
5. LOW-4 (dev-finalizer reorder)
6. LOW-5 (reviewer + finalizer Quality Checklist pointers)
7. LOW-3 (dev-executor marker + rationale split)
8. Knowledge update (cross-doc consistency rule)

Total estimated effort: ~20 min editing + deploy + verify.
