# Project State: Anvil

> **Last Updated**: 2026-05-29T20:29:53-0700

**Anvil** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 4 Anvil skills (design, dev, research, review). Dev skill now carries an optional readiness-gate layer — one state-aware `/dev-ready` command resolves the furthest-along dev-stage break, binds one of five gate profiles (G1–G5) onto a shared inline 7-step flow, and emits a bounded READY / NOT-READY decision (additive-only; no existing stage logic touched). Stage 0 (optional Goal doc) remains wired via `/dev-goal`. Verify pass count: 76/76 (was 75; +1 for `dev-ready.md` REQUIRED_COMMANDS allowlist entry). Marketing milestone 1/6 tasks complete.

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
| dev-ready | Readiness-Gate Layer (`/dev-ready` + base flow + 5 gate profiles G1–G5 + SKILL.md + 6 hand-off pointers) | feature | ✅ Complete | `core-dev-ready-*.md` |

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
| 2026-05-29 | Add a readiness-gate layer: one state-aware `/dev-ready` over a shared inline flow + 5 gate profiles (G1–G5), additive-only | A directed, bounded readiness check at each dev-stage break catches the failure modes (spike-leaks-into-plan-as-a-step, mid-step operator gates, finding dumps) the existing stages don't gate. One base `ready-guide.md` owns the invariant 7-step flow + 5 leashes + profile schema; each gate is one profile filling four slots (rubric / inputs / verdict / remedy classes) — adding or retuning a gate edits one file, zero new machinery. Five leashes (givens preamble, scope fence, fixed rubric, bias-to-READY, minimal-diff output) keep the decision bounded and default-to-READY, avoiding the "dud" reviewer's harness-flagging / re-architecture sprawl. Inline-only by construction (one agent, one context) — no Workflow-primitive or sub-agent dependency. Integration is additive across 7 existing files (line-level `git diff` 0 deletions) + 6 hand-off pointer sites; `dev-ready.md` added to REQUIRED_COMMANDS (verify 76/0). |

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

**System Status**: ✅ **Production Ready + 4-Stage Design + Stage 0 Goal Doc + Readiness Gates + Auto Loops + Walkthrough**
- 4 Anvil skills: design, dev, research, review
- **4-stage design skill** (vision, architecture, milestones, tasks) with formal two-rule naming convention (`[project-slug]-*` vs `[milestone-slug]-*`)
- **Dev skill now carries optional Stage 0** (Goal doc) via `/dev-goal` command (main-conversation only, no spawn variant), wired into SKILL.md (6 edit sites), anvil `CLAUDE.md` (4 sites), and downstream awareness across 4 guides + 4 agents + 1-design template (soft-reference policy preserves backwards-compat)
- **Dev skill now carries an optional readiness-gate layer**: one state-aware `/dev-ready [gate]` command resolves the furthest-along dev-stage break, binds one of five gate profiles (`assets/ready/g1.md … g5.md`) onto the shared inline 7-step flow in `references/ready-guide.md`, and emits a bounded READY / NOT-READY decision (5 leashes: givens preamble, scope fence, fixed rubric, bias-to-READY, minimal-diff output). Inline-only (no sub-agents / no Workflow primitive); additive across 7 existing files + 6 hand-off pointer sites; G1 at goal break, G2/G3 at design, G4/G5 at plan
- 3-stage dev skill body (Design / Plan / Execute) with spec-driven plan workflow and sub-step support; 8 cross-refs normalized to `[milestone-slug]-tasks.md`
- review skill: persistent review tracking with per-item history, --auto support, step scope check with split suggestions, parallel + sequential doc review, skill auditing, paired tick-driven review loops (`/review-doc-run-loop` + `/exam-loop`), operator-facing `/walkthrough` for pedagogical per-unit elaboration, additive 4-stage doc-type recognition alongside legacy 5-stage support
- review-loop-guide.md owns all loop mechanics (parser, roles, gates, tick loop, echo state, termination, tuning) as single source of truth
- walkthrough-guide.md owns five-angle elaboration rules, three-tier adaptive vocabulary, unit extraction depth detection, per-unit advance semantics
- All agents use bare role names, all forked commands use /spawn-* prefix
- research/ skill consolidates market-research and naming-research
- Marketing milestone 1/6 tasks complete (GitHub Presence)
- **Deployed commands**: 44 (was 43; +1 `/dev-ready`), 16 agents, **76/76 verify checks passing** (was 75; +1 REQUIRED_COMMANDS allowlist entry for `dev-ready.md`)

