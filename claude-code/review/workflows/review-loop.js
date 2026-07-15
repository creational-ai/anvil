// review-loop
// Parameterized exam/review "critic-sandwich" on a single design or plan document.
//
// Reproduces the manual loop you run today across two chats
// (`/exam-loop <doc>` + `/review-doc-loop <doc>`) as ONE deterministic,
// strictly-sequential subagent sequence.
//
// `rounds` = how many NEW exam rounds to run THIS invocation (additive).
// Each invocation runs N exams and N-1 reviews, ALWAYS ending on an exam
// (the exam_N = review_N + 1 invariant the loop commands encode).
//
// ── ADDITIVE CONTINUATION ────────────────────────────────────────────────
// Column labels (E1/R1/E2/...) are NOT fixed — they continue from whatever
// the shared `-review.md` already holds. A pre-flight read counts existing
// E and R columns; round labels are computed from there:
//   exam round i   -> E(existing_E + i)
//   review round i -> R(existing_R + i)
//
//   no -review.md          + rounds=2  ->  E1, R1, E2
//   -review has E1,R1,E2   + rounds=2  ->  E3, R2, E4
//   -review has E1,R1      + rounds=2  ->  E2, R2, E3   (interrupted sandwich)
//
// Each round is a FRESH subagent — and that's fine: every `/exam` and
// `/review-doc-run` reads the `-review.md` FIRST, so the review doc IS the
// cross-round memory.
//
// Exam rounds run `/exam --auto` (single examiner). Review rounds reproduce
// `/review-doc-run`'s PARALLEL fan-out at the script level (scope -> parallel
// item + holistic reviewers -> single synthesis/apply writer), because workflow
// subagents can't spawn their own subagents. Non-parallel doc types fall back
// to sequential `/review-doc --auto`, exactly like the real command.
//
// Every round applies its fixes to the target doc (--auto). This MUTATES the doc.
//
// Invoke — DEPLOYED GLOBALLY via deploy.sh: it copies this source file to
// ~/.claude/workflows/review-loop.js, so `name`-resolution works from ANY project.
// It's a COPY, not a symlink — re-run ./deploy.sh after editing this file to re-sync
// the deployed copy (verify.sh asserts byte-identity and flags drift).
//   Workflow({ name: 'review-loop', args: { doc: 'docs/<slug>-design.md' } })             // rounds=2
//   Workflow({ name: 'review-loop', args: { doc: 'docs/<slug>-design.md', rounds: 3 } })
//   Workflow({ name: 'review-loop', args: { doc: 'docs/<slug>-design.md', notes: 'focus on the dependency chain' } })
//   Workflow({ name: 'review-loop', args: 'docs/<slug>-design.md' })                       // shorthand, rounds=2, no notes
// scriptPath still works for the in-repo copy:
//   Workflow({ scriptPath: 'claude-code/review/workflows/review-loop.js', args: … })
//
// ── THIN WRAPPER (design contract) ───────────────────────────────────────
// The review skill's architecture is "guides hold all logic; commands/agents
// are thin wrappers." This workflow follows suit: the JS holds ONLY the
// primitive-imposed control structure —
//   • the E/R/E topology + additive label math,
//   • orchestrator-owned label assignment (a fresh subagent must not count its
//     own in-progress write and mis-promote the column),
//   • the scope -> parallel(items+holistic) -> synth fan-out shape, which exists
//     ONLY because a workflow subagent can't spawn its own subagents,
//   • independent post-round verification + partial-failure accounting.
// EVERY domain decision is a runtime guide-read. No eligibility list, no
// item-boundary patterns, no elevation rule is paraphrased here — each agent is
// pointed at the guide section and told to apply it as written. (Paraphrasing a
// guide rule is an anti-pattern even when accurate: it is a second definition
// that drifts. See the regression guard below.) The workflow's win over the
// /review-loop command is context-isolation + deterministic orchestration, NOT
// parallel width.
//
// ── REGRESSION GUARD ─────────────────────────────────────────────────────
// This wrapper points agents at review-guide sections BY NUMBER. If the review
// skill renumbers/renames them, the pointers rot silently. `review-loop-guard.sh`
// (run by verify.sh when the review skill is present) asserts these anchors
// still exist in the live guides — keep the list in sync with that script:
//   exam-guide.md           : "## Review Mode"
//   review-doc-run-guide.md : "## Phase 1", "### 1.3", "### 1.5", "### 1.6", "### 1.8", "## Phase 3", "### 3.2"
//   review-doc-guide.md / review-item-guide.md / review-holistic-guide.md : exist
// <!-- regression-guard:review-doc-run-phases -->

