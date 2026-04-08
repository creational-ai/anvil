---
description: Monitor execution progress with periodic status reports. Read-only observation.
argument-hint: <task-slug>
disable-model-invocation: true
---

# /monitor

Monitor active execution by periodically reading results, plan, design, and review docs. Reports status and performs per-step analysis as steps complete. Strictly read-only.

**Guide**: `~/.claude/skills/review/references/exam-guide.md`

## Usage

```bash
/monitor core-settings-redesign
/monitor core-poc6
```

## Input

- **Argument (required)**: Task slug. Derives all doc paths:
  - `docs/[slug]-plan.md`
  - `docs/[slug]-design.md`
  - `docs/[slug]-results.md`
  - `docs/[slug]-plan-review.md`
  - `docs/[slug]-design-review.md`
  - `docs/[slug]-expectations.md` (optional)

## Process

1. Read the guide (Monitor Mode section)
2. Read all existing docs, build step-to-design-item mapping
3. Report initial status
4. Set up periodic timer (every 2 minutes)
5. On each tick: report status, analyze newly completed steps
6. Continue until all steps complete or user says stop

Read the guide. Follow it exactly.
