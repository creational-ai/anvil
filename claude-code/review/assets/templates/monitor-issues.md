## Header (once per file)

```markdown
# <Task Name> Monitor — Issues

**Task slug**: <slug>
**Scope**: Issues flagged across monitor per-step analysis. See Legend for severity and scope semantics.
```

---

## Per-Session Block (one per `/monitor` run)

```markdown
## Session: <ISO 8601 start timestamp>

**Compiled from**: `/monitor <slug>` starting <ISO 8601 timestamp>
**Status**: Live — updated during monitor ticks

### Legend
<Severity and Scope definitions — see Legend section below>

### Summary Table
| # | Severity | Title | Scope |
|---|----------|-------|-------|

### Issue Details
<per-issue blocks>

---
**Session closed**: <ISO 8601 end timestamp> — <N> issue(s) logged
```

---

## Per-Issue Block

```markdown
#### #<n> — <Title>

**Severity**: HIGH | MED | LOW
**Scope**: In scope | Out of scope
**Location**: <file:line or doc section>
**Found**: <ISO 8601 tick timestamp>

**Description**:
<what's wrong — 1-3 sentences>

**Evidence**:
<quoted snippet, grep output, or doc excerpt proving the issue is real>

**Verification**:
<what the monitor did to confirm — e.g., "read src/foo.py:42", "grep -n X file.md", "cross-referenced plan.md:120 vs results.md:85">

**Suggested direction**:
<one brief line — pointer, not a patch>
```

---

## Legend (embed in every session block)

### Severity

**Severity is advisory** — it's the monitor's recommendation, not enforcement. The monitor never interrupts or blocks; the operator decides whether a HIGH finding warrants interrupting execution.

| Label | Meaning |
|-------|---------|
| HIGH | Blocks correctness, masks failures, or breaks the build |
| MED | Degrades quality, ergonomics, or maintainability. The code runs, but something is worse than it should be |
| LOW | Cosmetic, bookkeeping, or documentation-polish. No functional impact |

Project convention: uppercase `HIGH`/`MED`/`LOW`, never `Medium`/`H/M/L`.

### Scope

| Label | Meaning |
|-------|---------|
| In scope | The issue lives on a surface the current task is actively changing, OR was introduced by a step in the current plan, OR is a meta-observation about the task's own plan/design/review artifacts |
| Out of scope | The issue pre-exists the task AND lives on a surface the current plan doesn't touch, OR belongs to unrelated tooling/infrastructure. Logged for visibility; not a blocker for the current task |

**Boundary rules** (first match wins):

1. Issue location is in a file listed in the current plan's "Files to Modify" or affected-tests list → **In scope**
2. Issue was introduced by a step executed during this monitor run (regression) → **In scope**
3. Issue is about the task's own `[slug]-plan.md` / `[slug]-design.md` / `[slug]-results.md` / `[slug]-*-review.md` documents → **In scope** (meta)
4. Issue existed before Step 0 AND is in a file the plan doesn't touch → **Out of scope**
5. Issue is about codebase, tooling, or infrastructure outside the current task's surface → **Out of scope**

Priority ordering encodes the "prefer In scope" bias — Rules 1-3 (In scope) come before Rules 4-5 (Out of scope), so any issue matching both an In-scope and an Out-of-scope rule lands on **In scope** via first-match. For a pre-existing bug in a plan-modified file (Rule 1 applies), note the pre-existing nature in the issue's Description.

---

## Structural Properties

See `~/.claude/skills/review/references/exam-guide.md` § Issue Logging for write mechanics, lifecycle rules, logging rules, dedupe semantics, and required-fields enforcement. This template covers file structure and format only.

- **Issue numbering**: the `#` column in each session's Summary Table starts at 1 and counts independently per session. Cross-session issue identity is the `(session timestamp, #)` pair.
- **Required fields**: every per-issue block must contain Title, Severity, Scope, Location, Found, Description, Evidence, Verification, Suggested direction.