export const meta = {
  name: 'review-loop',
  description: 'Parameterized exam/review critic-sandwich on a doc: N new exams + N-1 reviews, additive over the existing -review.md, ends on an exam. Default rounds=2.',
  phases: [
    { title: 'Pre-flight', detail: 'count existing E/R columns in the -review.md; plan the label sequence' },
    { title: 'Exam', detail: 'single examiner runs /exam --auto, writes the next E column, applies fixes' },
    { title: 'Review: scope', detail: 'detect doc type, extract items, build the next R-column skeleton' },
    { title: 'Review: parallel', detail: 'one reviewer per item + one holistic reviewer (barrier)' },
    { title: 'Review: synthesize', detail: 'sole writer: elevation pass, R-column entry, apply fixes' },
    { title: 'Verify', detail: 'independently re-read the header; assert exactly one new column; stop on drift' },
  ],
}

// ---- args -------------------------------------------------------------------
// args may arrive as: an object {doc, rounds, notes}; a bare doc-path string; or
// — if the call serialized the object — a JSON-ENCODED string of that object.
// Normalize all three so `rounds`/`notes` are honored (never silently dropped).
let a = args
if (typeof a === 'string') {
  const s = a.trim()
  if (s.startsWith('{') || s.startsWith('[')) {
    try { a = JSON.parse(s) } catch (_) { /* not JSON — treat as a bare path */ }
  }
}
const doc = typeof a === 'string' ? a : (a && a.doc)
if (!doc || typeof doc !== 'string') {
  throw new Error("review-loop requires a doc path. Pass args: 'docs/foo-design.md' or args: { doc, rounds, notes }.")
}
const rawRounds = (a && typeof a === 'object') ? Number(a.rounds) : NaN
const rounds = Number.isFinite(rawRounds) && rawRounds >= 1 ? Math.floor(rawRounds) : 2
const notes = (a && typeof a === 'object' && a.notes != null) ? String(a.notes).trim() : ''

// ---- review-doc path: ORCHESTRATOR-OWNED, computed ONCE -----------------------
// The review doc lives next to the target doc: strip `.md`, append `-review.md`
// (review-doc-run-guide §1.8 and the exam guide derive this identically). This is
// pure string manipulation, so the JS owns it — the SAME discipline the column
// LABEL already gets (a fresh subagent must not re-derive an orchestrator value
// and drift). Threaded into every agent that reads/writes the review file; each
// is told to use it verbatim and NOT re-derive. This closes the stage-suffix-drop
// bug where the review/scope agent produced `…-review.md` (dropping `-design`/
// `-plan`) while pre-flight + verify used `…-design-review.md` — the column
// misfiled to a stray file, verify couldn't find it, and the loop aborted before
// its terminal exam.
const reviewDocPath = doc.replace(/\.md$/, '-review.md')

const SKIP_AUDIO = 'Skip the afplay/say completion notification — this is an unattended workflow step.'
// Focus context threaded into every agent preamble (the plan-execution-readiness.js pattern).
const notesLine = notes
  ? `\n\nOperator focus context (weight findings/extraction toward this; do NOT let it narrow required coverage): ${notes}`
  : ''

// ---- schemas ----------------------------------------------------------------
// Schemas are scoped to what the JS ACTUALLY consumes. Reviewer findings ride as
// free-form text passthrough (the synth re-reads the guide to write them), so
// there is no second copy of the skill's finding model to drift here.
const PREFLIGHT_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  properties: {
    review_doc_path: { type: 'string', description: 'Derived: strip .md from the doc path, append -review.md' },
    exists: { type: 'boolean' },
    e_count: { type: 'integer', description: 'Number of E (exam) columns in the summary-table header (0 if no doc)' },
    r_count: { type: 'integer', description: 'Number of R (review) columns in the summary-table header (0 if no doc)' },
    note: { type: 'string', description: 'One line on what was found (or "no review doc yet")' },
  },
  required: ['review_doc_path', 'exists', 'e_count', 'r_count', 'note'],
}

