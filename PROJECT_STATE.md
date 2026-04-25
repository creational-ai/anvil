# Project State: Anvil

> **Last Updated**: 2026-04-24T16:53:45-0700

**Anvil** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 4 Anvil skills (design, dev, research, review). Design skill refactored from 5 stages to 4 (vision, architecture, milestones, tasks) with formal two-rule naming convention (`[project-slug]-*` vs `[milestone-slug]-*`) mirrored across SKILL.md + CLAUDE.md. Review skill additively extended to recognize both legacy and 4-stage doc types. Review skill has persistent review tracking, per-item history, auto-fix support, step-splitting, paired tick-driven review loops (`/review-doc-run-loop` + `/exam-loop`), and operator-facing `/walkthrough` command for pedagogical per-unit elaboration. Marketing milestone 1/6 tasks complete.

---

## Progress

### Milestone: Core

| ID | Name | Type | Status | Docs |
|-----|------|------|--------|------|
| add-milestone-stage | Add Milestone Design Stage | feature | ✅ Complete | `add-milestone-stage-*.md` |
| refactor-overview-to-design-focus | Refactor dev-cycle Overview to Design Focus | refactor | ✅ Complete | — |
| cc-design-v2-upgrade | CC Design Skill v2.0 Upgrade | refactor | ✅ Complete | `cc-design-v2-upgrade-*.md` |
| dev-skill-gap-s1 | Design Stage Enhancements (Risk Profile, Constraints, Impl Options, Parallelization) | refactor | ✅ Complete | `dev-skill-gap-s1-*.md` |
| dev-skill-gap-s2 | Spec-Driven Plan Template, Results Deviation Tracking, Review Expansion | refactor | ✅ Complete | `dev-skill-gap-s2-*.md` |
| dev-skill-gap-s3 | Stale Pre-Spec-Driven Reference Cleanup | refactor | ✅ Complete | `dev-skill-gap-s3-*.md` |
| design-naming-cleanup | Design Naming Cleanup (drop "product-" prefix) | refactor | ✅ Complete | `design-naming-cleanup-*.md` |
| poc-to-task | Stage 5 Rename: PoC Spec to Task Spec | refactor | ✅ Complete | `core-poc-to-task-*.md` |
| naming-refactor | Naming Refactor (Claude Code Conventions) | refactor | ✅ Complete | `core-naming-refactor-*.md` |
| review-skill | Unified Review Skill (verify + skill-reviewer consolidation) | refactor | ✅ Complete | `core-review-skill-*.md` |
| review-tracking | Persistent Review Tracking with Per-Item History | feature | ✅ Complete | `core-review-tracking-*.md` |
| step-splitting | Sub-Step Support for Plan Step Splitting | feature | ✅ Complete | `core-step-splitting-*.md` |
| review-auto-loops | Auto Loops: /review-doc-run-loop + /exam-loop (tick-driven staggered review) | feature | ✅ Complete (Step 6 ⏭️ skipped) | `core-review-auto-loops-*.md` |
| review-walkthrough | Operator-Facing /walkthrough Command (five-angle per-unit elaboration) | feature | ✅ Complete (smoke test ⏸ operator gate) | `core-review-walkthrough-*.md` |
| design-4stage | Design Skill 5→4 Stage Refactor (delete milestone-spec, rename roadmap→milestones, task-spec→tasks) | refactor | ✅ Complete (Step 10 genesis deploy ⏸ operator gate) | `core-design-4stage-*.md` |

### Milestone: Marketing

| ID | Name | Type | Status | Docs |
|-----|------|------|--------|------|
| github-presence | README v2.0.0 + Creational Org Profile | feature | ✅ Complete | `marketing-github-presence-*.md` |
| distribution-listings | Awesome List + SkillsMP Listings | feature | ⬜ Pending | — |
| linkedin-launch | LinkedIn Build-in-Public Content | feature | ⬜ Pending | — |
| community-seeding | Reddit, HN, Discord Community Posts | feature | ⬜ Pending | — |
| creational-devlog | Astro Devlog + First Article | feature | ⬜ Pending | — |
| traction-evaluation | Channel Effectiveness Report | feature | ⬜ Pending | — |

