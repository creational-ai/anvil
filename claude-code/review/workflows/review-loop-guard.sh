#!/bin/bash
# Regression guard for claude-code/review/workflows/review-loop.js.
#
# The workflow is a THIN WRAPPER: it points its subagents at specific review-skill
# guide sections BY NUMBER (e.g. "Phase 1 §1.1–1.8", "§3.2 elevation pass") instead
# of paraphrasing their content. That keeps the domain logic single-sourced — but it
# means if the review skill renumbers/renames those sections, the workflow's pointers
# rot SILENTLY. This guard asserts the anchors still exist in the live guides.
#
# Keep the anchor list in sync with review-loop.js § REGRESSION GUARD header.
#
# Exit 0 = anchors present, OR review skill not installed (skip — not a failure).
# Exit 1 = drift detected: re-sync review-loop.js section pointers.

set -u

REF="$HOME/.claude/skills/review/references"

if [ ! -d "$REF" ]; then
  echo "review-loop-guard: review skill not installed at $REF — skipping (not a failure)"
  exit 0
fi

fail=0

check() { # <file> <literal-anchor>
  if ! grep -qF -- "$2" "$REF/$1" 2>/dev/null; then
    echo "  ✗ MISSING anchor in $1 :: \"$2\""
    fail=1
  fi
}

exists() { # <file>
  if [ ! -f "$REF/$1" ]; then
    echo "  ✗ MISSING guide file: $1"
    fail=1
  fi
}

echo "review-loop-guard: checking review-guide anchors review-loop.js depends on…"

# exam round
check exam-guide.md "## Review Mode"

# review round — scope (Phase 1) + synth (Phase 3) pointers
check review-doc-run-guide.md "## Phase 1"
check review-doc-run-guide.md "### 1.3"
check review-doc-run-guide.md "### 1.5"
check review-doc-run-guide.md "### 1.6"
check review-doc-run-guide.md "### 1.8"
check review-doc-run-guide.md "## Phase 3"
check review-doc-run-guide.md "### 3.2"

# guides referenced by path (existence is enough)
exists review-doc-guide.md
exists review-item-guide.md
exists review-holistic-guide.md

if [ "$fail" -eq 0 ]; then
  echo "  ✅ all anchors present — review-loop.js pointers are in sync with the review guides"
  exit 0
fi

echo "  ⚠ review guide reorganized — re-sync review-loop.js section pointers (see its § REGRESSION GUARD header)"
exit 1