const ROUND_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  properties: {
    round_label: { type: 'string', description: 'The round column actually written, e.g. E3, R2' },
    label_matched_plan: { type: 'boolean', description: 'true if the written label equals the target the workflow handed you' },
    high: { type: 'integer' },
    med: { type: 'integer' },
    low: { type: 'integer' },
    fixes_applied: { type: 'integer' },
    fixes_total: { type: 'integer' },
    verdict: { type: 'string', description: 'One-line bottom-line; note here if you had to self-correct the label' },
  },
  required: ['round_label', 'label_matched_plan', 'high', 'med', 'low', 'fixes_applied', 'fixes_total', 'verdict'],
}

const SCOPE_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  properties: {
    parallel: { type: 'boolean', description: 'true only if the guide §1.3/§1.6 keep this doc on the parallel path with >=1 extracted item' },
    doc_type: { type: 'string' },
    review_doc_path: { type: 'string' },
    items: {
      type: 'array',
      items: {
        type: 'object',
        additionalProperties: false,
        properties: {
          name: { type: 'string' },
          text: { type: 'string', description: 'Full markdown of this item, from its boundary start to end' },
        },
        required: ['name', 'text'],
      },
    },
    shared_context: { type: 'string' },
    cross_ref_excerpts: { type: 'string' },
    cross_ref_paths: { type: 'array', items: { type: 'string' } },
    note: { type: 'string', description: 'If parallel=false, one line on why (wrong type / zero items)' },
  },
  required: ['parallel', 'doc_type', 'review_doc_path', 'items', 'shared_context', 'cross_ref_excerpts', 'cross_ref_paths', 'note'],
}

// Independent post-round verification: a fresh agent re-reads the header and
// counts columns — corroboration of the round agent's self-report, not a copy.
const VERIFY_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  properties: {
    e_count: { type: 'integer', description: 'E columns currently in the summary-table header' },
    r_count: { type: 'integer', description: 'R columns currently in the summary-table header' },
    has_expected_label: { type: 'boolean', description: 'true if a column labeled exactly as asked is present' },
    note: { type: 'string', description: 'One line; flag any extra/duplicate/partial column seen' },
  },
  required: ['e_count', 'r_count', 'has_expected_label', 'note'],
}

// ---- pre-flight: count existing columns, plan the additive label sequence ---
const pf = await agent(
  `You are doing a READ-ONLY pre-flight for a review-loop workflow. Do NOT edit anything.\n\n` +
  `Target document: ${doc}\n` +
  `Review doc path (AUTHORITATIVE — use EXACTLY this; do NOT re-derive it or strip any \`-design\`/\`-plan\` suffix): ${reviewDocPath}\n\n` +
  `1. Read \`${reviewDocPath}\`. Set review_doc_path to that exact path in your result.\n` +
  `2. If it does NOT exist: return exists=false, e_count=0, r_count=0.\n` +
  `   If it exists: find the summary-table header row. Its title varies by doc type — \`## Item Summary\` (Design), \`## Step Summary\` (Plan), or \`## Task Summary\` (Tasks) — so locate it by shape (the \`| # | <noun> | …round columns… |\` table), not by the literal word "Item". Count how many **E** columns (exam rounds, from /exam) and how many **R** columns (review rounds, from /review-doc / /review-doc-run) it has. Return those two counts.\n` +
  `Return the structured result.`,
  { label: 'pre-flight', phase: 'Pre-flight', agentType: 'general-purpose', schema: PREFLIGHT_SCHEMA }
)

const e0 = Math.max(0, pf.e_count | 0)
const r0 = Math.max(0, pf.r_count | 0)

