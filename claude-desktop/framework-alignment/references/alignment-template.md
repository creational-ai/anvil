# Assessment Templates

Polymorphic template structure: Base template (trade thesis + roadmap) + framework-specific sections.

---

## Base Template (All Assessments)

Every assessment follows this structure:

```markdown
# [Project Name]: [Framework Name] Assessment

> **Version:** 1.0  
> **Created:** [Date]  
> **Project Phase:** [Current phase from MC]

---

## Market Read

[What's happening in the space. Conditions, patterns, signals from web research.]

---

## The Trade

| Element | Detail |
|---------|--------|
| **Betting on** | [The specific position we're building toward] |
| **Thesis** | [Why we believe this pays off] |
| **Edge** | [What compounds in our favor, what's hard to replicate] |
| **Signals supporting** | [Real data points for the thesis] |
| **Signals against** | [What could invalidate the thesis] |

---

## Framework Alignment Check

[Framework-specific sections — see breakout below]

---

## Critical Path

[Ordered by dependency and leverage]

| # | Action | Unblocks | Justification |
|---|--------|----------|---------------|
| 1 | [Action] | [What] | [Ties to thesis/framework how] |
| 2 | [Action] | [What] | [Ties to thesis/framework how] |

---

## Specific Actions

### Immediate (this week)
- [ ] [Concrete action tied to framework requirement]
- [ ] [Concrete action tied to framework requirement]

### Next (following week)
- [ ] [Concrete action]
- [ ] [Concrete action]

### After (when prerequisites done)
- [ ] [Concrete action]
- [ ] [Concrete action]

---

## Thesis Check

| Element | Assessment |
|---------|------------|
| **Conviction level** | [High / Medium / Low] |
| **What would change our mind** | [Invalidation criteria] |
| **Reassess when** | [Trigger for re-evaluation] |
```

---

## Framework-Specific Breakouts

Each breakout below replaces the `[Framework-specific sections]` placeholder in the base template.

---

### Four Loops Breakout

```markdown
## Framework Alignment Check

### Summary

| Loop | Required | Have | Gap | Status |
|------|----------|------|-----|--------|
| Loop 1: Balance | [What framework requires] | [What exists] | [Delta] | [❌/⚠️/✅] |
| Loop 2: Speed to Revenue | [What framework requires] | [What exists] | [Delta] | [❌/⚠️/✅] |
| Loop 3: Signal to Innovation | [What framework requires] | [What exists] | [Delta] | [❌/⚠️/✅] |
| Loop 4: Sweat Equity | [What framework requires] | [What exists] | [Delta] | [❌/⚠️/✅] |

---

### Loop 1: Balance (Advantage ↔ Pain)

**Required:** Clear asymmetric advantage balanced against validated acute pain, with active assumption testing.

| Aspect | Required | Have | Gap |
|--------|----------|------|-----|
| Asymmetric Advantage | [What we need to claim] | [What exists / validated?] | [What to build/validate] |
| Acute Pain | [Specific pain to solve] | [Validated or assumed?] | [What to test] |
| Assumption Testing | [Active testing loop] | [How are we testing?] | [What net to build] |

**Build items:** [Specific things to build to close this gap]

---

### Loop 2: Speed to Revenue (Ship → Learn)

**Required:** Rapid shipping velocity with external learning loops capturing signal.

| Aspect | Required | Have | Gap |
|--------|----------|------|-----|
| Shipping velocity | [Target cadence] | [From task timestamps] | [Delta] |
| Dogfooding | [Using own product] | [Yes/No + evidence] | [What's missing] |
| External learning | [Real user signal] | [Internal only / external?] | [What net to build] |

**Build items:** [Specific things to build to close this gap]

---

### Loop 3: Signal to Innovation (User → Improve)

**Required:** Signal sources built into the product that feed back into product decisions.

| Question | Required | Have |
|----------|----------|------|
| Where do signals come from? | [What sources needed] | [Source or "None yet"] |
| How often reviewed? | [Target frequency] | [Current or "N/A"] |
| What loops are built in? | [What loops needed] | [List or "None"] |

**Nets to build:**

| Net | Purpose | Status | Priority |
|-----|---------|--------|----------|
| Usage Analytics | [What it captures] | [❌/⚠️/✅] | [P0/P1/P2] |
| submit_feedback | [What it captures] | [❌/⚠️/✅] | [P0/P1/P2] |
| Cohort Tracking | [What it captures] | [❌/⚠️/✅] | [P0/P1/P2] |

**Build items:** [Specific things to build to close this gap]

---

### Loop 4: Sweat Equity (Conviction)

| Indicator | Evidence |
|-----------|----------|
| Deep work sessions | [From task timestamps] |
| Quality of execution | [Assessment] |

**Status:** [Usually ✅ if work exists — verify from MC timestamps]
```

---

### Flywheel Breakout

