---
name: business-validation
description: "Create business validation roadmaps that cut through noise to executable PoCs. Use when user asks about: monetization, go-to-market, pricing strategy, 'how do I make money with this', 'path to revenue', 'who would pay for this', 'how do I get users', 'is this worth pursuing', 'what's blocking me from launching', or any business model question. Extracts full context from Mission Control MCP (project → milestones → tasks) and project files, challenges assumptions, identifies real blockers, and produces a PoC-based validation roadmap with clear success criteria. Connects project success to broader organization goals (Creational.ai ecosystem)."
---

# business-validation

Transform project context into an executable business validation roadmap.

**Version**: 1.1.0

## Philosophy

**Apply PoC methodology to business validation.** Don't commit to a strategy based on assumptions — run experiments that prove or disprove those assumptions. The data tells you where to go.

**Challenge projections.** Revenue estimates like "$5K-15K MRR at 5% conversion of 5,000 users" are outputs, not inputs. Ask: Where do 5,000 users come from? What acquisition channel works? Will anyone pay before we build billing?

**Find the real blocker.** Often what looks like multiple parallel tasks is actually a single blocker gating everything else. Identify it, ship it, then everything else unblocks.

---

## When to Use

Natural triggers (how users actually ask):
- "How do I make money with this?"
- "What's the path to revenue?"
- "Who would pay for this?" / "Will anyone buy this?"
- "How do I get users?" / "Where do users come from?"
- "Is this worth pursuing?" / "Should I even try to monetize?"
- "What should I charge?" / "How do I price this?"
- "What's blocking me from launching?"
- "How do I turn this into a business?"
- "What's the GTM?" / "Go-to-market strategy"

Situational triggers:
- Project has technical foundation but unclear path to revenue
- Market research exists but lacks concrete acquisition strategy
- User is "going in circles" on business decisions (circling pattern)
- Project needs to connect to broader organization strategy

---

## Context Sources (Priority Order)

### 1. Mission Control MCP (Primary)

Extract from **all three tiers**:

| Tier | MCP Calls | Key Fields |
|------|-----------|------------|
| **Project** | `get_project(slug)` | objective, business_value, target_market, revenue_model, monthly_cost, projected_mrr, notes |
| **Milestones** | `list_milestones(project_slug)` | goal, status, risks, completed_at |
| **Tasks** | `list_tasks(project_slug)` | objective, unlocks, lessons_learned, status, created_at, started_at, completed_at |

**Why all three tiers:**
- **Project** = Vision, costs, revenue model
- **Milestones** = What's done, what's planned, what's blocked
- **Tasks** = Actual velocity, lessons learned, real execution data

### 2. Project Files

Check for existing documentation:
- Pricing strategy docs (`*-pricing*.md`)
- Market research (`*-market-research*.md`)
- Product guides, feature specs
- Architecture docs

### 3. Organization Context

Understand broader ecosystem:
- Other active projects (via `list_projects()`)
- Shared infrastructure
- Bundle/suite potential
- Content strategy connections

---

## Process

### Phase 1: Context Extraction

1. Pull full MC data (project, all milestones, all tasks)
2. Read relevant project files
3. Check other active projects for ecosystem context
4. Synthesize current state: What's built? What works? What's the velocity?

### Phase 2: Assumption Identification

Challenge every business assumption:

| Assumption Type | Challenge Question |
|-----------------|-------------------|
| "X users in Year 1" | Where do they come from? Which channel? |
| "Y% conversion rate" | Based on what? Industry average or validated? |
| "$Z ARPU" | Who pays this? Why? Compared to alternatives? |
| "Content drives traffic" | Proven? What content? What platform? |
| "Developers will pay" | More than consumers? Evidence? |

List assumptions that need validation.

### Phase 3: Blocker Analysis

Identify the dependency chain:

```
Everything user wants to do
        ↓
What gates it? (the real blocker)
        ↓
├── Activity A → needs blocker resolved
├── Activity B → needs blocker resolved
└── Activity C → needs blocker resolved
```

**Pattern:** If user keeps "circling back" to the same issue, that's the blocker.

