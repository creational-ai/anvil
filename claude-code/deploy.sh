#!/bin/bash
# Deploy both dev-design and dev-cycle skills to ~/.claude/
# Usage: ./deploy.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVDESIGN_SKILL_DIR="$HOME/.claude/skills/dev-design"
DEVCYCLE_SKILL_DIR="$HOME/.claude/skills/dev-cycle"
OLD_SKILL_DIR="$HOME/.claude/skills/idea-to-mvp"
OLD_BLUEPRINT_DIR="$HOME/.claude/skills/blueprint"
COMMANDS_DIR="$HOME/.claude/commands"
AGENTS_DIR="$HOME/.claude/agents"

echo "=============================================="
echo "Deploying dev-design + dev-cycle skills..."
echo "=============================================="
echo ""

# Clean up old skill directories if they exist
if [ -d "$OLD_SKILL_DIR" ]; then
    echo "--- Removing old idea-to-mvp skill ---"
    rm -rf "$OLD_SKILL_DIR"
    echo "  ✓ Removed $OLD_SKILL_DIR"
    echo ""
fi

if [ -d "$OLD_BLUEPRINT_DIR" ]; then
    echo "--- Removing old blueprint skill ---"
    rm -rf "$OLD_BLUEPRINT_DIR"
    echo "  ✓ Removed $OLD_BLUEPRINT_DIR"
    echo ""
fi

# Create target directories
mkdir -p "$DEVDESIGN_SKILL_DIR"
mkdir -p "$DEVCYCLE_SKILL_DIR"
mkdir -p "$COMMANDS_DIR"
mkdir -p "$AGENTS_DIR"

# Deploy dev-design skill
echo "--- Deploying dev-design skill ---"
echo "Target: $DEVDESIGN_SKILL_DIR"

cp "$SCRIPT_DIR/dev-design/SKILL.md" "$DEVDESIGN_SKILL_DIR/"
echo "  ✓ Copied SKILL.md"

mkdir -p "$DEVDESIGN_SKILL_DIR/assets/templates"
cp -r "$SCRIPT_DIR/dev-design/assets/templates/"* "$DEVDESIGN_SKILL_DIR/assets/templates/"
echo "  ✓ Copied assets/templates/"

mkdir -p "$DEVDESIGN_SKILL_DIR/references"
cp -r "$SCRIPT_DIR/dev-design/references/"* "$DEVDESIGN_SKILL_DIR/references/"
echo "  ✓ Copied references/"

echo ""

# Deploy dev-cycle skill
echo "--- Deploying dev-cycle skill ---"
echo "Target: $DEVCYCLE_SKILL_DIR"

cp "$SCRIPT_DIR/dev-cycle/SKILL.md" "$DEVCYCLE_SKILL_DIR/"
echo "  ✓ Copied SKILL.md"

mkdir -p "$DEVCYCLE_SKILL_DIR/assets/templates"
cp -r "$SCRIPT_DIR/dev-cycle/assets/templates/"* "$DEVCYCLE_SKILL_DIR/assets/templates/"
echo "  ✓ Copied assets/templates/"

mkdir -p "$DEVCYCLE_SKILL_DIR/references"
cp -r "$SCRIPT_DIR/dev-cycle/references/"* "$DEVCYCLE_SKILL_DIR/references/"
echo "  ✓ Copied references/"

echo ""

# Deploy global commands
echo "--- Deploying global commands ---"
echo "Target: $COMMANDS_DIR"

if [ -d "$SCRIPT_DIR/commands" ]; then
    cp -r "$SCRIPT_DIR/commands/"* "$COMMANDS_DIR/"
    echo "  ✓ Copied all commands"
fi

echo ""

# Deploy agents
echo "--- Deploying agents ---"
echo "Target: $AGENTS_DIR"

if [ -d "$SCRIPT_DIR/dev-cycle/agents" ]; then
    cp -r "$SCRIPT_DIR/dev-cycle/agents/"* "$AGENTS_DIR/"
    echo "  ✓ Copied all agents"
fi

echo ""
echo "=============================================="
echo "✓ Deployment complete!"
echo "=============================================="
echo ""
echo "Deployed to:"
echo "  dev-design: $DEVDESIGN_SKILL_DIR"
echo "  dev-cycle:  $DEVCYCLE_SKILL_DIR"
echo "  commands:   $COMMANDS_DIR"
echo "  agents:     $AGENTS_DIR"
echo ""
