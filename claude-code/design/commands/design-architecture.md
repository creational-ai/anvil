---
description: "Create architecture and integration plan (Stage 2 of design skill)"
argument-hint: "<path-to-vision>"
disable-model-invocation: true
---

# /design-architecture

Create technical architecture and integration plan.

## What This Does

Stage 2 of design skill: Design system architecture without writing code.

## Resources

**Read these for guidance**:
- `~/.claude/skills/design/SKILL.md` - See "Stage 2: Architecture" section
- `~/.claude/skills/design/references/2-architecture-guide.md` - Detailed process
- `~/.claude/skills/design/assets/templates/2-architecture.md` - Output template

## Input

**First argument (required):**
- Path to vision (e.g., `docs/mc-vision.md`)

**User notes (optional):**
```
{{notes}}
```

**Mode Detection:**
- If `docs/[slug]-architecture.md` exists → Update mode (refine existing document)
- Otherwise → Create mode (new document from product vision)

**Output naming:**
- Uses same `[slug]` as product vision (e.g., `mc`)
- Creates/updates `docs/[slug]-architecture.md`

## Key Requirements

⛔ **NO CODE** - This is architecture only (diagrams, flows, descriptions)

## Process

Follow the guidance in `2-architecture-guide.md`:
1. Define system architecture
2. Identify technology stack
3. Map data flows
4. Design component interactions
5. Identify integration points

## Output

Create `docs/[slug]-architecture.md` using the template (e.g., `docs/mc-architecture.md`).

## After Completion

Run `/verify-doc docs/[slug]-architecture.md` to validate, then proceed to Stage 3: Roadmap.
