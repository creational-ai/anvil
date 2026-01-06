# /design-architecture

Create technical architecture and integration plan.

## What This Does

Stage 2 of dev-design: Design system architecture without writing code.

## Resources

**Read these for guidance**:
- `~/.claude/skills/dev-design/SKILL.md` - See "Stage 2: Architecture" section
- `~/.claude/skills/dev-design/references/2-architecture-guide.md` - Detailed process
- `~/.claude/skills/dev-design/assets/templates/architecture.md` - Output template

## Input

**First argument (required):**
- Path to north-star.md (e.g., `docs/north-star.md`)

**User notes (optional):**
```
{{notes}}
```

**Mode Detection:**
- If `docs/[name]-architecture.md` exists → Update mode (refine existing document)
- Otherwise → Create mode (new document from north star)

**Output naming:**
- Derives `[name]` from north-star.md content or user notes
- Creates/updates `docs/[name]-architecture.md`

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

Create `[name]-architecture.md` using the template.

## After Completion

Run `/verify-doc [name]-architecture.md` to validate, then proceed to Stage 3: Milestones Overview.
