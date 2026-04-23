## Status Table (every tick)

```markdown
## Monitor Status — Check #N (HH:MM)

| Step | Status | Tests | Notes |
|------|--------|-------|-------|
| 0 | ✅ | [count] | Baseline |
| 1 | ✅ | [count] | +[N] tests |
| 2 | 🔄 | — | [brief context] |
| 3-8 | ⬜ | — | — |

**Test Progression**: Baseline [X] → Current [Y] (+[Z])
```

### Status Icons

| Icon | Meaning |
|------|---------|
| ✅ | Complete |
| 🔄 | In Progress |
| ⬜ | Pending |

---

## Per-Step Analysis (newly completed steps only)

```markdown
### Step N: [Name] ✅

**vs Plan Spec**:
✅/⚠️/❌ [Brief explanation of alignment or deviation]

**vs Plan Review**:
RN flagged: [what] (SEV)
Fix applied: [what changed in the plan]
**Examiner**: ✅/⚠️/❌ [Was the concern substantive or cosmetic?
Did the fix resolve the real execution risk or just the wording?
What's the actual impact on the executor?]

**vs Design** (item #M):
✅ Aligned / ⚠️ Minor drift / ❌ Diverged
[Brief explanation]

**vs Expectations**: (only if doc exists)
✅ Matches / ⚠️ Drift noted
[Brief explanation]

**Verdict**: ✅ Clean / ⚠️ Minor concern / ❌ Needs attention
[One sentence summary]
```

### Verdict Icons

| Icon | Meaning |
|------|---------|
| ✅ | Clean — no issues |
| ⚠️ | Minor concern — worth noting but not blocking |
| ❌ | Needs attention — potential execution risk |

---

## Observations (when notable)

```markdown
**Observations**:
- [Notable deviation, positive or negative]
- [Anything the results doc doesn't mention]
```

---

## Structural Properties

- **Status table**: Appears on every timer tick. Rows collapse pending steps into ranges (e.g., `3-8`) when all have the same status.
- **Per-step analysis**: Only appears when a step transitions from non-complete to complete since the last check. Multiple steps can complete between ticks — analyze each.
- **Observations**: Optional. Include when something notable happened that isn't captured in the status table or per-step analysis.
- **Depth is flexible**: The per-step analysis format is a minimum. For critical or complex steps, go deeper — break down individual adaptations, cross-reference prior examiner findings, give quantitative quality signals (LOC comparison, dead code check, test coverage).
- **Plan review section**: Shows the examiner's judgment on each reviewer finding — not just whether it was addressed, but whether it mattered and whether the fix resolved the real risk.
- **vs Expectations**: Only include this section if an expectations doc exists for the task. Omit entirely otherwise.
