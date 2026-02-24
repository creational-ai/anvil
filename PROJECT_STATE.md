# Project State: Anvil

> **Last Updated**: 2026-02-24T12:10:18-0800

**Anvil** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 5-stage design workflow and 3-stage dev workflow. Naming cleanup complete: vision/roadmap file naming simplified across CC and CD. Full gap analysis complete (S1+S2+S3). Ready for production use.

---

## Progress

### Milestone: Core Framework

| ID | Name | Type | Status | Docs |
|-----|------|------|--------|------|
| add-milestone-stage | Add Milestone Design Stage | feature | ✅ Complete | `add-milestone-stage-*.md` |
| cc-design-v2-upgrade | CC Design Skill v2.0 Upgrade | refactor | ✅ Complete | `cc-design-v2-upgrade-*.md` |
| dev-skill-gap-s1 | Design Stage Enhancements (Risk Profile, Constraints, Impl Options, Parallelization) | refactor | ✅ Complete | `dev-skill-gap-s1-*.md` |
| dev-skill-gap-s2 | Spec-Driven Plan Template, Results Deviation Tracking, Review Expansion | refactor | ✅ Complete | `dev-skill-gap-s2-*.md` |
| dev-skill-gap-s3 | Stale Pre-Spec-Driven Reference Cleanup | refactor | ✅ Complete | `dev-skill-gap-s3-*.md` |
| design-naming-cleanup | Design Naming Cleanup (drop "product-" prefix) | refactor | ✅ Complete | `design-naming-cleanup-*.md` |

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

---

## What's Next

**Recommended Next Steps**:
1. Update README.md with new v2.0.0 command names and simplified naming conventions
2. Test the full design workflow end-to-end on a real project to validate naming changes
3. Test the spec-driven dev workflow on a real task
4. Consider a migration note if existing active plans need updating to the new template structure

**System Status**: ✅ **Production Ready**
- 5-stage design skill v2.0.0 (simplified naming: vision, roadmap)
- 3-stage dev skill with spec-driven plan workflow (full gap analysis complete)
- Design stage enhanced (Risk Profile, Constraints, Implementation Options, parallelization)
- Dev stage enhanced (Specification + AC steps, Deviation tracking, Review plan AC, LOC signal)
- Naming cleanup complete (product-vision -> vision, product-roadmap -> roadmap)
- Market research skill
- Video professor skill
- Skill reviewer skill
- 52/52 verify checks passing

---

## Latest Health Check

### 2026-02-24 - design-naming-cleanup Finalization
**Status**: ✅ On Track

**Context**:
Finalizing the design-naming-cleanup task which removed the redundant "product-" prefix from vision and roadmap naming across the design skill (CC + CD), updated ~135 cross-references across 38 files, and simplified the milestone-spec title format.

**Findings**:
- ✅ All 7 success criteria met -- zero stale references in any scoped directory
- ✅ 10 files renamed via git mv (6 CC, 4 CD), preserving git history
- ✅ ~135 occurrences updated across 38 files in both CC and CD environments
- ✅ Deploy script OLD_COMMANDS mechanism auto-cleans old command files
- ✅ 52/52 verify checks passing after deploy
- ✅ Root CLAUDE.md reflects new naming conventions throughout
- ✅ No scope drift -- task executed exactly as designed

**Challenges**:
- Context-sensitive replacements required file-by-file review (e.g., "Product Vision" as stage heading vs. lowercase "product vision" as generic concept)
- Plan occurrence counts were slightly off for one file (health-guide.md: planned 1, actual 2), but grep verification caught it

**Results**:
- ✅ All vision/roadmap naming simplified across design skill
- ✅ Milestone-spec title format changed from `# Milestone [Number]: [Name]` to `# [Milestone Name]`
- ✅ Old command files automatically cleaned from ~/.claude/commands/

**Lessons Learned**:
- Grep verification is the real acceptance check, not plan occurrence counts
- Deploy cleanup uses two mechanisms: wipe-first for skill dirs, OLD_COMMANDS for global commands dir

**Next**: Update README.md with simplified naming conventions. Test the full design workflow end-to-end on a real project.
