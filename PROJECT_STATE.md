# Project State: Anvil

> **Last Updated**: 2026-06-10T17:29:38-0700

**Anvil** is a structured workflow for taking ideas from concept to working product, supporting both Claude Code (implementation) and Claude Desktop (design & research).

**Current Status**: Skills framework v2.0.0 with 4 Anvil skills (design, dev, research, review). Latest: `/review-triangulate` gained a conditional, gate-controlled **empirical-probe lane class** — execute-but-don't-write subagents that demonstrate runtime behavior instead of citing it, governed by a per-run applicability gate (`probes: in-play / spot-check / N/A / upgraded-in-play`) so a gate-closed (pure-prose) run is behaviorally byte-equivalent to today; new hard rule 5 ("demonstration outranks citation") gives probe verdicts standing over citations for runtime-behavior conflicts. Dev skill's optional Stage 0 is a Cockburn-style **usecases doc** (`/dev-usecases`, 3 modes, replacing `/dev-goal`) and carries the optional readiness-gate layer (`/dev-ready`, G1–G5). Verify pass count: 79/79. Marketing milestone 1/6 tasks complete.

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
| dev-usecases | Stage-0 Goal-Doc → Usecases-Doc Cutover (`/dev-usecases` 3 modes + `0-usecases` guide/template + SKILL.md + `/dev-ready` G1 re-anchor + 10 pipeline soft-refs + CLAUDE.md/exam/walkthrough + deploy plumbing) | refactor | ✅ Complete (genesis deploy ⏸ operator gate) | `core-dev-usecases-*.md` |
| review-triangulate-probe-lanes | Conditional Empirical-Probe Lane Class for `/review-triangulate` (gate-controlled execute-but-don't-write lanes + 4 verdicts + rule 5 + 3 probe lanes + probeFindings/convergence weighting + registrations) | feature | ✅ Complete (gate-open live validation ⏸ operator gate) | `core-review-triangulate-probe-lanes-*.md` |

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
| 2026-06-10 | Add a gate-controlled empirical-probe lane class to `/review-triangulate` (execute-but-don't-write, conditional on a per-run applicability gate) | The three citation lanes (grounding/path/adversarial) can argue *about* runtime behavior but cannot *demonstrate* it. A fourth lane class runs non-destructive probes (scratch only under `/tmp/<slug>-probes/`, no repo/tool/config/state mutation) and reports literal command output, with new hard rule 5 ("demonstration outranks citation") giving probe verdicts standing over citations for runtime-behavior conflicts. Every probe addition is conditional on a per-run gate record (`probes: in-play / spot-check / N/A / upgraded-in-play`) set by a TESTABLE-vs-CITE-ONLY classification at the Phase-1 read — so a gate-closed (pure-prose) run spawns the original three lanes with zero probe vocabulary in any prompt, behaviorally byte-equivalent to today. Read-only discipline narrows (not deletes) to the citation lanes; the orchestrator-run spot-check is exempt because rule 1 binds Agent prompts, not the orchestrator. Probe evidence survives compaction via a single `probeFindings` key + the anchor (c) runbook; convergence weighting annotates (never deletes) the overruled citation lane. Deploy 79/79, deployed command byte-identical to source; gate-open live validation deferred to operator. |
| 2026-06-10 | Hard-cutover dev Stage 0 from the goal doc to a Cockburn-style usecases doc (no alias, `usecases` one word) | The goal doc captured *value/intent* but not *externally observable behavior*; a use-case-structured doc (goals-at-a-glance + real-artifact anchor + main success scenarios + extensions + one-sentence contract) subsumes the goal layer AND gives downstream stages a behavior spec + a runnable vocabulary-parity/cohesion contract against the design. Hard cutover (no compat glob) keeps the pipeline single-shaped: `/dev-goal` → `/dev-usecases` (3 modes incl. legacy conversion), `0-goal{,-guide}.md` → `0-usecases{,-guide}.md`, `/dev-ready` G1 re-anchored (rubric unchanged at 3 items — re-anchor only, no scope growth), legacy `-goal.md` rejected with a convert hint. The guide absorbs the architect teaching entry so the method has a durable in-repo home (the exemplar is project-specific and lives outside the repo). Residue sweep fully allowlisted line-by-line (the `-goal` pattern fires word-internally on legitimate new vocabulary like `user-goal-level`/`actor-goal`). Verify 79/79; deploy plumbing pair-synced local+genesis (genesis run deferred to operator). |

---

## What's Next

**Recommended Next Steps**:
1. **Dogfood (core-dev-usecases)**: Run `/dev-usecases core-review-triangulate-probe-lanes` (mode 3 — design exists) as the new command's first real run; confirm the goals-at-a-glance table, real-artifact anchor, use-case sections, and parity/cohesion pass against the existing design.
2. **Operator action (genesis deploy)**: When ready, run `cd claude-code && ./deploy-genesis.sh && ./verify-genesis.sh` to propagate the Stage-0 usecases cutover (+ the still-pending core-design-4stage Step 10 5→4 refactor) to genesis. Deploy plumbing is pair-synced and edited but NOT run; per CLAUDE.md, genesis deploy is a separate manual action.
3. **Follow-up task**: Update `claude-code/README.md` to 4-stage vocabulary (4 hits) + mention Stage 0 usecases (optional). Out-of-scope for prior tasks; recommend small follow-up.
4. **Operator action (core-review-walkthrough)**: Run `/walkthrough docs/core-review-walkthrough-design.md` in a fresh Claude Code session; confirm first unit renders five angles, `stop` ends cleanly, `git diff` returns empty. Final smoke-test gate.
5. Begin Distribution Listings task (awesome list PRs, SkillsMP indexing).
6. Begin LinkedIn Launch task (profile optimization, first posts).

**System Status**: ✅ **Production Ready + 4-Stage Design + Stage 0 Usecases Doc + Readiness Gates + Auto Loops + Walkthrough**
- 4 Anvil skills: design, dev, research, review
- **4-stage design skill** (vision, architecture, milestones, tasks) with formal two-rule naming convention (`[project-slug]-*` vs `[milestone-slug]-*`)
- **Dev skill now carries optional Stage 0 as a Cockburn-style usecases doc** (replacing the goal doc) via `/dev-usecases` command (main-conversation only, no spawn variant; 3 modes — before-design notes walk, existing-doc update / legacy goal-doc conversion, after-design distillation). Wired into SKILL.md (7 sections), anvil `CLAUDE.md` (4 sites), `/dev-ready` G1 (re-anchored, rubric unchanged), and downstream awareness across 4 guides + 4 agents + 1-design/2-plan templates (soft-reference policy preserves backwards-compat; legacy `-goal.md` docs inert + opt-in convertible)
- **Dev skill now carries an optional readiness-gate layer**: one state-aware `/dev-ready [gate]` command resolves the furthest-along dev-stage break, binds one of five gate profiles (`assets/ready/g1.md … g5.md`) onto the shared inline 7-step flow in `references/ready-guide.md`, and emits a bounded READY / NOT-READY decision (5 leashes: givens preamble, scope fence, fixed rubric, bias-to-READY, minimal-diff output). Inline-only (no sub-agents / no Workflow primitive); additive across 7 existing files + 6 hand-off pointer sites; G1 at the usecases break, G2/G3 at design, G4/G5 at plan
- 3-stage dev skill body (Design / Plan / Execute) with spec-driven plan workflow and sub-step support; 8 cross-refs normalized to `[milestone-slug]-tasks.md`
- review skill: persistent review tracking with per-item history, --auto support, step scope check with split suggestions, parallel + sequential doc review, skill auditing, paired tick-driven review loops (`/review-doc-run-loop` + `/exam-loop`), operator-facing `/walkthrough` for pedagogical per-unit elaboration, additive 4-stage doc-type recognition alongside legacy 5-stage support
- review-loop-guide.md owns all loop mechanics (parser, roles, gates, tick loop, echo state, termination, tuning) as single source of truth
- walkthrough-guide.md owns five-angle elaboration rules, three-tier adaptive vocabulary, unit extraction depth detection, per-unit advance semantics
- All agents use bare role names, all forked commands use /spawn-* prefix
- research/ skill consolidates market-research and naming-research
- Marketing milestone 1/6 tasks complete (GitHub Presence)
- **Deployed commands**: 44 (`/dev-goal` retired, `/dev-usecases` added — count-neutral), 16 agents, **79/79 verify checks passing** (was 76; deployed-command checks + REQUIRED_COMMANDS swap `dev-goal.md` → `dev-usecases.md` and `dev-goal.md` added to OLD_COMMANDS)

---

## Latest Health Check

### 2026-06-10T17:29:38-0700 - core-review-triangulate-probe-lanes Finalization
**Status**: ✅ On Track (all 7 implementation steps complete; deploy 79/79 with deployed command byte-identical to source; gate-closed behavior proven unchanged by full-file read + gate-conditionality of every probe addition; only operator-run gate-open live validation remains)

**Context**:
Finalizing core-review-triangulate-probe-lanes — adding a conditional, gate-controlled "empirical probe" lane class to `/review-triangulate` (execute-but-don't-write subagents that demonstrate runtime behavior instead of citing it) while keeping read-only discipline intact for every existing lane and keeping gate-closed (pure-prose) runs behaviorally byte-equivalent to today. 7 steps, all on one command file plus two registration files: Step 1 legalized the lane class (hard rule 1 carve-out, rule 4 third evidence type, new rule 5 "demonstration outranks citation"); Step 2 added the per-run applicability gate (TESTABLE-vs-CITE-ONLY Phase-1 classification + four-state `probes:` record + upgrade rule); Step 3 authored the first-order **Empirical probe / doubt-removal** entry (the single probe contract: 4 verdicts, ≤3-iteration rule, permission-block handling, verbatim safety block, scratch lifecycle); Step 4 added the two second-order probe lanes (Probe-the-fix, Probe-the-contradiction) + workflow-completion handoff + intro-parenthetical fix; Step 5 made probe evidence survive compaction (`probeFindings` schema + anchor (c) runbook) and mechanical at consolidation (convergence weighting, residual reporting, spot-check sanction); Step 6 updated discoverability (frontmatter + intro) and both registrations (SKILL.md, CLAUDE.md); Step 7 deployed + verified + ran the self-consistency sweep.

**Findings**:
- ✅ Alignment: Fills a real gap in `/review-triangulate` — the three citation lanes can argue *about* runtime behavior but cannot *demonstrate* it. The probe class settles runtime-behavior doubts the citation lanes can only debate, with hard rule 5 giving probe verdicts standing over citations. Consistent with the review skill's existing thin-command + parallel-subagent architecture.
- ✅ Production: Real production surfaces only — the live `review-triangulate.md` command + `review/SKILL.md` + `CLAUDE.md` registrations. `./deploy.sh && ./verify.sh` → **79/79, 0 failures**; `cmp` of deployed command vs source → silent (byte-identical). No mocks.
- ✅ Gap: One claim static validation cannot settle — a background probe lane executing end-to-end through the harness permission layer (gate-open path) — is explicitly deferred to operator-run live validation per plan Next Steps. Negative-path (mutation-only question → UNTESTABLE, never run) also operator-verified.
- ✅ Scope: 7 steps executed per plan, no scope creep. Every probe addition is conditional on the gate record; read-only discipline narrows (not deletes) to the citation lanes. The `:64`→`:89` intro parenthetical was pulled forward into Step 4 (it becomes factually wrong the moment the probe lanes land) — a documented, justified placement, not drift.
- ✅ Complexity: Proportionate. One probe contract defined exactly once (first-order entry); both second-order lanes and the Phase-3 spot-check reference it by name rather than restating. One `probeFindings` key holds all probe evidence. No new machinery — the gate is a recorded string, the lanes reuse the existing Agent-prompt + convergence-map mechanics.
- ✅ Tests: N/A for runtime (prompt-layer docs task — no test framework). Acceptance is structural: verify 79/0, byte-identity `cmp`, self-consistency sweep (uniform verdict casing, `probes:` spacing, `/tmp/<slug>-probes/` path, four distinct gate states, awk-scoped hard-rules count = 5), clean registration grep, and a full end-to-end file read confirming every probe mention traces to rule 1/4/5 and the gate-closed path text is unaltered. Re-confirmed at finalize: deployed command byte-identical, hard-rules count = 5.

**Challenges**:
- Anchor drift within a single-pass multi-step edit: every insertion shifted later line anchors (the design's `:64` parenthetical had moved to `:89` by Step 4). Resolved by anchoring every edit to a stable text phrase, not a line number — exactly the drift Prerequisite 2 warned about.
- Self-tripping invariant greps: the `^[1-5]\. ` hard-rule pattern also matches Phase-1/Phase-3 numbered steps, and the verdict-casing grep matches UNDEMONSTRATED as a substring of "demonstrated". Resolved with `awk`-scoped range bounding for the rule count and inspect-every-hit case-insensitive scanning for verdicts.
- Read-only discipline relaxation without weakening it: rule 1 had to permit probe scratch writes while keeping the citation lanes strictly read-only. Resolved by an allowlist framing (who STILL carries the read-only opener) + scoping read-only to "tracked files" + an orchestrator-not-bound note for the inline spot-check.

**Results**:
- ✅ Hard rules: rule 1 execute-but-don't-write carve-out (3 clauses), rule 4 third evidence type, new rule 5 "demonstration outranks citation" — awk-scoped count = 5
- ✅ Applicability gate: TESTABLE/CITE-ONLY Phase-1 classification + four exact gate states (`in-play` / `spot-check (claim:` / `N/A (reason)` / `upgraded-in-play (was:`) + upgrade rule preserving prior state verbatim
- ✅ First-order **Empirical probe / doubt-removal** entry: the single probe contract (4 verdicts defined once, ≤3-iteration rule + next-probe-design, permission-block early-termination, verbatim safety block, `/tmp/<slug>-probes/` scratch lifecycle)
- ✅ Second-order **Probe-the-fix** + **Probe-the-contradiction** (each named as extending its parent; orchestrator-launched) + workflow-completion handoff covering all three TESTABLE-fix outcomes (UNDEMONSTRATED annotation)
- ✅ `probeFindings` single key + anchor (c) post-compaction runbook + Phase-3 convergence weighting (annotated-not-deleted) + residual operator-acceptance reporting + sanctioned single-claim spot-check ordered before map-building
- ✅ Discoverability: frontmatter description + intro carry the conditional probe clause (three-lane triangulation identity preserved); both registrations scope read-only to citation lanes, name probe lanes, drop the contiguous "read-only subagents" phrase
- ✅ Deploy 79/79, 0 failures; deployed `review-triangulate.md` byte-identical to source; gate-closed (pure-prose) run spawns the original three lanes with zero probe vocabulary

**Lessons Learned**:
- Anchor multi-step edits by stable content phrase, not line number — every prior insertion shifts later anchors.
- Scope structural invariant greps to their section (`awk '/^## Hard rules/,/^## Phase 1/'`) — a shared numbering pattern silently over-counts otherwise.
- Define a controlled vocabulary (the 4 verdicts, the 4 gate strings) exactly once; reference by name everywhere else, so the uniform-spelling sweep stays meaningful.
- Post-compaction runbook text (anchor (c)) must be self-sufficient — it can't lean on a prompt-local safety block that's gone from context after compaction.
- A subagent can't spawn lanes — assign the probe-the-contradiction launch explicitly to the orchestrator, or the entry describes an impossible spawn.
- For a prompt-layer task, the full end-to-end read is the load-bearing final check (semantic traceability + gate-closed-text-unchanged are not grep-checkable).

**Next**: Operator-run gate-closed dry-run (`/review-triangulate` on a pure-prose doc → `probes: N/A (reason)`, zero probe lanes, today's behavior) and gate-open live validation on a probe-rich doc (a CLI-behavior plan is the natural fixture) + negative-path transcript inspection — the one claim static greps cannot settle. The deferred fat-command guide-extraction (review-loop.md + review-triangulate.md together) remains on the backlog. Unrelated operator gates still pending: genesis deploy (now also carrying this probe-lanes change + the Stage-0 usecases cutover + core-design-4stage Step 10), core-review-walkthrough live smoke test.
