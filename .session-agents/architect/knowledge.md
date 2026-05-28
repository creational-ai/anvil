# Architect — Knowledge

Durable per-project knowledge for the architect role. Re-read on every activation.

*See `~/.claude/skills/session-agents/references/knowledge.md` for what belongs here vs. doesn't.*

---

## Authoritative refs (re-read on activation)

- `.session-agents/agents.md`, `CLAUDE.md`

*Add project-specific vision/architecture/design docs and any external references the architect should re-read on activation.*

---

## Load-bearing invariants

*The architecture is (or will be) built around a small number of invariants. For each: invariant statement, why it's load-bearing, what would trigger revisiting it.*

---

## Cross-doc consistency rules

- **dev-skill stage/command/agent additions must propagate upward to SKILL.md.** When a new stage, command, or agent lands in `claude-code/dev/`: also touch SKILL.md's framing line (`A structured N-stage workflow...`), the Quick Reference table (Stage row + Input column references), and the File Naming Conventions section. Two failures of this pattern observed in the 2026-05-27 dev-skill audit: Stage 0 (commit `218143f`) propagated to downstream guides + agents but not SKILL.md Quick Reference; `dev-milestone-summary` command added but milestone-summary.md absent from SKILL.md File Naming list. The downstream guides are correctly updated each time — the architect-domain gap is the upstream summary at SKILL.md.
- **Input columns in summary tables model primary contracts, not optional contextual reads.** When an optional secondary doc (e.g., `goal.md`) is read across multiple stages, surface it as a table footnote — NOT by stuffing it into each stage's input cell. Per-cell additions overstate the doc's role and clutter the at-a-glance summary. Footnote captures the cross-stage shared-context shape without inflating column semantics. (Ratified for LOW-6 in 2026-05-27 dev-skill audit; QA agreed.)

---

## Decision rationale anchors

*Load-bearing decisions: what was decided, what was rejected, what triggered the decision. Future-you needs the why.*

---

## Anti-patterns to flag

*Project-specific drift hazards beyond the standard architect anti-patterns in the skill.*
