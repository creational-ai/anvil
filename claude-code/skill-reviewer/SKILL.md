# skill-reviewer

Audit a Claude Code skill for structural correctness, frontmatter validity, cross-reference integrity, architecture hierarchy, and convention consistency.

## Overview

This skill codifies the process of reviewing a skill for quality and consistency. It checks that all files follow the correct patterns, that references between files are valid, and that the architecture hierarchy is properly maintained.

## Architecture Hierarchy

Every skill should follow this layered architecture:

| Layer | Role | Contains |
|-------|------|----------|
| **Guide** (reference) | Source of truth | All logic, instructions, process, rules |
| **Template** (asset) | Output formatting | Document structure for generated output (only when command produces a doc) |
| **Command** | Thin wrapper | Points to guide, says "read the guide, follow it exactly" |
| **Agent** | Thin wrapper of command | Loads the guide, follows it. No duplicated logic. |

Logic lives in guides. Commands and agents are wrappers that reference guides. Templates are for output formatting only.

## Quick Reference

| Resource | Path |
|----------|------|
| Review Guide | `references/skill-review-guide.md` |
| Report Template | `assets/templates/skill-review-report.md` |

## Commands

- `/skill-review <skill-name>` - Audit a skill (main conversation)
- `/agent-skill-review <skill-name>` - Audit a skill (background agent)

## What Gets Checked

8 categories, run in order:

1. **Structure** - SKILL.md exists, directories present, naming correct
2. **Command Frontmatter** - Required YAML fields, agent command fields
3. **Agent Frontmatter & Structure** - Required fields, consistent section pattern
4. **Architecture Hierarchy** - Guide is source of truth, commands/agents are thin wrappers
5. **Cross-Reference Integrity** - All file references resolve, SKILL.md ↔ commands match
6. **Input/Output Chain** - Stage outputs match next stage inputs, no dead ends
7. **Terminology & Format** - Consistent terms, timestamps, status indicators
8. **Convention Compliance** - No hardcoded values in templates, no stale references