---

## Key Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-01-03 | 5-stage design workflow | Supports organic milestone growth with clear/unclear path distinction |
| 2026-01-03 | Environment split (CD vs CC) | Stages 1-2 in Claude Desktop for exploration, 3-5 in Claude Code for structure |
| 2026-01-26 | Rename dev-design to design, dev-cycle to dev | Cleaner naming conventions |
| 2026-02-07 | Sync CC design skill with CD v2.0.0 naming | Consistent naming across CC and CD, adopt content improvements (Testing Strategy, Feedback Loops, 200 Users First) |
| 2026-02-16 | Add Risk Profile, Constraints, standard Implementation Options, parallelization hints to design stage | Close Stage 1 gaps from gap analysis; richer design docs for downstream stages to leverage |
| 2026-02-16 | Spec-driven plan steps with Specification + Acceptance Criteria instead of Code/Tests blocks | Close Stage 2/3/3b gaps; leaner plans, explicit executor-reviewer contract, deviation tracking |
| 2026-02-24 | Drop "product-" prefix from vision/roadmap naming across design skill | Redundant prefix; simplify to `vision` and `roadmap` for cleaner naming conventions |
| 2026-02-24 | Rename Stage 5 from "PoC Spec" to "Task Spec" | Stage 5 is generic task decomposition, not PoC-specific; "PoC" stays as one of 4 task types |
| 2026-02-24 | README restructured as landing page | Hook, badges, elevated Quick Start, proof section, competitive positioning convert visitors to stars |
| 2026-02-24 | Org profile lists only verified public repos | Broken links on a profile card look incomplete; list only Anvil, VisualFlow, Unity Builds |
| 2026-02-24 | No links on "Built with Anvil" product list | Only Anvil has a confirmed public repo in the org; linking others would create dead links |
| 2026-02-26 | Naming refactor: spawn-* prefix, bare role agents, research/ skill, verify/ skill | Align with official Claude Code conventions; fix skill-command collision; clean foundation for verify v2 |
| 2026-02-26 | Consolidate verify + skill-reviewer into unified review skill | 4-skill toolkit cleaner than 5; parallel subagent architecture enables faster doc reviews; single quality assurance entry point |
| 2026-03-10 | Sub-step notation (8a, 8b, 8c) for plan step splitting | Letter suffixes preserve existing step numbers (no renumbering), one level only, review-driven splits with pre-execution guard |
| 2026-04-18 | Add paired tick-driven review loops (`/review-doc-run-loop` + `/exam-loop`) with single-source-of-truth `review-loop-guide.md` | Two independent main-conversation sessions coordinate staggered R → E → R → E cycles via shared review doc without manual hand-off. Echo-encoded state survives compaction; tuning constants (POLL_INTERVAL_SECONDS=240, MAX_IDLE_TICKS=4, MAX_ROUNDS=20) defined once in guide. Single-pass `/review-doc-run` and `/exam` untouched. |
| 2026-04-18 | SKIP Step 6 integration tests entirely for core-review-auto-loops | User directive: exercise new commands in daily use and iterate empirically. Two-session paired integration tests deemed unnecessary overhead; load-bearing wake-up-when-idle assumption accepted as unverified at feature-ship time. Rework cost identical whether discovered now or later. |
| 2026-04-23 | Thin-wrapper-plus-fat-guide pattern for `/walkthrough` | Mirrors existing review-command pattern (`/exam`, `/monitor`, `/review-doc`); single edit surface for walkthrough behavior; keeps command markdown at ~39 lines while guide owns ~195 lines of semantic rules. Registration trio (Quick Reference row + Commands list entry + Capabilities subsection) enforced via 3 separate acceptance greps — no partial registration possible. |
| 2026-04-23 | When Specification and Acceptance Criteria contradict, the grep wins | Step 2 Specification said "mention `--auto`" but Acceptance Criterion #6 required `grep -cE "--auto" == 0`. Enforced greps are the binding contract; "mention X" directives are drafting artifacts. Resolved by "No flags." without naming specific disavowed flags. |
| 2026-04-23 | Live smoke test for `/walkthrough` deferred to operator as manual gate | Executor agent cannot run interactive commands in a fresh Claude Code session with human-in-loop pause semantics. All automatable preconditions (deploy, verify, byte-match, count delta, doc-unchanged) pass, giving the manual test maximum precondition strength. Same pattern as any `disable-model-invocation: true` command requiring operator input. |
| 2026-04-24 | Collapse design skill from 5 stages to 4 (delete milestone-spec, rename roadmap→milestones, task-spec→tasks) | Stage 4 (milestone-spec) duplicated concerns already covered by Stage 3 (roadmap → milestones) + Stage 5 (task-spec → tasks); merging Prerequisite + Scope into the renamed 4-tasks template removes the extra layer without losing information. Two-rule naming convention (`[project-slug]-*` vs `[milestone-slug]-*`) formalized in SKILL.md + mirrored byte-for-byte into CLAUDE.md. Review skill extended additively to recognize both legacy and 4-stage doc types (no breaking change for user repos that still hold old-name files). |

