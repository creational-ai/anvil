---
description: "Create or refine Vision document (Stage 1 of design skill)"
argument-hint: "<notes>"
disable-model-invocation: true
---

# /design-vision

Refine an idea into a clear, feasible Vision.

## What This Does

Stage 1 of design skill: Transform rough ideas into structured vision documents.

## Resources

**Read these for guidance**:
- `~/.claude/skills/design/SKILL.md` - See "Stage 1: Vision" section
- `~/.claude/skills/design/references/1-vision-guide.md` - Detailed process
- `~/.claude/skills/design/assets/templates/1-vision.md` - Output template

## Input

**User notes (required for create mode, optional for update):**
```
{{notes}}
```

**Mode Detection:**
- If `docs/[slug]-vision.md` exists → Update mode (refine existing document based on user notes)
- Otherwise → Create mode (new document from user's idea/notes)

## Key Requirements

⛔ **NO CODE** - This is vision only (concepts, not implementation)

## Process

Follow the guidance in `1-vision-guide.md`:
1. Understand the core problem being solved
2. Define how it would work (high-level)
3. Identify key components and their relationships
4. Surface assumptions and unknowns

## Output

Create `docs/[slug]-vision.md` using the template (e.g., `docs/mc-vision.md`).

## After Completion

User will review the Vision doc, then proceed to Stage 2: Architecture.
