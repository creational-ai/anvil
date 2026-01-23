# Business Validation PoC Examples

Real examples of business validation PoCs with success criteria.

---

## Distribution Signal PoCs

### Example: Directory Presence

**Context:** MCP tool needs to validate if ecosystem has demand.

```
PoC: MCP Directory Presence

Assumption tested: MCP ecosystem has demand for paid tools

Objective: List product on all major directories and measure organic discovery over 30 days.

Actions:
- Submit to Smithery.ai, mcp.so, mcpservers.org
- Submit to GitHub awesome-mcp-servers lists
- Track unique users via analytics

Success Criteria:

| Outcome | Users in 30 Days | Interpretation | Next Step |
|---------|------------------|----------------|-----------|
| Strong signal | 100+ | Demand exists | Proceed to monetization PoCs |
| Moderate signal | 50-99 | Weak but present | Parallel test API marketplace |
| Weak signal | 10-49 | Ecosystem too small | Pivot to API/web-first |
| No signal | <10 | No organic discovery | Evaluate kill criteria |

Effort: 1-2 days
Dependencies: Product deployed and functional
```

---

### Example: First Content Piece

**Context:** Testing if content can drive traffic to tools.

```
PoC: First Content Piece

Assumption tested: Content drives traffic to tools

Objective: Publish one technical story, measure if it drives signups.

Actions:
- Write build story using actual project data
- Publish on devlog or dev.to
- Include CTA with UTM tracking
- Measure views and conversions

Success Criteria:

| Outcome | Views | Signups | Interpretation | Next Step |
|---------|-------|---------|----------------|-----------|
| Strong signal | 500+ | 10+ | Content works | Commit to content flywheel |
| Moderate signal | 100-499 | 5-9 | Works, needs optimization | Test different platforms |
| Weak signal | 20-99 | 1-4 | Distribution problem | Rethink platform choice |
| No signal | <20 | 0 | Strategy flawed | Deprioritize content |

Effort: 2-3 days
Dependencies: Publishing platform, product to link to
```

---

## Demand Signal PoCs

### Example: Landing Page + Waitlist

**Context:** Testing if value proposition resonates.

```
PoC: Landing Page + Waitlist

Assumption tested: Messaging resonates with target audience

Objective: Simple landing page with email capture, measure conversion rate.

Actions:
- Build minimal page: hero, value prop, email form
- Drive traffic from existing channels
- Track visitor-to-signup conversion

Success Criteria:

| Outcome | Conversion Rate | Interpretation | Next Step |
|---------|-----------------|----------------|-----------|
| Strong signal | 8%+ | Messaging resonates strongly | Proceed to monetization |
| Moderate signal | 3-7% | Works, room to optimize | A/B test variations |
| Weak signal | 1-2% | Value prop unclear | Revise positioning |
| No signal | <1% | Fundamental problem | User interviews needed |

Effort: 1-2 days
Dependencies: Domain, hosting, traffic source
```

---

### Example: API Marketplace Listing

**Context:** Testing developer demand separate from consumer demand.

```
PoC: API Marketplace Listing

Assumption tested: Developers pay more than consumers

Objective: List API on RapidAPI, measure developer interest.

Actions:
- Create RapidAPI listing with free + paid tiers
- Document API endpoints
- Track signups and conversions

Success Criteria:

| Outcome | Free Users | Paid Conversions | Interpretation | Next Step |
|---------|------------|------------------|----------------|-----------|
| Strong signal | 50+ | 3+ | Developer demand validated | Consider B2B focus |
| Moderate signal | 20-49 | 1-2 | Some demand | Improve DX, docs |
| Weak signal | 5-19 | 0 | Low discoverability | Deprioritize API channel |
| No signal | <5 | 0 | Developers not here | Focus other channels |

Effort: 2-3 days
Dependencies: REST API functional
```

---

## Conversion Signal PoCs

### Example: Manual Monetization Test

**Context:** Testing willingness to pay before building billing.

```
PoC: Manual Monetization Test

Assumption tested: Users will pay for this product

Objective: Offer paid access to waitlist, validate conversion without billing infrastructure.

Actions:
- Email waitlist with limited early access offer
- Use Stripe Payment Link (no code)
- Manually provision access for paying users
- Track conversion rate and objections

Success Criteria:

| Outcome | Conversions | Rate | Interpretation | Next Step |
|---------|-------------|------|----------------|-----------|
| Strong signal | 5+ | 10%+ | Model validated | Build billing infrastructure |
| Moderate signal | 2-4 | 4-9% | Works, optimize | Test pricing/messaging |
| Weak signal | 1 | 1-3% | Niche interest only | Identify who, double down |
| No signal | 0 | 0% | Price/value mismatch | User interviews, pivot |

Effort: 1 day
Dependencies: Waitlist with 50+ emails, Stripe account
```

---

### Example: Bundle Interest Test

**Context:** Testing if suite positioning increases conversion.

```
PoC: Bundle Interest Test

Assumption tested: Bundle increases conversion over standalone

Objective: Test if "suite" positioning performs better than single product.

Actions:
- A/B test landing page: standalone vs bundle messaging
- Or survey waitlist about bundle interest
- Track conversion difference

Success Criteria:

| Outcome | Bundle Lift | Interpretation | Next Step |
|---------|-------------|----------------|-----------|
| Strong signal | 30%+ higher | Bundle is the strategy | Build toward suite |
| Moderate signal | 10-29% | Helps, not decisive | Keep testing |
| No signal | <10% or negative | Bundle doesn't matter | Keep tools independent |

Effort: 1-2 days
Dependencies: Waitlist for survey, A/B capability for page test
```

---

## Scale Signal PoCs

### Example: Content Flywheel Test

**Context:** Testing if content compounds over time.

```
PoC: Content Flywheel Test

Assumption tested: Content drives sustainable growth

Objective: Publish 4 pieces over 4 weeks, measure if traffic compounds.

Actions:
- Week 1: Technical build story
- Week 2: Methodology/process piece
- Week 3: Deep-dive tutorial
- Week 4: Meta/thought leadership
- Track cumulative traffic and signups

Success Criteria:

| Outcome | Week 4 vs Week 1 | Cumulative Signups | Interpretation | Next Step |
|---------|------------------|-------------------|----------------|-----------|
| Strong signal | 2x+ traffic | 30+ | Flywheel working | Commit to weekly content |
| Moderate signal | 1.3-2x | 15-29 | Starting | Continue, optimize |
| Weak signal | Flat | 5-14 | No compounding | Rethink topics/distribution |
| No signal | Declining | <5 | Not working | Deprioritize content |

Effort: 4 weeks (1 piece/week)
Dependencies: Publishing platform, first piece done
```

---

## PoC Design Principles

1. **One assumption per PoC** — Don't test multiple things at once
2. **Measurable outcomes** — Every PoC needs numbers, not vibes
3. **Four-tier criteria** — Strong/Moderate/Weak/No signal with clear thresholds
4. **Next step defined** — Each outcome leads to a specific action
5. **Effort estimated** — Know the cost before committing
6. **Dependencies explicit** — Know what blocks starting