// Build the additive plan: exam round i -> E(e0+i); review round i -> R(r0+i).
const plan = []
for (let i = 1; i <= rounds; i++) {
  plan.push({ kind: 'E', i, label: `E${e0 + i}`, priorCount: e0 + i - 1 })
  if (i < rounds) plan.push({ kind: 'R', i, label: `R${r0 + i}`, priorCount: r0 + i - 1 })
}
const planLabels = plan.map((p) => p.label).join(' → ')

log(`review-loop on ${doc} — rounds=${rounds}${notes ? ` — notes: "${notes}"` : ''}`)
log(`pre-flight: ${pf.exists ? `existing -review.md has ${e0} E column(s), ${r0} R column(s)` : 'no -review.md yet'} (${pf.note})`)
log(`planned (additive): ${planLabels}  [mutates ${doc} via --auto]`)

// ---- exam round (single examiner) ------------------------------------------
async function examRound(label) {
  return agent(
    `Run \`/exam --auto\` on a single document by reading the exam guide at ~/.claude/skills/review/references/exam-guide.md and following its **Review Mode** section EXACTLY AS WRITTEN. The guide is the full methodology — apply it; don't restate it.\n\n` +
    `Document: ${doc}\n` +
    `Review doc (AUTHORITATIVE — write your column to EXACTLY this file; do NOT re-derive the path or strip any \`-design\`/\`-plan\` suffix): ${reviewDocPath}\n\n` +
    `Apply these orchestration constraints the bare command doesn't cover (these are wrapper concerns, NOT a substitute for the guide):\n` +
    `1. **Column is assigned, not counted.** Write your findings under column **${label}** — assigned by the orchestrator (which counted once, before any round ran) and authoritative. Do NOT re-derive it by counting columns or bump to a higher number; if a ${label} column or partial ${label} entries already exist, resume that same column (counting after you start writing double-counts your own work). Set label_matched_plan=true; set it false only if you genuinely cannot write ${label}, then explain in the verdict.\n` +
    `2. **Timestamp from the clock.** Stamp the ${label} log + detail entries by running \`date "+%Y-%m-%dT%H:%M:%S%z"\` via Bash — never guess, round, or fabricate; reuse the one value everywhere in this round.\n` +
    `3. ${SKIP_AUDIO}\n` +
    `4. Apply ALL fixes to ${doc} (--auto; annotate skips with [Skipped: <mechanical reason>]) and return a structured summary (round_label = the E column you wrote, severity counts, fixes X of Y, one-line verdict).${notesLine}`,
    { label, phase: 'Exam', agentType: 'general-purpose', schema: ROUND_SCHEMA }
  )
}

// ---- review round: parallel fan-out reproducing /review-doc-run -------------
// Reviewer prompts point at the guide and return FREE-FORM findings (no schema):
// the JS never computes on them — it hands them to the synth, which re-reads the
// guide to write the doc. Item identity is preserved by POSITION (items[i]).
function itemPrompt(scope, it) {
  return `Review this ${scope.doc_type} item. You are one parallel item-reviewer; you REPORT findings only — do NOT edit any file.\n\n` +
    `Read the item review guide at ~/.claude/skills/review/references/review-item-guide.md and apply it AS WRITTEN. Verify every claim against the live codebase (Glob/Grep/Read).\n\n` +
    `## Document\n**Path**: ${doc}\n**Type**: ${scope.doc_type}\n\n` +
    `## Item to Review: ${it.name}\n${it.text}\n\n` +
    `## Shared Context\n${scope.shared_context}\n\n` +
    `## Cross-Reference\n${scope.cross_ref_excerpts}\n\n` +
    `Return your findings as markdown — each with severity (HIGH/MED/LOW), a description, and a concrete suggested fix, exactly as the item guide specifies. If sound, say so explicitly.${notesLine}`
}

function holisticPrompt(scope) {
  return `Review the cross-cutting concerns of this ${scope.doc_type} document. You are the holistic reviewer; you REPORT findings only — do NOT edit any file.\n\n` +
    `Read the holistic review guide at ~/.claude/skills/review/references/review-holistic-guide.md and apply it AS WRITTEN.\n\n` +
    `## Document\n**Path**: ${doc}\n**Type**: ${scope.doc_type}\n\n` +
    `## Cross-Reference Documents\n${(scope.cross_ref_paths || []).join('\n') || '(none)'}\n\n` +
    `Return cross-cutting findings as markdown — each with the concern area, severity, description, and a concrete suggested fix, exactly as the holistic guide specifies. If sound, say so explicitly.${notesLine}`
}

