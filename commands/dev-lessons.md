# /dev-lessons

Consolidate all "Lessons Learned" from implementation steps into key takeaways.

## What This Does

Reads a results document, extracts all "Lessons Learned" sections from each step, and consolidates them into a "Consolidated Lessons" section at the bottom of the document.

## Resources

This command works with results documents created by:
- `/dev-execute` → Creates `docs/[name]-results.md` with per-step lessons learned

## Input

**First argument (required):**
- Path to results doc (e.g., `docs/poc6-results.md`, `docs/feature-x-results.md`)

**User notes (optional):**
```
{{notes}}
```

**Examples:**
```bash
# Consolidate lessons from a completed task
/dev-lessons docs/poc6-results.md

# Consolidate with additional context
/dev-lessons docs/feature-auth-results.md --notes "Focus on testing patterns"
```

## Process

1. **Read the results document**
   - Locate all "Lessons Learned" sections from each step
   - Extract all bullet points

2. **Analyze and consolidate**
   - Identify patterns across steps
   - Group related lessons by theme
   - Distinguish critical insights from minor details
   - Remove redundancy while preserving unique insights

3. **Consolidate into key insights**
   - Identify the most valuable learnings
   - Start each bullet with **bold emphasis** for the key concept
   - Write complete, standalone insights (not just fragments)
   - Remove trivial observations

4. **Add new section**
   - Create "## Lessons Learned" section as the **very last section** (after "## Next Steps")
   - No subsections or categories - just straight bullet points
   - Keep it comprehensive - capture all valuable insights

## Output Format

The command adds this section as the **very last section** of the results document:

```markdown
---

## Lessons Learned

- **[Key concept in bold]** - Complete insight explaining what was learned and why it matters. Include specific technical details when valuable.

- **[Another key concept]** - Detailed explanation with context. Can span multiple sentences for complex insights.

- **[Pattern discovered]** - Explain what works well and why. Provide enough detail for future reference.

- **[Gotcha or pitfall]** - What went wrong, why it happened, and how to avoid or fix it.

- **[Best practice identified]** - Pattern that should be repeated with clear rationale.
```

**Example** (from actual results file):
```markdown
## Lessons Learned

- **Symlinks beat submodules** - Shared infrastructure at `~/Development/AWS` symlinked into repos is cleaner than git submodules or copying scripts. Git tracks symlinks correctly (mode 120000).

- **www/ separation is gold** - Deployable content in `www/` enables simple `aws s3 sync site/www/ s3://bucket --delete` with no complex excludes. Self-documenting and clean.

- **Always verify production first** - WebChat files existed locally but NOT on live S3. Checking actual state (`curl`, `aws s3 ls`) before migrating saved major confusion.
```

## Key Requirements

**⚠️ DO NOT duplicate information**
- If a lesson appears in multiple steps, consolidate into one clear statement
- Generalize specific examples into broader principles where appropriate

**✅ FOCUS on what's useful for the future**
- Skip trivial observations ("tests passed", "code worked")
- Emphasize insights that would help in future implementations
- Include specific technical details when they add value

**📝 PRESERVE technical specifics**
- Library versions, API patterns, configuration details
- Error messages and their solutions
- Performance characteristics

## After Completion

The results document now has a "Lessons Learned" section at the very end that captures the key learnings from the entire implementation in a clear, comprehensive format.
