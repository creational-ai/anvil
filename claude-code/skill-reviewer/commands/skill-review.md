---
description: Audit a skill for structural correctness, frontmatter, architecture hierarchy, cross-references, and consistency. Runs in main conversation.
argument-hint: <skill-name>
disable-model-invocation: true
---

# /skill-review

Audit a Claude Code skill for quality and consistency.

## Resources

**Read these for guidance**:
- `~/.claude/skills/skill-reviewer/references/skill-review-guide.md` - Complete validation rules
- `~/.claude/skills/skill-reviewer/assets/templates/skill-review-report.md` - Report format

## Input

**Argument (required):** Skill name or path to skill directory.

Parse the skill name from the argument. It may be:
- A bare name: `dev`, `market-research`
- A path: `claude-code/dev`, `claude-code/skill-reviewer`
- A path with `@` prefix: `@claude-code/dev`

Extract the skill name from the last path segment (e.g., `claude-code/skill-reviewer` → `skill-reviewer`).

Resolves to: `claude-code/[skill-name]/` in the project root.

**Examples:**
```bash
/skill-review dev
/skill-review @claude-code/market-research
```

## Process

Read the guide. Follow it exactly.

## Output

Review report displayed to user with:
- Summary table (8 checks, pass/fail)
- Issues listed by severity (HIGH / MEDIUM / LOW)
- Verdict (Clean or issues found)
