# Project State: Anvil

> **Last Updated**: 2026-05-27T16:18:26-0700

**Anvil** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 4 Anvil skills (design, dev, research, review). Dev skill now carries Stage 0 (optional Goal doc) wired into the live workflow via `/dev-goal` command, SKILL.md registration, anvil `CLAUDE.md` registration, and downstream goal-doc awareness across 4 guides + 4 agents + 1-design template. Soft-reference policy preserves backwards-compat. Verify pass count: 75/75 (was 74; +1 for new REQUIRED_COMMANDS allowlist entry). Marketing milestone 1/6 tasks complete.

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
| goal-doc | Stage 0 Goal-Doc Integration (/dev-goal + SKILL.md + CLAUDE.md + 4 downstream guides/agents + 1-design template) | feature | ✅ Complete (Step 8 operator smoke ⏸ operator gate) | `core-goal-doc-*.md` |

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
| 2026-05-27 | Wire Stage 0 (Goal doc, optional) into dev skill — `/dev-goal` command, SKILL.md/CLAUDE.md registration, downstream awareness across 4 guides/agents/1-design template | Stage 0 guide + template existed but the dev skill was unaware of them — no command surface, no SKILL.md mention, no downstream alignment. Soft-reference policy (read-if-present, never fail-if-absent) preserves backwards-compat for tasks that skip Stage 0. No spawn variant by design — Stage 0's defining work is operator collaboration, which spawn-mode subagents cannot do well. Optional REQUIRED_COMMANDS verify-script tightening applied + pair-synced for regression-catching parity with other entry-point commands. |

---

## What's Next

**Recommended Next Steps**:
1. **Operator action (core-goal-doc Step 8)**: Run the operator-driven end-to-end smoke in main conversation: `/dev-goal "core-test-goal: ..."` → confirm operator-confirmation prompts → `/dev-design --notes "core-test-goal: ..."` → verify `docs/core-test-goal-design.md` Purpose blockquote cites the goal doc. Teardown: keep for inspection or `rm docs/core-test-goal-*.md`.
2. **Operator action (core-design-4stage Step 10)**: When ready, run `cd claude-code && ./deploy-genesis.sh && ./verify-genesis.sh` to propagate the 5→4 refactor + new Stage 0 to genesis. Per CLAUDE.md, genesis deploy is a separate manual action.
3. **Follow-up task**: Update `claude-code/README.md` to 4-stage vocabulary (4 hits) + mention Stage 0 (optional). Out-of-scope for prior tasks; recommend small follow-up.
4. **Operator action (core-review-walkthrough)**: Run `/walkthrough docs/core-review-walkthrough-design.md` in a fresh Claude Code session; confirm first unit renders five angles, `stop` ends cleanly, `git diff` returns empty. Final smoke-test gate.
5. **Follow-ups from core-goal-doc Open Questions**: review-skill recognition of goal docs, `/dev-finalize` audit of goal-doc → results alignment, design-skill auto-suggest heuristic.
6. Begin Distribution Listings task (awesome list PRs, SkillsMP indexing).
7. Begin LinkedIn Launch task (profile optimization, first posts).

**System Status**: ✅ **Production Ready + 4-Stage Design + Stage 0 Goal Doc + Auto Loops + Walkthrough**
- 4 Anvil skills: design, dev, research, review
- **4-stage design skill** (vision, architecture, milestones, tasks) with formal two-rule naming convention (`[project-slug]-*` vs `[milestone-slug]-*`)
- **Dev skill now carries optional Stage 0** (Goal doc) via `/dev-goal` command (main-conversation only, no spawn variant), wired into SKILL.md (6 edit sites), anvil `CLAUDE.md` (4 sites), and downstream awareness across 4 guides + 4 agents + 1-design template (soft-reference policy preserves backwards-compat)
- 3-stage dev skill body (Design / Plan / Execute) with spec-driven plan workflow and sub-step support; 8 cross-refs normalized to `[milestone-slug]-tasks.md`
- review skill: persistent review tracking with per-item history, --auto support, step scope check with split suggestions, parallel + sequential doc review, skill auditing, paired tick-driven review loops (`/review-doc-run-loop` + `/exam-loop`), operator-facing `/walkthrough` for pedagogical per-unit elaboration, additive 4-stage doc-type recognition alongside legacy 5-stage support
- review-loop-guide.md owns all loop mechanics (parser, roles, gates, tick loop, echo state, termination, tuning) as single source of truth
- walkthrough-guide.md owns five-angle elaboration rules, three-tier adaptive vocabulary, unit extraction depth detection, per-unit advance semantics
- All agents use bare role names, all forked commands use /spawn-* prefix
- research/ skill consolidates market-research and naming-research
- Marketing milestone 1/6 tasks complete (GitHub Presence)
- **Deployed commands**: 43 (was 42; +1 `/dev-goal`), 16 agents, **75/75 verify checks passing** (was 74; +1 REQUIRED_COMMANDS allowlist entry for `dev-goal.md`)

