#!/bin/bash

# Unpackage .skill files back into source folders
# Usage: ./unpackage.sh
#
# Workflow:
# 1. Edit skills in Claude Desktop
# 2. Export .skill files to releases/
# 3. Run this script to update source folders

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RELEASES_DIR="$SCRIPT_DIR/releases"

# Skills to unpackage
SKILLS=("dev-design" "market-research")

echo "📦 Unpackaging Claude Desktop skills..."
echo ""

for skill in "${SKILLS[@]}"; do
    SKILL_FILE="$RELEASES_DIR/$skill.skill"
    SKILL_DIR="$SCRIPT_DIR/$skill"

    if [ ! -f "$SKILL_FILE" ]; then
        echo "⚠️  Skipping $skill (.skill file not found)"
        continue
    fi

    echo "--- Unpackaging $skill.skill ---"

    # Create temp directory for extraction
    TEMP_DIR=$(mktemp -d)

    # Unzip .skill file (it's a zip archive)
    unzip -q "$SKILL_FILE" -d "$TEMP_DIR"

    # The skill contents are in a folder named after the skill
    EXTRACTED_DIR="$TEMP_DIR/$skill"

    if [ ! -d "$EXTRACTED_DIR" ]; then
        echo "❌ Error: Expected $skill folder not found in archive"
        rm -rf "$TEMP_DIR"
        continue
    fi

    # Remove old skill directory and replace with extracted
    rm -rf "$SKILL_DIR"
    mv "$EXTRACTED_DIR" "$SKILL_DIR"

    # Cleanup temp directory
    rm -rf "$TEMP_DIR"

    echo "✅ $skill updated"
done

echo ""
echo "📁 Updated folders:"
for skill in "${SKILLS[@]}"; do
    if [ -d "$SCRIPT_DIR/$skill" ]; then
        echo "  $skill/"
    fi
done

echo ""
echo "Changed files:"
cd "$SCRIPT_DIR/.." && git status --short claude-desktop/
