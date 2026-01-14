# /dev-lessons

Extracts lessons from each step in a results doc, consolidates them, and adds a unified `## Lessons Learned` section at the end.

**Template**: `~/.claude/skills/dev-cycle/assets/templates/lessons-learned.md`

## Input

**Arguments (one or more required):**
- Path(s) to results doc(s) (e.g., `docs/core-poc6-results.md`)

**Examples:**
```bash
# Single doc
/dev-lessons docs/core-poc6-results.md

# Multiple docs - process each one at a time
/dev-lessons docs/core-poc1-results.md docs/core-poc2-results.md docs/core-poc3-results.md
```

**Multiple docs**: Process each document sequentially, completing one before moving to the next.

## Pre-Check

**First, check if `## Lessons Learned` section already exists in the document.**

### If NOT exists → Run Process (Steps 1-4)

### If EXISTS → Validate Against Template

Compare existing section against the template:

1. **Structure**: Flat list only (NO subcategories like `### Topic`)
2. **Format**: Each bullet matches `- **[Key concept]** - [Explanation].`
   - Uses ` - ` dash separator (NOT `:` colon)
   - Key concept is 2-5 words, bolded
3. **Content**: Meets Requirements section (Keep if / Cut if criteria)

**Structure/Format violations → Redo**:
- Has subcategories (`###`)
- Uses colon separator (`**Key**:` instead of `**Key** -`)
- Missing bold on key concept

**Content violations → Remove only**:
- Contains lessons that should be cut per Requirements → remove those bullets, keep the rest

**If valid → Done**: Report "Lessons Learned section validated - no changes needed."

---

## Process

### Step 1: Extract Lessons

Read the results doc, locate all per-step "Lessons Learned" subsections, extract bullet points.

### Step 2: Consolidate

- Identify patterns across steps
- Group by theme, remove redundancy
- Keep critical insights, drop trivial observations

### Step 3: Format

Format each bullet per the template.

### Step 4: Add Section

Add `## Lessons Learned` as the **last section** of the document.

---

## Requirements

- **No duplicates** - Consolidate lessons appearing in multiple steps
- **Standalone** - Each bullet useful without reading the full doc

### The Cutting Principle

**Ask: "Would someone reading this in 6 months find it valuable?"**

If the answer is no, cut it. Most per-step lessons are observations made during implementation that helped in the moment but have no lasting value. Cut the fluff.

**Keep only lessons that:**
- You couldn't have known without doing this specific work
- Would make someone say "I wish I knew that before I started"
- Explain a non-obvious behavior or gotcha that caused real confusion

**Cut lessons that:**
- Could be found by reading documentation or a quick search
- Any experienced developer in that stack would already know
- Are general best practices not specific to this project
- Describe how a tool/library works as designed

## After Completion

Report what was consolidated for each doc:
- Document processed
- Number of per-step lessons extracted
- Number of consolidated lessons in final section
- Themes/categories identified

**Multiple docs**: Report summary for each, then overall count when all complete.