---

## Latest Health Check

### 2026-05-27 - core-goal-doc Finalization
**Status**: ✅ On Track (structural + deploy/verify green on local; Step 8 operator-driven end-to-end smoke deferred to operator per Stage 0's main-conversation-only contract)

**Context**:
Finalizing the core-goal-doc task — wired the existing Stage 0 guide (`0-goal-guide.md`) and template (`0-goal.md`) into the live dev workflow as an optional opt-in stage. Step 1 created the `/dev-goal` command (main-conversation only, no spawn variant by design); Step 2 integrated Stage 0 into SKILL.md across six edit sites and removed the stale "Integration gap" paragraph from `0-goal-guide.md`; Step 3 registered Stage 0 in anvil's `CLAUDE.md` across four sites; Steps 4-7 added soft "read-if-present" goal-doc awareness to the four downstream guides (1-design, 2-planning, 3-execution, review) + four agents (designer, planner, executor, reviewer) + `1-design.md` template's Purpose blockquote; Step 8 applied the optional REQUIRED_COMMANDS verify-script tightening (pair-synced local + genesis), ran the backwards-compat sweep, and paused for operator-driven end-to-end smoke per Stage 0's no-spawn contract.

**Findings**:
- ✅ Alignment: Stage 0 closes a long-standing dual-audience contract gap (operator confirms direction; downstream agents read goal doc as alignment context). The guide + template existed but the skill was unaware of them — Step 0 baseline (74 checks) confirmed clean starting state; final 75 checks (added REQUIRED_COMMANDS entry for dev-goal.md) confirms the new entry-point command has the same loud-failure regression-catch as the other four entry-point commands. Soft-reference policy preserves backwards-compat: any task that skips Stage 0 continues unchanged through Stages 1/2/3.
- ✅ Production: All edits land on production surfaces (`/dev-goal` command, SKILL.md, anvil CLAUDE.md, 4 downstream guides, 4 downstream agents, 1-design template, both verify scripts). `deploy.sh && verify.sh` on local: exit 0 with `✅ Passed: 75 ❌ Failed: 0`. Auto-discovery (deploy.sh:163-170 `cp -r commands/*.md`) handled `/dev-goal` deployment without any deploy-script edit; safety verified via `grep "dev-goal.md" deploy.sh deploy-genesis.sh` returning 0 matches.
- ✅ Gap: Step 8's operator-driven end-to-end smoke deferred per Stage 0's defining contract — the command body explicitly states "Run in main conversation. Do NOT spawn a subagent or fork." An executor agent CAN'T legitimately drive the smoke without bypassing the operator-confirmation step that makes the smoke meaningful. All 10 executor-side ACs pass; the operator-procedural smoke is the final gate.
- ✅ Scope: 8 steps executed per plan, no scope creep. All four downstream awareness slices (Steps 4-7) are placement-disambiguated to match each target file's existing semantic-section inventory (Critical Rules vs end-of-Process vs end-of-Scope) rather than forcing cross-step structural symmetry. The "If absent" backwards-compat anchor is present in all 4 downstream guides (each in file-appropriate phrasing); the load-bearing regex `If no goal doc exists|If absent` accepts both forms.
- ✅ Complexity: Proportionate. The integration touches exactly the surfaces named in the plan's scope-boundary line. No abstractions, no wrappers, no premature generalization — just structural edits to existing files plus one new command file. The optional REQUIRED_COMMANDS tightening (1 line × 2 files) was applied with documented rationale rather than silently deferred.
- ✅ Tests: N/A for runtime — Stage 0 integration is structural (commands, templates, guides, agents). Verification is deploy+verify+grep-anchor based. All 10 executor-side ACs auto-verified; `grep`-based structural assertions cover SKILL.md anchors (8 matches), CLAUDE.md anchors (3 matches), 0-goal-guide.md Integration-gap removal (0 matches), 1-design.md template Goal doc citation (1 match), 4 downstream guides with goal-doc subsection/alignment bullet, 4 downstream agents with literal goal-doc path. Pair-sync verified via array-region `sed` extraction (correcting the plan's looser `grep -A 10` form documented in Step 8 Issues).

**Challenges**:
- Plan-internal AC pattern vs edit-spec mismatch (Step 3): AC literal pattern `grep "0-goal\.md"` expected 2+ matches, but only edit site #3 (templates) uses the literal `0-goal.md` filename — edit site #2 uses the path-placeholder form `[task-slug]-goal.md`. Resolved by verifying intent via broader regex `grep -E "goal\.md"` returning 2 matches at expected lines, documenting the AC-vs-spec mismatch in Issues for future plan tightening.
- Placement disambiguation across four agent files with different section inventories (Steps 4-7): `dev-designer.md` and `dev-executor.md` have `## Critical Rules`; `dev-planner.md` doesn't; `dev-reviewer.md` doesn't either but has `## Scope`. Forcing uniform placement would either fabricate sections or jam constraints into wrong places. Resolved by matching each file's existing semantic-section inventory and documenting the placement pattern across all four steps.
- Pair-sync verification command in plan (Step 8) used `diff <(grep -A 10 REQUIRED_COMMANDS verify.sh) <(grep -A 10 …)` which matches multiple sites (array declaration + consumer loop) and legitimately differs at the consumer site (local vs SSH). Resolved by using `sed -n '/^REQUIRED_COMMANDS=(/,/^)/p'` for exact array-region extraction; that diff is empty, confirming pair-sync at the binding-invariant abstraction level.

**Results**:
- ✅ `/dev-goal` command created, deployed (`~/.claude/commands/dev-goal.md`), and registered in REQUIRED_COMMANDS allowlist for regression-catching parity
- ✅ SKILL.md carries Stage 0 across six edit sites (Quick Reference Input/Output table, Quick Reference Guide/Template table, Optional Commands list, dedicated Stage 0 H2 section, State Detection list, File Naming Conventions)
- ✅ Anvil `CLAUDE.md` registers Stage 0 across four sites (dev commands, dev-skill-creates file list, templates, references) — no spawn variant entry
- ✅ `0-goal-guide.md` stale "Integration gap" paragraph removed; replaced by concise navigational bullet matching the cross-references section's existing pattern
- ✅ Downstream goal-doc awareness present in all 4 guides (1-design, 2-planning, 3-execution, review) with file-appropriate "If absent" anchor and all 4 agents (designer, planner, executor, reviewer) with literal goal-doc path
- ✅ `1-design.md` template's Purpose blockquote carries `> **Goal doc**: docs/[milestone-slug]-[task-slug]-goal.md` citation (conditionally emitted by dev-designer.md per goal-doc presence — no orphan citation when absent)
- ✅ Optional verify-script tightening applied: `REQUIRED_COMMANDS` array gained `dev-goal.md` in both `verify.sh` and `verify-genesis.sh`; pair-sync verified via array-region `sed` extraction
- ✅ Local deploy + verify: 75/75 checks passing (was 74; +1 for new REQUIRED_COMMANDS entry); deploy scripts untouched (auto-discovery preserved)
- ⏸ End-to-end operator-driven smoke (`/dev-goal "core-test-goal: ..."` → `/dev-design --notes "..."` → verify Purpose blockquote citation) deferred to operator per Stage 0's main-conversation-only contract

**Lessons Learned**:
- Auto-discovery in `deploy.sh` (`cp -r commands/*.md`) makes adding a new command a single-file source-side change; `OLD_COMMANDS` is a footgun — adding a still-live command DELETES it on every deploy.
- Conditional-emission templates need agent-side instructions to be load-bearing — without explicit strip-on-absence in the agent spec, the template line becomes an orphan citation pointing to a nonexistent file.
- Placement is driven by target-file structure, not cross-step symmetry — match each file's existing semantic-section inventory rather than forcing uniformity that distorts file structure.
- Stage 0's operator-pause is a deliberate contract, not a deferral — when a command body forbids spawning, any end-to-end smoke of that command MUST be operator-driven, not executor-driven.
- `grep -A N` cuts across multiple match sites in scripts with repeated patterns — prefer `sed` range-extraction for pair-sync verification.
- REQUIRED_COMMANDS is a deploy-regression catch-net, not just a count check — every operator-facing entry-point command should appear there.
- Anchored greps catch structural drift that bare greps miss — `grep -E '^> \*\*Goal doc\*\*'` confirms the line is INSIDE the blockquote.

**Next**: Operator runs end-to-end smoke in main conversation (`/dev-goal "core-test-goal: ..."` → operator-confirmation → `/dev-design --notes "..."` → verify goal-doc citation in produced design). Then optionally trigger genesis deploy + verify (separate manual step per anvil's `CLAUDE.md`). Unrelated operator gates still pending: core-design-4stage Step 10 genesis deploy, core-review-walkthrough live smoke test.
