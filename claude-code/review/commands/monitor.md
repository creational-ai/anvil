---
description: Monitor execution progress with periodic status reports. Read-only observation. Terminates on its own — when every step completes, or when the idle bound expires and it escalates.
argument-hint: <task-slug>
disable-model-invocation: false
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

- **Argument (required)**: Task slug. Derives these input paths (read-only):
  - `docs/[slug]-plan.md`
  - `docs/[slug]-design.md`
  - `docs/[slug]-results.md`
  - `docs/[slug]-plan-review.md`
  - `docs/[slug]-design-review.md`
  - `docs/[slug]-expectations.md` (optional)

## Output

- `docs/[slug]-monitor-issues.md` — issue log, lazy-created on first verifiable issue (see guide § Issue Logging for lifecycle and write mechanics)

## Process

1. Read the guide (Monitor Mode section)
2. Read all existing docs, build step-to-design-item mapping
3. Report initial status
4. Set up periodic timer (every 4 minutes; first tick is 8 minutes per the 2× first-arm rule — see guide § Set Up Timer)
5. On each tick: report status, analyze newly completed steps
6. Continue until all steps complete, the user says stop, or the idle bound expires — 8 consecutive no-change checks ends the watch and reports an escalation, without prompting (guide § Termination)

Read the guide. Follow it exactly.
