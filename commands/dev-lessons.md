# /dev-lessons

Consolidate per-step lessons learned into a final summary section.

## What This Does

Extracts lessons from each step in a results doc, consolidates them, and adds a unified `## Lessons Learned` section at the end.

## Input

**Argument (required):**
- Path to results doc (e.g., `docs/core-poc6-results.md`)

**Examples:**
```bash
/dev-lessons docs/core-poc6-results.md
```

## Process

### Step 1: Extract Lessons

Read the results doc, locate all per-step "Lessons Learned" subsections, extract bullet points.

### Step 2: Consolidate

- Identify patterns across steps
- Group by theme, remove redundancy
- Keep critical insights, drop trivial observations

### Step 3: Format

- Start each bullet with **bold key concept**
- Write complete, standalone insights
- Include specific technical details when valuable

### Step 4: Add Section

Add `## Lessons Learned` as the **final section** of the document (before any existing "Next Steps" section, or at the very end).

## Requirements

- **No duplicates** - Consolidate lessons appearing in multiple steps
- **Future value** - Skip trivial observations ("tests passed", "code works")
- **Technical specifics** - Preserve library versions, API patterns, error solutions
- **Standalone insights** - Each bullet should be useful without reading the full doc

## Output Format

```markdown
## Lessons Learned

- **[Key concept in bold]** - [Complete, standalone explanation with technical details when valuable].

- **[Key concept in bold]** - [Complete, standalone explanation].

- **[Key concept in bold]** - [Complete, standalone explanation].
```

## Example Output

```markdown
## Lessons Learned

- **Database constraints handle cascades automatically** - ON DELETE SET NULL in FK constraint handles task unlinking when milestone is deleted, no application code needed.

- **Force flag pattern for destructive operations** - Block by default with informative error, allow override with explicit `force=True`. Protects against accidental data loss while enabling intentional cleanup.

- **Return affected entity info from delete operations** - Returning `tasks_unlinked` count and `dependencies_removed_from` list helps callers understand what changed without additional queries.

- **TEXT[] arrays simplify dependency tracking** - PostgreSQL array fields like `depends_on: TEXT[]` can be filtered and updated in application code without complex SQL, making dependency cleanup straightforward.
```

## After Completion

Report what was consolidated:
- Number of per-step lessons extracted
- Number of consolidated lessons in final section
- Themes/categories identified
