# Framework Alignment Template

Use this structure when producing alignment documents.

---

```markdown
# [Project Name]: Framework Alignment

> **Version:** 1.0  
> **Created:** [Date]  
> **Project Phase:** [Current phase from MC]

---

## Strategic Context

**The Moat Thesis:**
[Explain why signal infrastructure matters for this specific project. What can competitors copy? What can't they copy?]

**Current State:**
- Phase: [from MC]
- Status: [from MC]
- Key milestone: [current active milestone]
- Completed tasks: [X of Y]

---

## Framework Summary

| Framework | Core Question | Project Status |
|-----------|---------------|----------------|
| **Four Loops** | Building compounding feedback loops? | [✅/⚠️/❌] |
| **Flywheel** | Each stage feeds the next? | [✅/⚠️/❌] |
| **Dangerous Intelligence** | Focused on Zone 2 (uncapped) work? | [✅/⚠️/❌] |

---

## Four Loops Assessment

### Loop 1: Balance (Advantage ↔ Pain)

| Aspect | Status | Evidence |
|--------|--------|----------|
| Asymmetric Advantage | [Claimed/Validated] | [What is it?] |
| Acute Pain | [Assumed/Validated] | [What pain? For whom?] |
| Assumption Testing | [Active/Inactive] | [How are we testing?] |

**Net Required:** [What captures validation signal?]

**Gap:** [What's missing?]

---

### Loop 2: Speed to Revenue (Ship → Learn)

| Metric | Value | Assessment |
|--------|-------|------------|
| Shipping velocity | [From task timestamps] | [Good/Needs work] |
| Dogfooding | [Yes/No] | [Evidence] |
| Learning source | [Internal only/External users] | [Blocker if internal only] |

**Net Required:** [What captures learning signal?]

**Gap:** [What's missing?]

---

### Loop 3: Signal to Innovation (User → Improve)

| Question | Current Answer |
|----------|----------------|
| Where do signals come from? | [Source or "None yet"] |
| How often reviewed? | [Frequency or "N/A"] |
| What loops are built in? | [List or "None"] |

**Net Required:** [Multiple nets needed here]

**Gap:** [What's missing?]

---

### Loop 4: Sweat Equity (Conviction)

| Indicator | Evidence |
|-----------|----------|
| Deep work sessions | [From task timestamps] |
| Quality of execution | [Assessment] |
| Iteration on feedback | [Examples] |

**Status:** [Usually ✅ if other work exists]

---

## Flywheel Assessment

| Stage | Status | Signal Net | Gap |
|-------|--------|------------|-----|
| Lead Gen | [❌/⚠️/✅] | [Net or "None"] | [What's needed] |
| Nurturing | [❌/⚠️/✅] | [Net or "None"] | [What's needed] |
| Closing | [❌/⚠️/✅] | [Net or "None"] | [What's needed] |
| Delivery | [❌/⚠️/✅] | [Net or "None"] | [What's needed] |
| Reputation | [❌/⚠️/✅] | [Net or "None"] | [What's needed] |

**Key Insight:** Delivery isn't "working product" — it's "working product WITH signal infrastructure."

---

## Zone Analysis (Dangerous Intelligence)

### Recent/Planned Work Classification

| Work Item | Zone | Rationale |
|-----------|------|-----------|
| [Task/feature] | [1 or 2] | [Why] |
| [Task/feature] | [1 or 2] | [Why] |
| [Task/feature] | [1 or 2] | [Why] |

**Zone 2 (Uncapped) Examples:**
- Signal infrastructure architecture
- What we learn from (nets)
- Pricing/tier structure decisions
- Onboarding flow design

**Zone 1 (Capped) Examples:**
- Additional features beyond core
- UI polish
- Documentation
- Boilerplate code

**Current Ratio:** [X% Zone 2 / Y% Zone 1]

**Assessment:** [Healthy/Needs rebalancing]

---

## Net Inventory

| Net | Purpose | Status | Scope | Priority |
|-----|---------|--------|-------|----------|
| Usage Analytics | Track every action | [❌/⚠️/✅] | [What's needed] | [P0/P1/P2] |
| submit_feedback | Qualitative signal | [❌/⚠️/✅] | [What's needed] | [P0/P1/P2] |
| Cohort Tracking | Behavior by segment | [❌/⚠️/✅] | [What's needed] | [P0/P1/P2] |
| Feature Flags | A/B without deploys | [❌/⚠️/✅] | [What's needed] | [P0/P1/P2] |
| Churn Signals | Drop-off detection | [❌/⚠️/✅] | [What's needed] | [P0/P1/P2] |
| Error Tracking | Know when broken | [❌/⚠️/✅] | [What's needed] | [P0/P1/P2] |
| Onboarding Funnel | Setup drop-off | [❌/⚠️/✅] | [What's needed] | [P0/P1/P2] |

---

## Implementation Priorities

### P0 (Launch Blockers)
Without these, no signal loop starts.

| Net/Task | Why P0 | Effort |
|----------|--------|--------|
| [Item] | [Reason] | [Hours] |

### P1 (Week 1)
Needed to learn from first users.

| Net/Task | Why P1 | Effort |
|----------|--------|--------|
| [Item] | [Reason] | [Hours] |

### P2 (Month 1)
Needed for optimization.

| Net/Task | Why P2 | Effort |
|----------|--------|--------|
| [Item] | [Reason] | [Hours] |

### Defer
Nice to have, not day 1.

| Net/Task | Why Defer |
|----------|-----------|
| [Item] | [Reason] |

---

## Pre-Launch Checklist

### Signal Infrastructure
- [ ] Every tool/API call logged with latency and success/fail?
- [ ] Users can submit feedback without leaving product?
- [ ] User tier tagged on every event?
- [ ] First-run detection working?
- [ ] Errors include context (user_id, tool, params)?

### Flywheel Readiness
- [ ] Lead gen mechanism exists? (listing, website, etc.)
- [ ] Email/contact capture working?
- [ ] Payment mechanism ready? (if monetizing)
- [ ] Delivery automated?

### Loop Readiness
- [ ] Can query "which features used most"?
- [ ] Can query "where users drop off"?
- [ ] Can identify user segments?

---

## Post-Launch Signals to Watch

First 30 days, monitor:

| Signal | Where to Find | What It Tells You |
|--------|---------------|-------------------|
| Top 3 tools by usage | Usage Analytics | What actually matters |
| Onboarding completion rate | Onboarding Funnel | Setup friction |
| First tool used | Onboarding Funnel | Entry point pattern |
| Most common feedback | submit_feedback | What's broken/missing |
| Error frequency | Error Tracking | Reliability |
| Free → Pro conversion | Cohort Tracking | Willingness to pay |

---

## Competitive Moat Timeline

| Month | What We Have | Competitor Starting Now |
|-------|--------------|------------------------|
| 0 (Launch) | Nets in place, 0 data | Building nets from scratch |
| 1 | [X] events analyzed | Still building infrastructure |
| 3 | Patterns emerging, first pivots | Starting to collect data |
| 6 | Signal-informed v2, optimization | 6 months behind on insights |
| 12 | Product shaped by [Y] data points | Can't catch up |

---

## Success Definition

**Launch isn't:** "[Product] works"

**Launch is:** "[Product] works AND every user interaction feeds a signal loop that compounds into competitive moat"

**Minimum Viable Loop:**
```
[User action] 
    → [Net captures] 
    → [Pattern emerges] 
    → [Product decision] 
    → [Ship improvement] 
    → [More user action]
```

---

## Action Items

| Item | Priority | Owner | Status |
|------|----------|-------|--------|
| [Action] | [P0/P1/P2] | [Who] | [Todo/In Progress/Done] |

---

## Review Schedule

- [ ] Review after each milestone completion
- [ ] Update net status as implemented
- [ ] Re-assess priorities monthly
```
