---
name: framework-alignment
description: >
  Run focused strategic assessments on any project using a builder-first, trading-mindset approach.
  Four framework lenses available:
  (1) FOUR LOOPS - feedback loop design, signal capture, compounding mechanics,
  (2) FLYWHEEL - GTM stage design, delivery signals, stage-to-stage flow,
  (3) DANGEROUS INTELLIGENCE - Zone 1 vs Zone 2 work ratio, capped vs uncapped effort,
  (4) AI HIGH GROUND - RAIL test, flood zone risk, layer positioning.
  Triggers: 'four loops assessment', 'flywheel assessment', 'zone analysis', 'RAIL test',
  'flood zone check', 'framework alignment', 'what loops are working', 'are we in the flood zone'.
  If user doesn't specify which assessment, ask which one.
  Each assessment pulls Mission Control data and market research, defines the trade thesis,
  identifies what the framework requires us to build, and produces an actionable roadmap.
---

# framework-alignment

Run focused strategic assessments on projects. Choose one framework lens at a time for deep analysis.

**Version**: 3.0.0

## Philosophy

**We are builders entering markets, not graders of finished products.**

Think of every venture like a trade:

- **Market conditions** — What's happening in the space? What's shifting?
- **Patterns** — What's working? What's underserved? What's done poorly?
- **Signals** — Real data points that confirm or deny our thesis. Not opinions.
- **The bet** — What we're building, how we're positioning, why it compounds into a big payout.

The framework provides the lens. This skill provides the discipline. Revenue is the payout when the thesis is right and the position is built correctly.

**The "Nets" Strategy:** Build signal infrastructure INTO the foundation. When you launch, loops are already spinning. Day 1 users start generating the moat.

---

## Assessment Selection

**If user specifies assessment:** Run that assessment directly.

**If user says "framework alignment" without specifying:** Ask which lens:

> Which framework lens do you want to assess through?
> 
> 1. **Four Loops** — What feedback loops do we need to design so they compound from day 1?
> 2. **Flywheel** — What GTM stages need to exist and how does each feed the next?
> 3. **Dangerous Intelligence** — Are we building Zone 2 (uncapped/compounding) or Zone 1 (capped/fixed)?
> 4. **AI High Ground** — RAIL test: Are we positioned on high ground or in the flood zone?

---

## Trigger Phrases → Assessment Mapping

| Trigger Phrase | Assessment |
|----------------|------------|
| "four loops", "feedback loops", "what loops", "signal capture", "nets" | Four Loops |
| "flywheel", "GTM stages", "lead gen", "delivery signals" | Flywheel |
| "zone analysis", "zone 1 vs zone 2", "capped vs uncapped", "dangerous intelligence" | Dangerous Intelligence |
| "RAIL test", "flood zone", "high ground", "market position", "are we safe" | AI High Ground |
| "framework alignment" (unqualified), "strategic assessment", "pre-launch check" | **Ask user** |

---

## Core Process (All Assessments)

Every assessment follows these steps in order.

### Step 1: Pull Real Data

No memory. No assumptions. No guessing.

**Mission Control — all three tiers:**

| Tier | MCP Call | Key Fields |
|------|----------|------------|
| **Project** | `get_project(slug)` | objective, business_value, phase, status, notes |
| **Milestones** | `list_milestones(project_slug)` | goal, status, risks, design_decisions |
| **Tasks** | `list_tasks(project_slug)` | objective, unlocks, lessons_learned, status, timestamps |

**Market Research:**
- Web search for market conditions, competitors, patterns
- Identify what's working, what's underserved, what's shifting

This is the market scan. A trader doesn't place a bet without reading the chart.

### Step 2: Define the Trade

Based on the chosen framework and data pulled, answer:

- **What are we betting on?** — The specific position we're building toward
- **Why does it pay off?** — Signals supporting the thesis, market conditions in our favor
- **What's our edge?** — What compounds over time, what's hard to replicate
- **What could invalidate it?** — Signals against, honest risks

If the thesis can't be articulated clearly, flag it — we're not ready to build.

### Step 3: Framework Alignment Check

Apply the chosen framework as the lens. For each component the framework defines:

- **Required** — What the framework says we need to have
- **Have** — What actually exists (from MC data)
- **Gap** — The delta, stated as a specific build item

"Improve feedback loops" is noise. "Implement usage event tracking that captures X signal and feeds it into Y decision" is a signal.

### Step 4: Sequence the Roadmap

Order by dependency and leverage:

- What unblocks what?
- What builds the position fastest?
- What creates compounding value earliest?