### Phase 4: Traffic Reality Check

Estimate realistic acquisition by channel:

| Channel | Effort | Realistic Volume | Quality | Notes |
|---------|--------|------------------|---------|-------|
| [Channel] | Low/Med/High | X-Y users | Intent level | Constraints |

Sum to realistic Year 1 total. Compare against assumed projections.

### Phase 5: Strategic Paths

Define 2-4 distinct paths based on where validation might lead:

- **Path A**: [Strategy if assumption X proves true]
- **Path B**: [Strategy if assumption Y proves true]
- **Path C**: [Strategy if neither — fallback/pivot]
- **Path D**: [Kill criteria — when to stop]

### Phase 6: PoC Design

Create validation PoCs with clear success criteria:

```
PoC [N]: [Name]
├── Assumption tested: [Which assumption from Phase 2]
├── Objective: [What we're proving/disproving]
├── Actions: [Concrete steps]
├── Success criteria:
│   ├── Strong signal: [metric] → [interpretation] → [next step]
│   ├── Moderate signal: [metric] → [interpretation] → [next step]
│   ├── Weak signal: [metric] → [interpretation] → [next step]
│   └── No signal: [metric] → [interpretation] → [next step]
├── Effort: [Time estimate]
└── Dependencies: [What must exist first]
```

### Phase 7: Sequence & Blockers

Order PoCs to:
1. Resolve blockers first (P0)
2. Get cheapest signal earliest
3. Allow parallel execution where possible
4. Create decision tree for results

---

## Output Structure

Produce two artifacts:

### 1. Business Validation Roadmap

Sections:
- Executive Summary (blocker + path forward)
- Current State (from MC data)
- Assumptions to Validate (with challenge questions)
- Realistic Traffic Assessment
- Strategic Paths
- PoC Sequence (phased)
- Decision Framework (tree/flowchart)
- Prerequisites (what blocks what)
- Success Definition

→ See `references/roadmap-template.md` for full template

### 2. Blocker Spec (if P0 blocker identified)

Detailed implementation spec for the blocking item:
- What it is and why it blocks
- Minimum viable scope
- Technical approach
- Task breakdown with effort estimates
- Success criteria

→ See `references/blocker-spec-template.md` for full template

---

## Key Patterns

### The Circling Pattern

**Symptom:** User keeps returning to the same topic across conversations.

**Diagnosis:** That topic is the real blocker, not a parallel concern.

**Response:** Elevate to P0, spec it out, clear the path.

### The Projection Trap

**Symptom:** Revenue projections based on assumed user counts.

**Diagnosis:** Missing acquisition strategy.

**Response:** Work backwards — which channels, what volume realistically, then what revenue follows.

### The Ecosystem Leverage

**Symptom:** Project seems small in isolation.

**Diagnosis:** May have leverage as part of larger ecosystem.

**Response:** Check bundle potential, shared infrastructure, content flywheel connections.

---

## Verification Checklist

- [ ] MC data extracted (all three tiers)
- [ ] Project files reviewed
- [ ] Other active projects checked for ecosystem context
- [ ] All business assumptions listed and challenged
- [ ] Real blocker identified (if exists)
- [ ] Traffic estimates are channel-specific with realistic numbers
- [ ] Strategic paths defined with clear indicators
- [ ] Each PoC has measurable success criteria
- [ ] PoCs sequenced with dependencies clear
- [ ] Decision tree shows what to do with each outcome
- [ ] Prerequisites identified and ordered
- [ ] Blocker spec created (if P0 blocker exists)

---

## Reference Files

| When to Read | Reference File |
|--------------|----------------|
| Starting roadmap creation | `references/roadmap-template.md` |
| P0 blocker identified | `references/blocker-spec-template.md` |
| Need PoC design examples | `references/poc-examples.md` |

---

## Anti-Patterns

**Don't:**
- Accept revenue projections without acquisition strategy
- Produce roadmap without success criteria
- Skip MC data extraction
- Ignore the "circling" pattern
- Treat parallel items as equal priority when one blocks others
- Forget ecosystem/organization context
