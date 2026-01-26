---
name: framework-alignment
description: "Analyze any project against Three Strategic Frameworks (Four Loops, Flywheel, Dangerous Intelligence) to identify gaps and required signal infrastructure. Use when user asks: 'framework alignment', 'are we building the right loops', 'what signals are we missing', 'how do we build a moat', 'what nets do we need', 'pre-launch checklist', 'are we ready to launch', or any question about strategic readiness. Pulls full Mission Control data (project → milestones → tasks), applies all three frameworks, identifies what mechanisms must exist BEFORE users arrive so loops spin from day 1. Produces actionable alignment doc with net inventory and implementation priorities."
---

# framework-alignment

Analyze projects against strategic frameworks and identify required signal infrastructure.

**Version**: 1.0.0

## Philosophy

**Don't launch a product. Launch a learning machine.**

Competitors can copy features in weeks. They can't copy 6 months of compounding signal data and the product decisions that emerged from it.

**The "Nets" Strategy:** Build signal infrastructure INTO the foundation. When you launch, loops are already spinning. Day 1 users start generating the moat.

**Pre-launch focus:** Most projects haven't launched yet. The question isn't "are loops working?" — it's "are the nets designed so loops START working from user #1?"

---

## Three Frameworks Applied

| Framework | Core Question | Pre-Launch Application |
|-----------|---------------|------------------------|
| **Four Loops** | Are we building compounding feedback loops? | What nets capture signals for each loop? |
| **Flywheel** | Does each stage feed the next? | Is signal infrastructure built into Delivery? |
| **Dangerous Intelligence** | Zone 2 (uncapped) focus? | Are we building nets (Zone 2) not just features (Zone 1)? |

→ See `references/framework-*.md` files for complete framework details

---

## When to Use

**Direct triggers:**
- "Framework alignment for [project]"
- "Are we building the right loops?"
- "What signals are we missing?"
- "How do we build a moat?"
- "What nets do we need?"
- "Pre-launch checklist"
- "Are we ready to launch?"

**Situational triggers:**
- Project has features but unclear signal capture
- User asking about competitive moat
- Launch planning discussions
- Post-milestone strategic review
- "What should we build next?" questions

---

## Context Extraction

### 1. Mission Control MCP (Required)

Pull **all three tiers**:

| Tier | MCP Calls | Key Fields |
|------|-----------|------------|
| **Project** | `get_project(slug)` | objective, business_value, phase, status, notes |
| **Milestones** | `list_milestones(project_slug)` | goal, status, risks, design_decisions |
| **Tasks** | `list_tasks(project_slug)` | objective, unlocks, lessons_learned, status |

**Why all tiers:** Tasks reveal what's actually built. Milestones show what's planned. Project shows the vision. Gaps between them = alignment opportunities.

### 2. Project Files

Check for existing docs:
- Framework alignment docs (`*-framework-alignment*.md`)
- Product specs
- Architecture docs
- Pricing/GTM docs

### 3. Portfolio Context

Check `list_projects()` for:
- Shared infrastructure potential
- Products that feed each other (VP → MC pattern)
- Ecosystem leverage

---

## Process

### Phase 1: Current State Assessment

1. Extract all MC data
2. List what's built (completed tasks)
3. List what's planned (active/planned tasks)
4. Identify current signal capture (any analytics, feedback, tracking?)

### Phase 2: Four Loops Analysis

For each loop, assess:

**Loop 1: Balance (Advantage ↔ Pain)**
- What's the claimed advantage?
- What's the claimed pain point?
- Is either validated or assumed?
- What net would capture validation signal?

**Loop 2: Speed to Revenue (Ship → Learn)**
- What's the shipping velocity? (Check task timestamps)
- Are we learning from external users or just internal use?
- What net captures learning signals?

**Loop 3: Signal to Innovation (User → Improve)**
- Where do user signals come from currently?
- How often are signals reviewed?
- What nets are missing?

**Loop 4: Sweat Equity (Conviction)**
- Evidence of deep work? (session lengths, quality)
- This loop is usually ✅ if other work exists

### Phase 3: Flywheel Analysis

Assess each stage:

| Stage | Status | Signal Captured? |
|-------|--------|------------------|
| Lead Gen | ❌/⚠️/✅ | [What net?] |
| Nurturing | ❌/⚠️/✅ | [What net?] |
| Closing | ❌/⚠️/✅ | [What net?] |
| Delivery | ❌/⚠️/✅ | [What net?] |
| Reputation | ❌/⚠️/✅ | [What net?] |

Key insight: "Delivery" isn't just "working product" — it's "working product WITH signal infrastructure."

### Phase 4: Dangerous Intelligence Analysis

Categorize recent/planned work:

| Work Item | Zone 1 (Capped) or Zone 2 (Uncapped)? |
|-----------|---------------------------------------|
| [Task/feature] | [Assessment + reasoning] |

**Zone 2 (Uncapped):** Signal infrastructure, architecture decisions, what we learn from
**Zone 1 (Capped):** Features, polish, things that don't compound

Calculate ratio. Flag if Zone 1 heavy.

### Phase 5: Net Inventory

Check status of Seven Standard Nets:

| Net | Purpose | Status | Implementation Scope |
|-----|---------|--------|---------------------|
| Usage Analytics | Track every action | ❌/⚠️/✅ | [What's needed] |
| submit_feedback | Zero-friction qualitative signal | ❌/⚠️/✅ | [What's needed] |
| Cohort Tracking | Behavior by segment | ❌/⚠️/✅ | [What's needed] |
| Feature Flags | A/B test without deploys | ❌/⚠️/✅ | [What's needed] |
| Churn Signals | Activity drop detection | ❌/⚠️/✅ | [What's needed] |
| Error Tracking | Know when things break | ❌/⚠️/✅ | [What's needed] |
| Onboarding Funnel | Where users drop off | ❌/⚠️/✅ | [What's needed] |

### Phase 6: Gap Prioritization

Prioritize missing nets by:

1. **P0 (Launch blocker):** Without this, no signal loop starts
2. **P1 (Week 1):** Needed to learn from first users
3. **P2 (Month 1):** Needed for optimization
4. **Defer:** Nice to have, not day 1

### Phase 7: Competitive Moat Timeline

Project what we'll have vs. what competitors would need:

| Month | What We Have | What Competitor Needs |
|-------|--------------|----------------------|
| 0 (Launch) | Nets in place, 0 data | Build nets from scratch |
| 1 | X tool calls analyzed | Still building |
| 3 | Patterns emerging | Starting from zero |
| 6 | Signal-informed v2 | 6 months behind |

---

## Output: Framework Alignment Document

→ See `references/alignment-template.md` for full template

### Required Sections

1. **Strategic Context** — The moat thesis
2. **Framework Summary** — Three frameworks, one table
3. **Four Loops Assessment** — Status + net needs per loop
4. **Flywheel Assessment** — Stage status + signal gaps
5. **Zone Analysis** — Zone 1 vs Zone 2 work ratio
6. **Net Inventory** — Seven nets with status and scope
7. **Implementation Priorities** — P0/P1/P2/Defer
8. **Pre-Launch Checklist** — Binary yes/no checks
9. **Post-Launch Signals** — What to watch
10. **Competitive Moat Timeline** — Month-by-month projection
11. **Success Definition** — What "launch" actually means

---

## Verification Checklist

Before finalizing alignment doc:

- [ ] MC data extracted (all three tiers)
- [ ] All four loops assessed with net recommendations
- [ ] All flywheel stages assessed
- [ ] Zone 1 vs Zone 2 ratio calculated
- [ ] All seven nets inventoried
- [ ] Gaps prioritized (P0/P1/P2/Defer)
- [ ] Pre-launch checklist is answerable (yes/no)
- [ ] Success definition is concrete, not vague
- [ ] Moat timeline shows compounding advantage

---

## Anti-Patterns

**Don't:**
- Assess launched product patterns against pre-launch project
- Skip MC data extraction
- Declare loop "working" when only internal use exists
- Treat all features as equal (Zone 1 vs Zone 2 matters)
- Create alignment doc without net inventory
- Define success as "it works" (success = "loops are spinning")

---

## Reference Files

| When to Read | Reference File |
|--------------|----------------|
| Four Loops details | `references/framework-four-loops-ai-wealth.md` |
| Flywheel details | `references/framework-ai-flywheel-tools.md` |
| Dangerous Intelligence details | `references/framework-dangerous-intelligence.md` |
| Creating alignment doc | `references/alignment-template.md` |
