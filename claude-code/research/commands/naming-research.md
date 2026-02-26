---
description: "Research and evaluate product/project name candidates with scoring matrix"
argument-hint: "<project-slug> <notes>"
disable-model-invocation: true
---

# /naming-research

Research product/project name candidates and produce a ranked recommendation.

## What This Does

Evaluates name candidates across brand strength, namespace cleanliness, trademark risk, semantic clarity, scalability, SEO potential, and CLI ergonomics. Uses web research to verify each candidate. Produces a scored matrix with a confirmed winner.

## Resources

**Read these for guidance**:
- `~/.claude/skills/research/SKILL.md` - Research skill overview
- `~/.claude/skills/research/references/naming-research-guide.md` - Detailed process and evaluation criteria
- `~/.claude/skills/research/assets/templates/naming-research.md` - Output template

## Input

**Arguments (required):** Project slug and notes describing the product.

```
{{arguments}}
```

**Context docs (auto-detected):**
- If `docs/[slug]-vision.md` exists → Read for problem statement, value proposition, target user
- If `docs/[slug]-architecture.md` exists → Read for technical surfaces (CLI, imports, MCP, URLs)

## Key Requirements

- **NO CODE** - This is research only
- **VERIFY EVERYTHING** - Use WebSearch/WebFetch for every candidate. Do not guess namespace or trademark status.
- **DOCUMENT ELIMINATIONS** - The graveyard is as valuable as the recommendation

## Process

Follow the guidance in `naming-research-guide.md`:
1. Gather context from design docs and user notes
2. Define evaluation criteria (7 weighted criteria)
3. Generate or collect 10-15 candidates
4. Research each candidate thoroughly (namespace, trademark, domain, SEO, phonetics)
5. Eliminate candidates with fatal conflicts
6. Score survivors on 5-star scale
7. Write the report using the template

## Output

Create `docs/naming-research.md` using the template.

## After Completion

User reviews the recommendation, then either confirms the name or requests a second round with additional candidates.