---

## What's Next

**Recommended Next Steps**:
1. **Operator action (core-design-4stage Step 10)**: When ready, run `cd claude-code && ./deploy-genesis.sh && ./verify-genesis.sh` to propagate the 5→4 refactor to genesis. Expect exit 0 on both; command count on genesis should drop to 43 (was 44 baseline) if pair-sync behaves. Per CLAUDE.md, genesis deploy is a separate manual action.
2. **Follow-up task**: Update `claude-code/README.md` to 4-stage vocabulary (4 hits: `milestone-spec` x3, `task-spec` x1 at lines 35/82/138). Out-of-scope for core-design-4stage per its design-doc scope boundary; recommend small follow-up.
3. **Operator action (core-review-walkthrough)**: Run `/walkthrough docs/core-review-walkthrough-design.md` in a fresh Claude Code session; confirm first unit renders five angles, `stop` ends cleanly, `git diff` returns empty. Final smoke-test gate.
4. Exercise new loop commands + `/walkthrough` in actual daily use; log any wake-up, resume-math, parser, or walkthrough-rendering issues as follow-up bugs.
5. Begin Distribution Listings task (awesome list PRs, SkillsMP indexing).
6. Begin LinkedIn Launch task (profile optimization, first posts).

**System Status**: ✅ **Production Ready + 4-Stage Design + Auto Loops + Walkthrough**
- 4 Anvil skills: design, dev, research, review
- **4-stage design skill** (vision, architecture, milestones, tasks) with formal two-rule naming convention (`[project-slug]-*` vs `[milestone-slug]-*`)
- 3-stage dev skill with spec-driven plan workflow and sub-step support; 8 cross-refs normalized to `[milestone-slug]-tasks.md`
- review skill: persistent review tracking with per-item history, --auto support, step scope check with split suggestions, parallel + sequential doc review, skill auditing, paired tick-driven review loops (`/review-doc-run-loop` + `/exam-loop`), operator-facing `/walkthrough` for pedagogical per-unit elaboration, additive 4-stage doc-type recognition alongside legacy 5-stage support
- review-loop-guide.md owns all loop mechanics (parser, roles, gates, tick loop, echo state, termination, tuning) as single source of truth
- walkthrough-guide.md owns five-angle elaboration rules, three-tier adaptive vocabulary, unit extraction depth detection, per-unit advance semantics
- All agents use bare role names, all forked commands use /spawn-* prefix
- research/ skill consolidates market-research and naming-research
- Marketing milestone 1/6 tasks complete (GitHub Presence)
- **42 deployed commands** (was 43; −3 old design commands + 2 new), 16 agents, **74/74 verify checks passing**

---

## Latest Health Check

### 2026-04-24 - core-design-4stage Finalization
**Status**: ✅ On Track (structural + deploy/verify green on local; Step 10 genesis deploy deferred to operator per project policy)

