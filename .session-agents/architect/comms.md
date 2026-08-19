# Comms — Architect

Inbox for the architect role. See `.session-agents/agents.md` for the roster; the `session-agents` skill for comms format and routing.

## Open

*— nothing open —*

## In Progress

*— nothing in progress —*

## Resolved

### [2026-08-19] — TaskCreate retirement — RESOLVED
**From:** session-agents architect (cross-project) — inventory + Council input
**Re:** CC v2.1.233 withheld the five task tools from the models this project runs.
**Verdict:** 20 literal sites across 13 files, three tiers. Remediated per `docs/core-taskcreate-retirement-design.md` v2.0 (operator + CD authored; architect-verified, two defects patched before execution).
**Landed:** review-loop sequence → transcript line; review-triangulate anchor → `/tmp/<slug>-triangulate-run.md`; 9 agent allowlist tokens; `CLAUDE.md:291` protocol paragraph; `core-loop-sa-design.md:434` annotated. Shipped surface at zero; local deploy 79/79.
**Not done:** genesis (deferred to explicit operator deploy — still lagging); `custodian/.system-prompt.md` (no custodian pane running, so `comms refresh` is unperformable — and unnecessary: `compose_for_launch` recomposes unconditionally on every launch and deletes a stale file on failure, so the residue cannot reach a model).
**Correction filed to peer:** their "review-loop wording already drafted" claim was diff-disproved; that rewrite and the `addBlockedBy` replacement were greenfield here.

### [2026-05-27] — Verify dev-skill audit findings (7 issues) — RESOLVED
**From:** default session (operator-relayed `/review-skill claude-code/dev/`)
**Re:** 2 MED + 5 LOW findings verified from structural/design-framing angle. QA filed parallel verdicts (`docs/QA-dev-skill-audit.md`) which converged on all 7 — no false positives.
**Verdict:** all 7 confirmed; 4 refinements proposed; 1 cumulative-pattern flag added (`knowledge.md` cross-doc consistency rules).
**Decisions ratified for QA:**
- Finding 5 → option (a) normalize — add minimal pointer Quality Checklist to BOTH reviewer and finalizer.
- Finding 6 → footnote under Quick Reference table (NOT per-cell input column additions); goal.md is shared optional secondary context across Stages 1/2/3, not a primary input.
**Deliverable:** `.session-agents/architect/audits/2026-05-27-dev-skill-audit-verification.md`
**Reply:** fired to builder via `comms no-reply` with deliverable path.
