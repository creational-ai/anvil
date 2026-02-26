# Project State: Anvil

> **Last Updated**: 2026-02-26T13:08:47-0800

**Anvil** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 5 Anvil skills (design, dev, verify, research, skill-reviewer). Naming refactor complete: all agents use bare role names, /spawn-* prefix for forked commands, research skill consolidated, verify skill extracted. 66/66 verify.sh checks passing. Marketing milestone 1/6 tasks complete.

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

---

## What's Next

**Recommended Next Steps**:
1. Proceed to verify-doc v2 task (rename verify-doc-agent -> doc-verifier, agent-verify-doc -> spawn-doc-verifier within verify/ skill)
2. Begin Distribution Listings task (awesome list PRs, SkillsMP indexing)
3. Begin LinkedIn Launch task (profile optimization, first posts)
4. Manual: Pin Anvil as flagship repo on creational-ai org page (GitHub web UI)

**System Status**: ✅ **Production Ready + Naming Aligned**
- 5 Anvil skills: design, dev, verify, research, skill-reviewer
- 5-stage design skill v2.0.0 (simplified naming: vision, roadmap, task-spec)
- 3-stage dev skill with spec-driven plan workflow (full gap analysis complete)
- All agents use bare role names (8 renamed, 2 deferred to verify v2)
- All forked commands use /spawn-* prefix (8 renamed, 2 deferred to verify v2)
- research/ skill consolidates market-research and naming-research
- verify/ skill extracted from dev/ (foundation for verify v2)
- 66/66 verify.sh checks passing
- Marketing milestone 1/6 tasks complete (GitHub Presence)

---

## Latest Health Check

### 2026-02-26 - core-naming-refactor Finalization
**Status**: ✅ On Track

**Context**:
Finalizing the core-naming-refactor task -- systematic rename of all Anvil naming to align with official Claude Code conventions. Extracted verify/ skill, renamed 8 agents to bare role names, consolidated research/ skill, renamed /agent-* to /spawn-*, renamed /milestone-details to /dev-milestone-summary, and updated all cross-references.

**Findings**:
- ✅ Alignment: Naming conventions now match official Claude Code patterns (bare role agents, no skill-command collisions), directly supporting credibility for open-source distribution
- ✅ Production: All changes deployed via deploy.sh and verified via verify.sh (66/66 checks) -- no mocks, real deployment
- ✅ Scope: All 7 implementation steps (0-6) executed per plan specification with minimal deviations; all 10 success criteria met
- ✅ Complexity: Proportionate -- mechanical renames with systematic verification at each step; no unnecessary abstractions
- ✅ Gap: verify-doc-agent and skill-review-agent still use old naming, but this is intentional (deferred to verify v2 scope)
- ✅ Tests: 66/66 verify.sh checks passing; grep sweep confirms zero stale references in markdown files

**Challenges**:
- verify.sh template check was too rigid for verify/ skill (no templates directory); resolved by making the check informational
- Multi-project `~/.claude/` directories required scoped orphan checks to avoid false positives from external files (Mission Control, Video Professor)

**Results**:
- ✅ 5 Anvil skills: design, dev, verify, research, skill-reviewer
- ✅ 8 agents renamed to bare role names; 8 spawn commands created
- ✅ research/ skill consolidates market-research and naming-research
- ✅ verify/ skill extracted as foundation for verify v2
- ✅ All cross-references updated (CLAUDE.md, README.md, deploy scripts, SKILL.md files, naming conventions doc)

**Lessons Learned**:
- Forward-updating dependent files in earlier steps eliminates cross-step dependencies
- deploy.sh cleanup arrays (OLD_AGENTS, OLD_COMMANDS) ensure renamed files are removed on deploy
- Grep sweeps must check .md and .sh files separately since shell scripts intentionally contain old names

**Next**: Proceed to verify-doc v2 task (rename verify-doc-agent and agent-verify-doc within verify/ skill). Continue Marketing milestone tasks.