Every action must be **concrete** (know exactly what to build), **completable** (has a done state), **sequenced** (knows what comes before/after), and **justified** (ties back to the thesis and framework requirements).

### Step 5: Output the Assessment

Use the template in `references/alignment-template.md`. Produce a document artifact.

---

## Framework-Specific Guidance

Each section below describes what the framework lens looks for. Full framework details are in reference files — read the relevant one before running the assessment.

### Assessment 1: Four Loops

**Core Question:** What feedback loops do we need to design so they compound from day 1?

**Reference:** `references/framework-four-loops-ai-wealth.md`

**What this lens evaluates:**

| Loop | Builder Question |
|------|-----------------|
| **Loop 1: Balance** | What's our asymmetric advantage? What acute pain are we solving? Are we testing or assuming? |
| **Loop 2: Speed to Revenue** | How fast can we ship and learn? What nets capture that learning? |
| **Loop 3: Signal to Innovation** | What signal sources do we need to build in? How do they feed back into product decisions? |
| **Loop 4: Sweat Equity** | Is there deep conviction and obsessive execution? (Usually ✅ if work exists) |

**Key nets to consider:** Usage Analytics, submit_feedback, Cohort Tracking

---

### Assessment 2: Flywheel

**Core Question:** What GTM stages need to exist and how does each feed the next?

**Reference:** `references/framework-ai-flywheel-tools.md`

**What this lens evaluates:**

| Stage | Builder Question |
|-------|-----------------|
| **Lead Gen** | How will prospects discover us? What signal do we capture from discovery? |
| **Nurturing** | How do prospects learn value? What keeps us in their head? |
| **Closing** | What triggers conversion? Where is friction? |
| **Delivery** | Is the product working AND capturing signals? |
| **Reputation** | How does success spread? What amplifies it? |

**Key focus:** Identify broken connections between stages. Each stage must feed the next.

**Key nets to consider:** Onboarding Funnel, Churn Signals, Error Tracking

---

### Assessment 3: Dangerous Intelligence

**Core Question:** Are we building Zone 2 (uncapped/compounding) or Zone 1 (capped/fixed)?

**Reference:** `references/framework-dangerous-intelligence.md`

**What this lens evaluates:**

| Zone | Definition | Examples |
|------|------------|----------|
| **Zone 2 (Uncapped)** | Compounds over time, builds moat | Signal infrastructure, architecture, data flywheels |
| **Zone 1 (Capped)** | Fixed value, doesn't compound | Features, polish, one-time improvements |

**Process:** Categorize all recent/planned work → Calculate ratio → Flag if Zone 1 heavy (>60%) → Identify Zone 2 opportunities

**Builder focus:** What should we build differently so the work compounds instead of caps out?

---

### Assessment 4: AI High Ground

**Core Question:** Are we positioned on high ground or in the flood zone?

**Reference:** `references/framework-ai-high-ground.md`

**What this lens evaluates:**

| Letter | Question | Red Flag |
|--------|----------|----------|
| **R** – Revenue | Real paying customers? | "We're still piloting" |
| **A** – Acceleration | Ship something real in 2 weeks? | No clear path to ship fast |
| **I** – In-market | Real users with real data? | Sitting in test environment |
| **L** – Learning | Learning from real customer use? | Internal testing only |

**Scoring:** 0-1 ❌ = High ground | 2+ ❌ = Flood zone

**Builder focus:** If in flood zone, what's the fastest path to high ground? Apply Three-Layer Map for positioning. Project competitive moat timeline.

---

## Anti-Patterns

- Evaluating like a report card instead of building a trade thesis
- Running all four assessments when user only needs one
- Skipping MC data extraction or market research
- Declaring something "working" when only internal use exists
- Vague actions ("improve signals" vs specific net to implement)
- Actions that don't tie back to the thesis
- Treating all work as equal (Zone 1 vs Zone 2 matters)
- Ignoring signals against the thesis

---

## Reference Files

| File | Purpose | When to Read |
|------|---------|--------------|
| `references/framework-four-loops-ai-wealth.md` | Four Loops framework details | Before running Four Loops assessment |
| `references/framework-ai-flywheel-tools.md` | Flywheel framework details | Before running Flywheel assessment |
| `references/framework-dangerous-intelligence.md` | Dangerous Intelligence framework details | Before running Dangerous Intelligence assessment |
| `references/framework-ai-high-ground.md` | AI High Ground framework details | Before running AI High Ground assessment |
| `references/alignment-template.md` | Assessment output template | Before producing any assessment output |