async function reviewRound(label, priorCount) {
  // Phase 1 — scope: detect type + extract items + build the target R-column
  // skeleton, ALL per the guide as written (no eligibility list / boundary
  // patterns paraphrased here — the only wrapper concern is the assigned label).
  const scope = await agent(
    `You are Phase 1 (Setup) of the \`/review-doc-run\` command, in --auto mode, on a single document.\n\n` +
    `Document: ${doc}\n` +
    `Review doc (AUTHORITATIVE — create/extend the skeleton at EXACTLY this path; do NOT run §1.8's path-derivation step or strip any \`-design\`/\`-plan\` suffix): ${reviewDocPath}\n` +
    `Target review column: **${label}** (the doc already has ${priorCount} R column(s); this is the next one).\n\n` +
    `Read the guide at ~/.claude/skills/review/references/review-doc-run-guide.md and execute **Phase 1 (§1.1–§1.8) EXACTLY AS WRITTEN**, with ONE override: SKIP §1.8's "derive review doc path" step and use the authoritative path above verbatim. Apply the guide's own §1.3 review-mode determination, §1.5 item-boundary rules, and §1.6 fallback check VERBATIM — do NOT work from any remembered list of eligible doc types or boundary patterns; the guide is the only authority.\n` +
    `- If §1.3/§1.6 route this doc to sequential review (non-parallel type, or zero extractable items), return parallel=false with a one-line note and STOP (do not create a skeleton).\n` +
    `- If parallel: extract items per §1.5 for THIS doc type (capture each item's FULL markdown + name), assemble shared_context and a CONDENSED cross_ref_excerpts, then CREATE or EXTEND the skeleton AT \`${reviewDocPath}\` per §1.8, adding the **${label}** column with \`...\` cells. Set review_doc_path=${reviewDocPath} in your result.\n` +
    `Orchestration constraint (NOT in the guide): write exactly the orchestrator-assigned column **${label}** — do NOT re-derive the number by counting; if a ${label} column already exists you are resuming it.${notesLine}\n\n` +
    `Return the structured scope. ${SKIP_AUDIO}`,
    { label: `${label}·scope`, phase: 'Review: scope', agentType: 'general-purpose', schema: SCOPE_SCHEMA }
  )

  // Non-parallel doc type → faithful fallback to sequential /review-doc --auto.
  if (!scope.parallel) {
    log(`${label}: ${scope.doc_type} is not a parallel type (${scope.note}) — sequential /review-doc --auto`)
    const seq = await agent(
      `You are running the \`/review-doc\` (sequential) slash command in --auto mode on a single document.\n\n` +
      `Document: ${doc}\nReview doc (AUTHORITATIVE — write to EXACTLY this file; do NOT re-derive the path or strip any \`-design\`/\`-plan\` suffix): ${reviewDocPath}\nTarget review column: **${label}** — write exactly this orchestrator-assigned column; do NOT re-derive it by counting.\n\n` +
      `Read the sequential review guide at ~/.claude/skills/review/references/review-doc-guide.md and follow it EXACTLY AS WRITTEN: identify doc type, load cross-references, run the type-specific + universal checks, write the ${label} column to \`${reviewDocPath}\`, then apply ALL fixes to ${doc} (--auto). Annotate skips with [Skipped: <mechanical reason>]. Stamp the log + detail entries by running \`date "+%Y-%m-%dT%H:%M:%S%z"\` via Bash — never guess or fabricate the timestamp.\n` +
      `${SKIP_AUDIO}${notesLine}\n\nReturn a concise structured summary (round_label = the R column you actually wrote).`,
      { label: `${label}·seq`, phase: 'Review: synthesize', agentType: 'general-purpose', schema: ROUND_SCHEMA }
    )
    return seq ? { ...seq, degraded: false } : null
  }

  // Phase 2 — parallel item reviewers + one holistic reviewer (barrier).
  const itemThunks = scope.items.map((it) => () =>
    agent(itemPrompt(scope, it), { label: `${label} item:${it.name}`, phase: 'Review: parallel', agentType: 'general-purpose' })
  )
  const holisticThunk = () =>
    agent(holisticPrompt(scope), { label: `${label} holistic`, phase: 'Review: parallel', agentType: 'general-purpose' })

  // parallel() preserves positions and sets null for any failed agent. Split
  // POSITIONALLY (the holistic thunk is always last); never filter before the
  // split or a failed item would slide the holistic into the item list.
  const raw = await parallel([...itemThunks, holisticThunk])
  const itemSlots = raw.slice(0, scope.items.length)
  const holisticResult = raw[raw.length - 1]

  // Partial-failure accounting (MED#2): a null slot = that reviewer failed.
  // Don't silently drop it — name it, carry a degraded flag downstream.
  const failedItems = scope.items.filter((_, i) => !itemSlots[i]).map((it) => it.name)
  const holisticFailed = !holisticResult
  const degraded = failedItems.length > 0 || holisticFailed
  if (degraded) {
    log(`${label}: ⚠ DEGRADED — ${failedItems.length}/${scope.items.length} item reviewer(s) failed${holisticFailed ? ' + holistic failed' : ''}${failedItems.length ? ` (${failedItems.join(', ')})` : ''}`)
  }
  const degradedNote = degraded
    ? ` — DEGRADED round: ${failedItems.length} item reviewer(s) failed${holisticFailed ? ' + holistic reviewer failed' : ''}`
    : ''

  // Findings ride as labeled free-form text; failed reviewers are explicitly
  // flagged so the synth marks the cell rather than silently writing ✅.
  const itemBlocks = scope.items
    .map((it, i) => itemSlots[i]
      ? `### ${it.name}\n${itemSlots[i]}`
      : `### ${it.name}\n(NO REVIEWER RESULT — this reviewer FAILED. Mark this item's ${label} cell ⚠ "not reviewed" and do NOT write ✅.)`)
    .join('\n\n')
  const holisticBlock = holisticResult || '(NO HOLISTIC RESULT — the holistic reviewer FAILED. Mark holistic concerns ⚠ "not reviewed" for this round.)'

  // Phase 3 — single synthesis/apply writer (sole editor of the review doc).
  const res = await agent(
    `You are Phase 3 (Report and Fix) of the \`/review-doc-run\` command, in --auto mode. You are the SOLE editor of the review doc.\n\n` +
    `Document: ${doc}\nReview doc (AUTHORITATIVE — edit EXACTLY this file; do NOT re-derive the path): ${reviewDocPath}\nReview column: **${label}**\n\n` +
    `The parallel reviewers have completed; their findings are below as labeled markdown. The ${label} skeleton column already exists with \`...\` cells.${degradedNote}\n\n` +
    `## Item reviewer findings (one block per item; "(NO REVIEWER RESULT)" means that reviewer failed)\n${itemBlocks}\n\n` +
    `## Holistic reviewer findings\n${holisticBlock}\n\n` +
    `Read ~/.claude/skills/review/references/review-doc-run-guide.md **Phase 3 (§3.1–§3.5) and execute it EXACTLY AS WRITTEN**, including the **§3.2 elevation pass as the guide defines it** (do NOT work from any summary of the elevation rule):\n` +
    `- Write each item's findings into its ${label} summary cell (issue counts or ✅) and detail entry; same for holistic concern areas. For any reviewer flagged failed above, write ⚠ "not reviewed" in that cell — never ✅.\n` +
    `- Run the §3.2 elevation pass as written.\n` +
    `- Set the review log entry: command \`review-doc-run\`, mode \`Parallel (${scope.items.length} item + 1 holistic) --auto${degraded ? ' [PARTIAL]' : ''}\`, recalculated totals, Status${degraded ? ' = Partial (note the failed reviewer(s))' : ''}. **Timestamp via \`date "+%Y-%m-%dT%H:%M:%S%z"\` (Bash)** — never guess/fabricate; one value for detail entries and the log row.\n` +
    `- Apply EVERY fix to ${doc} regardless of severity (--auto). Legit skips are mechanical only — ambiguous target / already correct / outside document scope — annotate [Skipped: <reason>]. For plan step-splitting fixes, follow the guide's guarded step-split procedure. Update Status to Applied (X of Y).\n` +
    `- ${SKIP_AUDIO}\n\nReturn a concise structured summary (round_label = ${label}; set label_matched_plan accordingly).`,
    { label: `${label}·apply`, phase: 'Review: synthesize', agentType: 'general-purpose', schema: ROUND_SCHEMA }
  )
  return res ? { ...res, degraded } : null
}