**Context**:
Finalizing the core-design-4stage task — collapsed design skill from 5 stages to 4 (vision, architecture, milestones, tasks). Step 1 merged Prerequisite + Scope from milestone-spec into the renamed 4-tasks template; Steps 2-4 deleted milestone-spec triplet and renamed roadmap→milestones / task-spec→tasks via `git mv` with history preservation; Steps 5-7 rewrote design SKILL.md, mirrored the two-rule naming statement byte-for-byte into CLAUDE.md, and normalized 8 dev-skill cross-refs to `[milestone-slug]-tasks.md`; Step 8 added OLD_COMMANDS entries in pair-sync parity; Step 9 local deploy + verify passed 74/74; Step 9.5 (mid-execution insert per monitor Issue #2) additively extended review skill to recognize both legacy and 4-stage doc types. Step 10 (genesis deploy) correctly deferred — project CLAUDE.md mandates genesis deploy as a separate manual operator action.

**Findings**:
- ✅ Alignment: 4-stage refactor is a structural simplification of the design skill's own pipeline — the skill IS the product for Anvil, so pipeline shape is core to product vision. Two-rule naming convention (`[project-slug]-*` vs `[milestone-slug]-*`) formalizes a previously-implicit distinction and makes CLAUDE.md a byte-for-byte mirror of SKILL.md rather than a divergent fork. Aligns with "single source of truth" patterns already established in review-loop-guide.md and walkthrough-guide.md.
- ✅ Production: All edits land on production surfaces (SKILL.md, CLAUDE.md, commands, templates, guides, deploy/verify scripts). `deploy.sh && verify.sh` on local returns exit 0 with `✅ Passed: 74 ❌ Failed: 0`; command count dropped from 43 → 42 as designed (+2 new `design-milestones.md`/`design-tasks.md`, −3 old `design-milestone-spec.md`/`design-roadmap.md`/`design-task-spec.md`). `OLD_COMMANDS` cleanup loop fired 3 explicit `✓ Removed` log lines for each new orphan entry.
- ✅ Gap: Step 10 (genesis deploy + verify) deferred by project policy — `CLAUDE.md` line 45 explicitly marks `deploy-genesis.sh` as a separate manual action. All local automatable preconditions pass. Risk mitigated because (a) deploy/verify scripts are pair-synced at the array-content level, (b) genesis reuses the same skill tree via SSH, (c) pair-parity invariant is the binding contract, not the absolute command count.
- ✅ Scope: 10 steps (+ Step 9.5 additive insert) executed per plan. Mid-execution Step 9.5 is a legitimate pattern — monitor Issue #2 surfaced an in-scope gap (review skill's hardcoded legacy doc-type references), and the executor chose additive-step insertion over rollback or Success-Criteria narrowing. ADD-not-replace discipline verified via baseline count invariants: `milestone-spec`/`roadmap`/`task-spec` counts in `claude-code/review/` UNCHANGED (16/12/22 → 16/12/22) proving no accidental legacy removal.
- ✅ Complexity: Proportionate. Refactor touches exactly the surfaces named in the plan's scope-boundary line: design skill source files (7 edits), dev skill cross-refs (8 substitutions across 6 files), project CLAUDE.md (4 sections + two-rule mirror), deploy/verify scripts (pair-sync). No premature abstractions, no redundant surface area. Out-of-scope leaks (`claude-code/README.md`, `claude-code/review/`) correctly deferred as follow-up tasks rather than expanding mid-execution.
- ✅ Tests: N/A for runtime — design skill is structural (templates, guides, commands). Verification is deploy+verify+grep-count based. All 19 Success Criteria auto-verified: 10 grep/count checks on design subtree, 4 on CLAUDE.md, 4 on dev-skill cross-refs, 1 git-log-follow verified via `R100` staged-rename snapshot at the mv boundary. `/review-skill claude-code/design` inline check at Step 5: 0 HIGH findings across all 8 validation checks.

**Challenges**:
- Plan-AC vs step-ownership ambiguity surfaced repeatedly (Steps 3, 4, 5): strict "0 matches in design/ subtree" ACs conflicted with Step 5's explicit ownership of SKILL.md rewrites. Resolved via step-ownership precedence as the authoritative partition. Flagged in Issues blocks at each step so reviewers can confirm the resolution pattern.
- Step 4 command file similarity dropped to 46% post-content-edits (below git's default -M50% rename threshold). Pre-content-edit `R100` snapshot served as audit trail; post-commit `--follow` requires `--find-renames=30%` to cross the boundary. Documented in Lessons Learned for future heavy-rename steps.
- Monitor Issue #2 (review skill scope gap) caught mid-execution after Steps 1-9 had landed. Rather than rollback or ignore, executor + operator chose Step 9.5 additive-insert path. Worked cleanly because purely additive, idempotent re-deploy, and broader Success Criteria already covered the scope.

**Results**:
- ✅ Design skill file surface: 4 commands / 4 templates / 4 guides (was 5/5/5), all with correct stage-number prefixes (1-vision, 2-architecture, 3-milestones, 4-tasks); no stale `milestone-spec`/`roadmap`/`task-spec` files remain
- ✅ SKILL.md rewritten: 4-row Stage Overview table, two-rule File Naming statement with 5 concrete examples, 4 `/design-*` command bullets, 4 per-stage bodies with correct inputs/outputs/checklists (Stage 4 Complete Checklist extended with absorbed Prerequisite + Scope items)
- ✅ CLAUDE.md updated in 4 sections (File Naming, Templates, Reference Guides, Slash Commands); two-rule statement mirrored byte-for-byte from SKILL.md lines 31-41 to CLAUDE.md lines 103-113 (verified via `diff <(sed -n …) <(sed -n …)` exit 0); line 16 (claude-desktop "Same 5-stage") preserved
- ✅ Dev skill's 8 cross-refs all speak one convention: `[milestone-slug]-tasks.md` (or bare `tasks.md` in 1 bash comment); 3-way alignment across SKILL.md + CLAUDE.md + dev skill prevents future drift
- ✅ Review skill additively extended to recognize 4-stage doc types (`*-milestones.md`, `*-tasks.md`) alongside legacy 5-stage types; 7 files updated; completion-notification allowlist extended
- ✅ `deploy.sh` + `deploy-genesis.sh` `OLD_COMMANDS` arrays both gained 3 entries in pair-sync parity with `# design skill 5→4 stage refactor (core-design-4stage)` provenance comments
- ✅ Local deploy + verify: 74/74 checks passing; command count 43 → 42; all 3 OLD_COMMANDS cleanups fired; 4 `design-*.md` files present with correct names
- ⏸ Genesis deploy + verify deferred to operator per CLAUDE.md policy

**Lessons Learned**:
- `git mv` first, then content edits — pre-edit `R100` snapshot is the load-bearing audit trail when post-edit similarity drops below git's default -M50% rename threshold.
- Pair AC negation greps with explicit-pattern greps — "grep for OLD returns 0" only proves absence, not replacement correctness. Pair with "grep for NEW returns exactly N" to catch typos, over-replacements, half-finished refactors.
- Pair-sync invariant operates at the abstraction level of shared arrays, not whole-file equality. Correct verification primitive: `diff <(grep <pattern> file1) <(grep <pattern> file2)`, NOT `git diff file1 file2`.
- Step-ownership precedence resolves plan-AC ambiguity. When a step's "0 matches" AC conflicts with a later step's explicit ownership, the step-ownership partition is authoritative — redoing work mid-sequence causes commit drift.
- Mid-execution scope expansion via additive insert-step is legitimate when monitor surfaces an in-scope HIGH gap with bounded additive cost. Prefer additive over Success-Criteria narrowing.
- ADD-not-replace discipline verified via baseline count invariants (`grep -rcn` pre/post) — any drop signals accidental legacy removal.
- Mirror verification by byte-diff when plan says "verbatim" — `diff <(sed -n 'a,bp' src) <(sed -n 'c,dp' dst)` exit 0 = byte-identical.

**Next**: Operator runs `cd claude-code && ./deploy-genesis.sh && ./verify-genesis.sh` when ready to propagate to genesis (expect exit 0 on both; genesis command count should drop to 43 from 44 baseline if pair-sync holds). Then address follow-up tasks: (a) update `claude-code/README.md` to 4-stage vocabulary, (b) design+plan cycle for `claude-code/review/` legacy vs 4-stage doc-type vocabulary alignment. Unrelated operator gate still pending: live `/walkthrough` smoke test from the prior core-review-walkthrough task.
