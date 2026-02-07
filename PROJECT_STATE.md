# Project State: idea-to-mvp

> **Last Updated**: 2026-02-07T11:01:18-0800

**idea-to-mvp** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 5-stage design workflow (synced with CD v2.0.0 naming) and 3-stage dev workflow. Ready for production use.

---

## Progress

### Milestone: Core Framework

| ID | Name | Type | Status | Docs |
|-----|------|------|--------|------|
| add-milestone-stage | Add Milestone Design Stage | feature | ✅ Complete | `add-milestone-stage-*.md` |
| cc-design-v2-upgrade | CC Design Skill v2.0 Upgrade | refactor | ✅ Complete | `cc-design-v2-upgrade-*.md` |

---

## Key Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-01-03 | 5-stage design workflow | Supports organic milestone growth with clear/unclear path distinction |
| 2026-01-03 | Environment split (CD vs CC) | Stages 1-2 in Claude Desktop for exploration, 3-5 in Claude Code for structure |
| 2026-01-26 | Rename dev-design to design, dev-cycle to dev | Cleaner naming conventions |
| 2026-02-07 | Sync CC design skill with CD v2.0.0 naming | Consistent naming across CC and CD, adopt content improvements (Testing Strategy, Feedback Loops, 200 Users First) |

---

## What's Next

**Recommended Next Steps**:
1. Update dev skill files that reference old design names (SKILL.md, references, commands, agents, templates)
2. Update README.md with new v2.0.0 command names
3. Test the full 5-stage design workflow end-to-end on a real project

**System Status**: ✅ **Production Ready**
- 5-stage design skill v2.0.0 (synced with CD naming)
- 3-stage dev skill (code allowed in stages 2-3)
- Market research skill
- Video professor skill
- 44/44 verify checks passing

---

## Latest Health Check

### 2026-02-07 - cc-design-v2-upgrade Finalization
**Status**: ✅ On Track

**Context**:
Finalizing the cc-design-v2-upgrade task which renamed and updated all CC design skill files to match CD v2.0.0 naming convention, adopting content improvements while preserving CC-specific content.

**Findings**:
- ✅ All 11 success criteria met for cc-design-v2-upgrade task
- ✅ 5 templates, 5 references, 5 commands renamed/updated with v2.0.0 names
- ✅ SKILL.md rewritten to v2.0.0 structure with CC-specific adaptations preserved
- ✅ CLAUDE.md fully updated with new names
- ✅ deploy.sh wipe-and-recopy pattern prevents stale files; 44/44 verify checks passing
- ✅ No dangling old-name references in design skill files (grep confirmed)

**Challenges**:
- deploy.sh originally used `cp -r` which would leave old-named files in deployed location after renames
- Resolved by adding wipe-and-recopy pattern (`rm -rf` + `mkdir -p` + `cp -r`) for templates and references directories

**Results**:
- ✅ CC design skill fully synced with CD v2.0.0 naming convention
- ✅ Content improvements adopted: Testing Strategy, Feedback Loops, "200 Users First" philosophy, Data Model/Security/Observability sections
- ✅ CC-specific content preserved: `docs/` prefix, `/verify-doc` refs, dev skill handoff, per-stage checklists

**Lessons Learned**:
- Wipe-and-recopy pattern ensures deployed directories mirror source after renames
- CC-specific content lives in commands and SKILL.md, not templates/references
- OLD_COMMANDS arrays in deploy.sh and verify.sh must be manually kept in sync

**Next**: Update dev skill files that reference old design names (north-star, poc-design, milestone-design, milestones-overview) in a follow-up task.