// ---- independent post-round verification (HIGH#1) ---------------------------
// A fresh subagent re-reads the header and counts columns. This corroborates the
// round agent's SELF-REPORT — the dangerous case (agent writes E{n} AND E{n+1}
// but reports label_matched_plan:true) is invisible to a self-report check.
async function verifyRound(reviewDocPath, expectedLabel) {
  return agent(
    `READ-ONLY verification. Do NOT edit anything.\n\n` +
    `Read \`${reviewDocPath}\`. Locate the summary-table header row (its title varies by doc type — \`## Item Summary\` (Design), \`## Step Summary\` (Plan), or \`## Task Summary\` (Tasks); find it by shape, the \`| # | <noun> | …round columns… |\` table). Then:\n` +
    `- Count the **E** columns (exam: E1, E2, …) and the **R** columns (review: R1, R2, …) in that header.\n` +
    `- Report whether a column labeled EXACTLY **${expectedLabel}** is present.\n` +
    `- In the note, flag anything anomalous: a duplicate column, an unexpected extra column, or a partially-written one.\n` +
    `Return the structured counts.`,
    { label: `${expectedLabel}·verify`, phase: 'Verify', agentType: 'general-purpose', schema: VERIFY_SCHEMA }
  )
}

// ---- drive the strictly-sequential additive E/R/E sequence ------------------
const rows = []
let status = 'ok' // ok | degraded | drifted | aborted
let eExpected = e0
let rExpected = r0
for (const step of plan) {
  if (step.kind === 'E') eExpected += 1
  else rExpected += 1

  const res = step.kind === 'E'
    ? await examRound(step.label)
    : await reviewRound(step.label, step.priorCount)

  if (!res) {
    log(`✖ STOP: ${step.label} produced no result (agent skipped or failed). Not launching the next round.`)
    status = 'aborted'
    rows.push({ planned: step.label, round_label: null, aborted: true })
    break
  }

  // Independent verification — re-read the header, assert exactly one new column.
  const v = await verifyRound(reviewDocPath, step.label)
  const verifyOk = !!v && v.has_expected_label && v.e_count === eExpected && v.r_count === rExpected
  const degraded = res.degraded === true

  log(`${res.round_label} done — ${res.high}H/${res.med}M/${res.low}L, fixes ${res.fixes_applied}/${res.fixes_total}${degraded ? ' [DEGRADED]' : ''}. ${res.verdict}`)
  rows.push({ planned: step.label, ...res, degraded, verified: verifyOk })

  if (!verifyOk) {
    const seen = v ? `${v.e_count}E/${v.r_count}R, ${step.label} present: ${v.has_expected_label} — ${v.note}` : 'header unreadable'
    log(`✖ STOP: ${step.label} FAILED independent verification — expected ${eExpected}E/${rExpected}R with ${step.label} present; header shows ${seen}. Not launching the next round onto a corrupted base.`)
    status = 'drifted'
    break
  }
  if (degraded && status === 'ok') status = 'degraded'
}

return {
  doc,
  rounds,
  notes: notes || null,
  status, // ok | degraded | drifted | aborted — machine-readable for unattended consumers
  review_doc_path: reviewDocPath,
  started_from: { e_columns: e0, r_columns: r0 },
  planned_sequence: plan.map((p) => p.label),
  actual_sequence: rows.map((r) => r.round_label).filter(Boolean),
  rows,
  final_verdict: rows.length ? (rows[rows.length - 1].verdict ?? `(stopped: ${status})`) : '(no rounds run)',
}
