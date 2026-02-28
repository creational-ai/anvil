# Project State: Anvil

> **Last Updated**: 2026-02-27T18:08:21-0800

**Anvil** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 4 Anvil skills (design, dev, research, review). Review skill has persistent review tracking with per-item history and auto-fix support. 73/73 verify.sh checks passing. Marketing milestone 1/6 tasks complete.

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

---

## What's Next

**Recommended Next Steps**:
1. Begin Distribution Listings task (awesome list PRs, SkillsMP indexing)
2. Begin LinkedIn Launch task (profile optimization, first posts)
3. Manual: Pin Anvil as flagship repo on creational-ai org page (GitHub web UI)

**System Status**: ✅ **Production Ready + Review Tracking**
- 4 Anvil skills: design, dev, research, review
- 5-stage design skill v2.0.0 (simplified naming: vision, roadmap, task-spec)
- 3-stage dev skill with spec-driven plan workflow (full gap analysis complete)
- review skill: persistent review tracking with per-item history, --auto support, parallel + sequential doc review, skill auditing
- All agents use bare role names, all forked commands use /spawn-* prefix
- research/ skill consolidates market-research and naming-research
- 73/73 verify.sh checks passing
- Marketing milestone 1/6 tasks complete (GitHub Presence)

---

## Latest Health Check

### 2026-02-27 - core-review-tracking Finalization
**Status**: ✅ On Track

**Context**:
Finalizing the core-review-tracking task -- added persistent review tracking to the doc review workflow with a new review-tracking template, updated sequential and parallel guides, updated doc-reviewer agent, commands, SKILL.md, CLAUDE.md, and README.md. 1 file created, 9 files modified.

**Findings**:
- ✅ Alignment: Persistent review tracking directly supports the review skill's purpose -- review history is no longer lost when sessions end. Per-item tracking and auto-fix mode make reviews more useful and save conversation context.
- ✅ Production: All changes deployed via deploy.sh and verified via verify.sh (73/73 checks). Deployed files match source (8/8 diff-verified). --auto chain traceable end-to-end through command -> agent -> guide layers.
- ✅ Scope: All 8 implementation steps (0-8 including baseline) executed per plan specification. All 8 success criteria met. Zero deviations from plan.
- ✅ Complexity: Proportionate -- 1 new template + 9 targeted modifications. Sequential guide went from 9 to 11 steps; parallel guide from 5 to 7 phases. No unnecessary abstractions.
- ✅ Gap: No stale behavioral references to final-report.md in modified files. SKILL.md catalog entry for final-report.md retained correctly (file still exists on disk; deprecation is a follow-up). Manual e2e testing is the recommended next step.
- ✅ Tests: 73/73 verify.sh checks passing consistently across all 9 implementation steps.

**Challenges**:
- Downstream format changes cascaded to upstream grouping table (Phase 3.2) -- changing persistence target from final-report.md to review-tracking.md required updating merge grouping, not just downstream phases
- Distinguishing catalog references (legitimate) from behavioral references (stale) during final-report.md migration

**Results**:
- ✅ review-tracking.md template with per-item structure (summary tables, detail sections, holistic section, review log)
- ✅ Sequential guide: 11 steps with arg parsing, history cross-ref, persistence, simplified summary, fix status
- ✅ Parallel guide: 7 phases (3.1-3.7) with same capabilities
- ✅ --auto flag supported across all 3 review doc commands
- ✅ All project docs (SKILL.md, CLAUDE.md, README.md) updated

**Lessons Learned**:
- Deploy/verify pipeline auto-discovers new templates without configuration changes
- Fork context handling is critical for spawn commands -- must handle absence of user for interactive prompts
- Three-layer flag chain (command -> agent -> guide) requires end-to-end tracing during validation

**Next**: Manual e2e test of review tracking. Follow-up: deprecate final-report.md template. Continue Marketing milestone tasks.
