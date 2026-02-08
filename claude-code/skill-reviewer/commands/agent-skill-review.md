---
description: Audit a skill for structure, frontmatter, architecture, and consistency as a background agent
argument-hint: <skill-name>
context: fork
agent: skill-review-agent
disable-model-invocation: true
---

Audit a Claude Code skill using the skill-review-agent.

**Skill to review**: $ARGUMENTS

Parse the skill name from the argument. It may be:
- A bare name: `dev`, `market-research`
- A path: `claude-code/dev`, `claude-code/skill-reviewer`
- A path with `@` prefix: `@claude-code/dev`

Extract the skill name from the last path segment (e.g., `claude-code/skill-reviewer` → `skill-reviewer`). Do NOT ask the user to clarify — start immediately.

**Example**:
- `/agent-skill-review dev`
- `/agent-skill-review @claude-code/market-research`
