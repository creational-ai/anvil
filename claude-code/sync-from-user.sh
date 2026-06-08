#!/bin/bash
# Sync changes from ~/.claude/ back to this repo
# Usage: ./sync-from-user.sh
#
# To add/remove a skill: Edit the SKILLS array below

set -e

#=============================================================================
# CONFIGURATION - Edit this section to add/remove skills
# MUST mirror deploy.sh's SKILLS array (same skills, reverse direction).
#=============================================================================
SKILLS=(
    "design"
    "dev"
    "research"
    "review"
)
#=============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
COMMANDS_DIR="$HOME/.claude/commands"
AGENTS_DIR="$HOME/.claude/agents"
WORKFLOWS_DIR="$HOME/.claude/workflows"

echo "=============================================="
echo "Syncing from user directories..."
echo "=============================================="
echo ""

# Check which skills exist
for skill in "${SKILLS[@]}"; do
    if [ ! -d "$SKILLS_DIR/$skill" ]; then
        echo "Warning: $SKILLS_DIR/$skill does not exist"
    fi
done
echo ""

# Sync each skill
for skill in "${SKILLS[@]}"; do
    SKILL_SRC="$SKILLS_DIR/$skill"
    SKILL_DST="$SCRIPT_DIR/$skill"

    if [ ! -d "$SKILL_SRC" ]; then
        continue
    fi

    echo "--- Syncing $skill skill ---"
    echo "Source: $SKILL_SRC"

    # Sync SKILL.md
    if [ -f "$SKILL_SRC/SKILL.md" ]; then
        cp "$SKILL_SRC/SKILL.md" "$SKILL_DST/"
        echo "  ✓ Synced SKILL.md"
    fi

    # Sync assets/ wholesale (templates/, ready/, and any future subdir) — mirrors deploy.sh's assets copy
    if [ -d "$SKILL_SRC/assets" ] && [ -d "$SKILL_DST/assets" ]; then
        cp -r "$SKILL_SRC/assets/"* "$SKILL_DST/assets/"
        echo "  ✓ Synced assets/"
    fi

    # Sync references/
    if [ -d "$SKILL_SRC/references" ] && [ -d "$SKILL_DST/references" ]; then
        cp -r "$SKILL_SRC/references/"* "$SKILL_DST/references/"
        echo "  ✓ Synced references/"
    fi

    # Sync commands back to skill's commands/ folder
    if [ -d "$SKILL_DST/commands" ]; then
        synced=0
        for cmd in "$SKILL_DST/commands/"*.md; do
            [ -f "$cmd" ] || continue
            cmd_name=$(basename "$cmd")
            if [ -f "$COMMANDS_DIR/$cmd_name" ]; then
                cp "$COMMANDS_DIR/$cmd_name" "$SKILL_DST/commands/"
                ((synced++))
            fi
        done
        if [ "$synced" -gt "0" ]; then
            echo "  ✓ Synced $synced commands"
        fi
    fi

    # Sync agents back to skill's agents/ folder
    if [ -d "$SKILL_DST/agents" ]; then
        synced=0
        for agent in "$SKILL_DST/agents/"*.md; do
            [ -f "$agent" ] || continue
            agent_name=$(basename "$agent")
            if [ -f "$AGENTS_DIR/$agent_name" ]; then
                cp "$AGENTS_DIR/$agent_name" "$SKILL_DST/agents/"
                ((synced++))
            fi
        done
        if [ "$synced" -gt "0" ]; then
            echo "  ✓ Synced $synced agents"
        fi
    fi

    # Sync workflows back from the GLOBAL ~/.claude/workflows dir — source-driven
    # (only pull back *.js this skill already owns in workflows/, since the global
    # dir is shared). Companion *-guard.sh files live only in source, so nothing
    # to pull back for them. Mirrors deploy.sh's per-skill workflows copy.
    if [ -d "$SKILL_DST/workflows" ]; then
        synced=0
        for js in "$SKILL_DST/workflows/"*.js; do
            [ -f "$js" ] || continue
            wf_name=$(basename "$js")
            if [ -f "$WORKFLOWS_DIR/$wf_name" ]; then
                cp "$WORKFLOWS_DIR/$wf_name" "$SKILL_DST/workflows/"
                ((synced++))
            fi
        done
        if [ "$synced" -gt "0" ]; then
            echo "  ✓ Synced $synced workflow(s)"
        fi
    fi

    echo ""
done

echo "=============================================="
echo "✓ Sync complete!"
echo "=============================================="
echo ""
echo "Synced to: $SCRIPT_DIR"
echo ""
echo "Changed files:"
git status --short
