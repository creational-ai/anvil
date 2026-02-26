# research

Research capabilities for product validation and naming decisions.

## Commands

- `/market-research` - Market validation with Go/Pivot/Kill recommendation
- `/naming-research` - Research and evaluate product/project name candidates
- `/spawn-market-researcher` - Market research agent (background)
- `/spawn-naming-researcher` - Naming research agent (background)

## When to Use

**Market Research**:
- When you have enough product context to validate (vision, target market, approach)
- Before committing significant resources to a product idea
- When evaluating a new market opportunity
- When pivoting and need to validate new direction

**Naming Research**:
- When naming a new product or project
- When evaluating name candidates for brand strength, namespace, and trademark risk
- When rebranding or renaming an existing product

---

## Prerequisites

**Required capability**: Web search enabled

**Context** (in priority order):
1. Mission Control MCP project data (preferred)
2. Product docs in project
3. User-provided information

→ See `references/market-research-guide.md` "Before You Start: Context Extraction" for the full extraction process, MCP fields, and fallback order.

---

## Core Questions Answered

1. **Market Validation** — Is this a real problem worth solving?
2. **Competitive Landscape** — Who else is solving this? What are the gaps?
3. **Positioning & Edge** — How do we differentiate? Can we defend it?
4. **Target Customer** — Who are the first 200 users? Where are they?
5. **Go-to-Market** — How do we reach them?
6. **Pricing & Economics** — What can we charge? Does it work financially?
7. **Recommendation** — Go / Pivot / Kill?

---

## ⛔ CRITICAL: RESEARCH RULES

### Web Search Required

This skill requires active web research. Do NOT rely solely on training knowledge for:
- Market size data
- Competitor information
- Pricing data
- Current trends

**Search thoroughly** — expect 20-30+ searches for comprehensive analysis.

### Evidence-Based

Every claim needs backing:
- Market size → cite source
- Competitor info → cite source
- Trends → cite source
- If data unavailable → explicitly state "not found" rather than guess

### Decision-Ready Output

The output must enable a clear Go/Pivot/Kill decision. Avoid:
- Wishy-washy conclusions
- "It depends" without specifics
- Missing recommendation

---

## 🎯 Philosophy: First 200 Users

Align with the 200-users-first mindset:
- Focus on **reachable** market (SOM), not just total market (TAM)
- Identify **specific** channels to reach first 200 paying users
- Validate pricing that works for **early adopters**, not mass market
- Assess if we can **win a niche** before expanding

---

## Research Process

7-phase process: Context Extraction → Market Landscape → Competitive Deep Dive → Positioning → Customer & Channel → Pricing & Economics → Synthesis & Recommendation.

→ See `references/market-research-guide.md` for the full process, search strategies, and verification checklist.

---

## Output

**Template**: `assets/templates/market-research.md`
**Output file**: `docs/[slug]-market-research.md`

---

## Reference Guides

| When to Read | Reference File |
|--------------|----------------|
| Starting market research or need search strategies | `references/market-research-guide.md` |
| Naming a product or project | `references/naming-research-guide.md` |