---

## Latest Health Check

### 2026-05-29T20:29:53-0700 - core-dev-ready Finalization
**Status**: ✅ On Track (structural deploy/verify green on local at 76/0; additive-only proven line-level across all 7 edited files; behavioral gate runs all produced bounded decisions of the correct shape)

**Context**:
Finalizing the core-dev-ready task — built an additive readiness-gate layer over the existing dev workflow. One state-aware `/dev-ready [gate]` command resolves the furthest-along dev-stage break and binds one of five gate profiles (G1–G5) onto a shared inline 7-step flow, emitting a bounded READY / NOT-READY decision. Step 1 authored the base `references/ready-guide.md` (invariant flow + 5 leashes + profile schema + dud anti-pattern); Step 2 authored the G4 profile and validated the flow inline on a real in-repo plan; Step 3 authored the other four profiles (G1/G2/G3/G5) on the proven base; Step 4 authored the thin `commands/dev-ready.md` dispatcher; Step 5 integrated `SKILL.md` additively (Readiness Gates section + State Detection wiring + Optional Commands entry); Step 6 added the six `/dev-ready` hand-off pointers (3 command After-Completion + 3 guide Next-Stage, G1's two sections created); Step 7 deployed, verified clean (76/0), and ran three behavioral validations + the no-Workflow invariant.

**Findings**:
- ✅ Alignment: The layer fills a genuine workflow gap — a directed, bounded readiness check at each stage break catches failure modes (spike-leaks-into-plan-as-a-step, mid-step operator gates, finding dumps) the existing stages don't gate. It rides on the existing artifact ladder / State Detection signals rather than re-architecting any stage, so it complements Stage 0 (Goal doc) and the design/plan/execute stages without disturbing them.
- ✅ Production: Real production surfaces only (`/dev-ready` command, `ready-guide.md`, 5 profiles under `assets/ready/`, SKILL.md, 3 stage commands, 3 stage guides, both verify scripts). `deploy.sh && verify.sh` → exit 0, **76/0**, `dev-ready.md` present in the command allowlist. No mocks; the gate is exercised inline on genuine artifacts.
- ✅ Gap: The task is a prose/skill build with no code test framework — acceptance is structural (`verify.sh`) + line-level additive-only (`git diff '^-'`) + behavioral (gate decision shape). All three behavioral runs (dogfood G2 READY, autonomy-catch G4 NOT-READY naming the spike step, bias-to-READY G4 READY) produced bounded decisions of the correct shape; the no-Workflow invariant held (every run inline, no sub-agents, no Workflow primitive). No deferred operator gate for this task.
- ✅ Scope: 8 steps (0–7) executed per plan, no scope creep. The five profiles vary in exactly four slots (rubric / inputs / verdict / remedy classes) and nothing structural; only sanctioned extensions present (G3's archive/don't-plan remedy override, G5's end-to-end vs G4's per-step autonomy depth). Integration touched only the named surfaces; no review-skill file touched.
- ✅ Complexity: Proportionate and notably lean. One base flow + 5 thin profiles + 1 thin dispatcher — adding or retuning a gate edits one profile file with zero new machinery. Profiles reference the base rather than restating it (verified 0 flow-step restatements), so drift is structurally impossible. No abstractions, wrappers, or premature generalization.
- ✅ Tests: N/A for runtime (prose/skill task). Structural verification clean at 76/0 (was 75; +1 for the `dev-ready.md` REQUIRED_COMMANDS allowlist entry, pair-synced local + genesis). Additive-only proven at the line level (`git diff <7 files> | grep '^-' | grep -v '^---'` → empty, 0 deletions).

**Challenges**:
- Negated-term verification (Steps 1, 4): a correct guide/dispatcher MUST mention "fan-out"/"sub-agent" to negate them and to reference the dud anti-pattern, so a bare absence-grep would falsely flag a correct file. Resolved by reading each occurrence in context — every hit is a negation or dud reference, none prescribes fan-out as the execution model.
- Additive-only proof vs `--stat`: `--stat` reports net insertions and can mask an in-place line change. Resolved by treating the line-level `git diff '^-' | grep -v '^---'` (0 deletions) as the load-bearing proof, with `--stat` only as a supplementary signal.
- Section-anchor drift: the plan referenced line numbers (e.g. State-Detection line 179, guide lines 276/317) that shift as content is inserted. Resolved by anchoring all edits to headings (`awk '/## State Detection/…'`, `## Next Stage`) — the durable anchors the plan's own residuals flagged.

**Results**:
- ✅ `references/ready-guide.md` — the shared base: 7-step flow (only step 2 parameterized), 5 named leashes, profile schema (required + tunable slots, no weight slot), furthest-along resolution rule + `<gate>` override, PROPOSE-only / inline-only contracts, dud anti-pattern as a leash→failure-mode table
- ✅ Five gate profiles `assets/ready/{g1,g2,g3,g4,g5}.md` — each fills the schema, references the base (0 flow restatements), carries the design-table verdict; G3 extends remedy classes (archive/don't-plan), G5 runs the end-to-end autonomy pass
- ✅ `commands/dev-ready.md` — thin state-aware dispatcher (resolve break → bind profile → run inline), valid frontmatter (`argument-hint: [gate]`, `disable-model-invocation: true`), no spawn/fan-out instruction
- ✅ `SKILL.md` integrated additively (33 insertions, 0 deletions): Readiness Gates section (G1–G5 + resolution rule + bounded/inline contract), State Detection wired to gate resolution, `/dev-ready` in Optional Commands
- ✅ Six hand-off `/dev-ready` pointers (3 command After-Completion + 3 guide Next-Stage); G1's two sections created additively at their doc tails; 20 insertions / 0 deletions across the six
- ✅ Deploy + verify clean: 76/0, `dev-ready.md` present; `dev-ready.md` added to REQUIRED_COMMANDS in both `verify.sh` and `verify-genesis.sh` (pair-synced)
- ✅ Behavioral validation: dogfood G2 READY (no given flagged, no re-architecture), autonomy-catch G4 NOT-READY (named the spike-as-step, 2-item action list), bias-to-READY G4 READY (nit—proceed), no-Workflow invariant holds

**Lessons Learned**:
- Context-grep, not absence-grep, verifies negated terms — a correct file MUST mention "fan-out"/"sub-agent" to negate them; verification is "not prescribed as the mechanism," read in context.
- Line-level `git diff '^-'` is the additive-only proof; `--stat` (net insertions) can mask an in-place change and is only a supplementary signal.
- Anchor edits by heading, never by line number — line numbers shift as content is inserted; heading-scoped anchors stay correct after sections move.
- Profiles stay drift-proof by referencing the base, not restating it — a profile physically cannot diverge from a flow it never re-authors.
- Gate depth tracks inputs, not a weight knob — G1–G3 light smell test, G4 per-step verdict, G5 end-to-end chain pass; each written at the depth its inputs justify.
- The no-Workflow invariant holds by construction (inline one-context flow), not by a runtime check that could regress.

**Next**: Optionally run `/dev-review-run docs/core-dev-ready-plan.md` for the conceptual Stage 3b review (off by default). Genesis deploy (`./deploy-genesis.sh && ./verify-genesis.sh`) remains a separate manual operator action per `CLAUDE.md`, now also carrying core-design-4stage Step 10 + the new `dev-ready.md`. Unrelated operator gates still pending: core-goal-doc Step 8 end-to-end smoke, core-review-walkthrough live smoke test.