```markdown
## Framework Alignment Check

### Summary

| Stage | Required | Have | Gap | Feeds Next? | Status |
|-------|----------|------|-----|-------------|--------|
| Lead Gen | [What's needed] | [What exists] | [Delta] | [Yes/No/Broken] | [❌/⚠️/✅] |
| Nurturing | [What's needed] | [What exists] | [Delta] | [Yes/No/Broken] | [❌/⚠️/✅] |
| Closing | [What's needed] | [What exists] | [Delta] | [Yes/No/Broken] | [❌/⚠️/✅] |
| Delivery | [What's needed] | [What exists] | [Delta] | [Yes/No/Broken] | [❌/⚠️/✅] |
| Reputation | [What's needed] | [What exists] | [Delta] | [Yes/No/Broken] | [❌/⚠️/✅] |

---

### Lead Gen

**Required:** [What the framework says we need for discovery + signal capture]

**Have:** [What exists]

**Gap / Build items:** [Specific things to build]

---

### Nurturing

**Required:** [What the framework says we need for warming + signal capture]

**Have:** [What exists]

**Gap / Build items:** [Specific things to build]

---

### Closing

**Required:** [What the framework says we need for conversion + signal capture]

**Have:** [What exists]

**Gap / Build items:** [Specific things to build]

---

### Delivery

**Required:** [Working product WITH signal infrastructure]

**Have:** [What exists]

**Gap / Build items:** [Specific things to build]

---

### Reputation

**Required:** [How success spreads + signal capture]

**Have:** [What exists]

**Gap / Build items:** [Specific things to build]

---

### Broken Connections

| From → To | Issue | Build to Fix |
|-----------|-------|--------------|
| [Stage] → [Stage] | [What's broken/missing] | [Specific build item] |

---

### Nets to Build

| Net | Purpose | Status | Priority |
|-----|---------|--------|----------|
| Onboarding Funnel | Where users drop off | [❌/⚠️/✅] | [P0/P1/P2] |
| Churn Signals | Activity drop detection | [❌/⚠️/✅] | [P0/P1/P2] |
| Error Tracking | Know when things break | [❌/⚠️/✅] | [P0/P1/P2] |
```

---

### Dangerous Intelligence (Zone Analysis) Breakout

```markdown
## Framework Alignment Check

### Summary

| Metric | Value |
|--------|-------|
| Zone 2 (Uncapped) | [X%] |
| Zone 1 (Capped) | [Y%] |
| Assessment | [Healthy (>40% Zone 2) / Needs rebalancing] |

---

### Zone 2 (Uncapped) Work — What We Should Be Building

| Work Item | Why Zone 2 | Status |
|-----------|------------|--------|
| [Task/feature] | [Compounds because...] | [Built/Planned/Missing] |

---

### Zone 1 (Capped) Work — Necessary but Doesn't Compound

| Work Item | Why Zone 1 | Can Elevate? |
|-----------|------------|--------------|
| [Task/feature] | [Fixed value because...] | [Yes — how / No] |

---

### Zone 2 Opportunities — What to Build Differently

| Item | Current Zone | How to Make Zone 2 |
|------|--------------|-------------------|
| [Item] | 1 | [Specific change to make it compound] |

---

### Recommendations

**To shift ratio toward Zone 2:**

1. [Specific build recommendation]
2. [Specific build recommendation]
3. [Specific build recommendation]
```

---

### AI High Ground Breakout

```markdown
## Framework Alignment Check

### RAIL Test

| Letter | Question | Required | Have | Status |
|--------|----------|----------|------|--------|
| **R** – Revenue | Real paying customers? | [What's needed] | [Current state] | [✅/❌] |
| **A** – Acceleration | Ship real in 2 weeks? | [What's needed] | [Current state] | [✅/❌] |
| **I** – In-market | Real users, real data? | [What's needed] | [Current state] | [✅/❌] |
| **L** – Learning | Learning from customer use? | [What's needed] | [Current state] | [✅/❌] |

**Score:** [X] of 4 passing
**Status:** [On High Ground (0-1 ❌) / In Flood Zone (2+ ❌)]

---

### Layer Positioning

| Layer | Description | Our Position | Assessment |
|-------|-------------|--------------|------------|
| Infrastructure | Fabs, cloud, energy | [Position] | [Skip unless massive capital] |
| Frontier Models | ChatGPT, Claude, Gemini | [Position] | [Don't start me-too] |
| Apps & Services | Interface, solution, implementation | [Position] | [This is where to focus] |

**Build toward:** [Specific layer 3 position — horizontal/vertical/services + reasoning]

---

### Path to High Ground

*(Include if in flood zone — what to build to get out)*

| # | Action | Why Urgent | Timeline |
|---|--------|------------|----------|
| 1 | [Specific build item] | [Gets us R/A/I/L] | [This week] |
| 2 | [Specific build item] | [Gets us R/A/I/L] | [Next week] |

---

### Competitive Moat Timeline

| Month | What We'll Have | Competitor Starting Now |
|-------|-----------------|------------------------|
| 0 (Now) | [Current state] | Building from scratch |
| 1 | [What we're building toward] | Still building infrastructure |
| 3 | [Projection] | Starting to collect data |
| 6 | [Projection] | 6 months behind on insights |
```
