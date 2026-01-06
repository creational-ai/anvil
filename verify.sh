#!/bin/bash
# Verify dev-design + dev-cycle skills are deployed correctly
# Usage: ./verify.sh

DEVDESIGN_SKILL_DIR="$HOME/.claude/skills/dev-design"
DEVCYCLE_SKILL_DIR="$HOME/.claude/skills/dev-cycle"
OLD_SKILL_DIR="$HOME/.claude/skills/idea-to-mvp"
OLD_BLUEPRINT_DIR="$HOME/.claude/skills/blueprint"
COMMANDS_DIR="$HOME/.claude/commands"

PASS_COUNT=0
FAIL_COUNT=0

echo "=============================================="
echo "Verifying deployment..."
echo "=============================================="
echo ""

# Helper functions
pass() {
    echo "  ✅ $1"
    ((PASS_COUNT++))
}

fail() {
    echo "  ❌ $1"
    ((FAIL_COUNT++))
}

# Check old skills are removed
echo "--- Checking old skills removed ---"
if [ ! -d "$OLD_SKILL_DIR" ]; then
    pass "idea-to-mvp skill removed"
else
    fail "idea-to-mvp skill still exists at $OLD_SKILL_DIR"
fi

if [ ! -d "$OLD_BLUEPRINT_DIR" ]; then
    pass "blueprint skill removed"
else
    fail "blueprint skill still exists at $OLD_BLUEPRINT_DIR"
fi

echo ""

# Check dev-design skill
echo "--- Checking dev-design skill ---"
if [ -d "$DEVDESIGN_SKILL_DIR" ]; then
    pass "dev-design directory exists"

    if [ -f "$DEVDESIGN_SKILL_DIR/SKILL.md" ]; then
        pass "SKILL.md exists"

        # Check title
        if head -1 "$DEVDESIGN_SKILL_DIR/SKILL.md" | grep -q "^# dev-design"; then
            pass "SKILL.md has correct title"
        else
            fail "SKILL.md title is incorrect"
        fi
    else
        fail "SKILL.md missing"
    fi

    if [ -d "$DEVDESIGN_SKILL_DIR/assets/templates" ]; then
        pass "assets/templates/ exists"

        template_count=$(ls -1 "$DEVDESIGN_SKILL_DIR/assets/templates"/*.md 2>/dev/null | wc -l | tr -d ' ')
        if [ "$template_count" -gt "0" ]; then
            pass "Has $template_count templates"
        else
            fail "No templates found"
        fi
    else
        fail "assets/templates/ missing"
    fi

    if [ -d "$DEVDESIGN_SKILL_DIR/references" ]; then
        pass "references/ exists"

        guide_count=$(ls -1 "$DEVDESIGN_SKILL_DIR/references"/[0-9]-*.md 2>/dev/null | wc -l | tr -d ' ')
        if [ "$guide_count" -gt "0" ]; then
            pass "Has $guide_count reference guides"
        else
            fail "No reference guides found"
        fi
    else
        fail "references/ missing"
    fi
else
    fail "dev-design directory missing at $DEVDESIGN_SKILL_DIR"
fi

echo ""

# Check dev-cycle skill
echo "--- Checking dev-cycle skill ---"
if [ -d "$DEVCYCLE_SKILL_DIR" ]; then
    pass "dev-cycle directory exists"

    if [ -f "$DEVCYCLE_SKILL_DIR/SKILL.md" ]; then
        pass "SKILL.md exists"

        # Check title
        if head -1 "$DEVCYCLE_SKILL_DIR/SKILL.md" | grep -q "^# dev-cycle"; then
            pass "SKILL.md has correct title"
        else
            fail "SKILL.md title is incorrect"
        fi
    else
        fail "SKILL.md missing"
    fi

    if [ -d "$DEVCYCLE_SKILL_DIR/assets/templates" ]; then
        pass "assets/templates/ exists"

        template_count=$(ls -1 "$DEVCYCLE_SKILL_DIR/assets/templates"/*.md 2>/dev/null | wc -l | tr -d ' ')
        if [ "$template_count" -gt "0" ]; then
            pass "Has $template_count templates"
        else
            fail "No templates found"
        fi
    else
        fail "assets/templates/ missing"
    fi

    if [ -d "$DEVCYCLE_SKILL_DIR/references" ]; then
        pass "references/ exists"

        guide_count=$(ls -1 "$DEVCYCLE_SKILL_DIR/references"/[0-9]-*.md 2>/dev/null | wc -l | tr -d ' ')
        if [ "$guide_count" -gt "0" ]; then
            pass "Has $guide_count reference guides"
        else
            fail "No reference guides found"
        fi
    else
        fail "references/ missing"
    fi
else
    fail "dev-cycle directory missing at $DEVCYCLE_SKILL_DIR"
fi

echo ""

# Check commands
echo "--- Checking global commands ---"
if [ -d "$COMMANDS_DIR" ]; then
    pass "commands directory exists"

    # Check dev-design commands
    design_cmd_count=$(ls -1 "$COMMANDS_DIR"/design-*.md 2>/dev/null | wc -l | tr -d ' ')
    if [ "$design_cmd_count" -gt "0" ]; then
        pass "Has $design_cmd_count design commands"
    else
        fail "No design commands found"
    fi

    # Check dev-cycle commands
    dev_cmd_count=$(ls -1 "$COMMANDS_DIR"/dev-*.md 2>/dev/null | wc -l | tr -d ' ')
    if [ "$dev_cmd_count" -gt "0" ]; then
        pass "Has $dev_cmd_count dev commands"
    else
        fail "No dev commands found"
    fi

    # Check key utility commands exist
    if [ -f "$COMMANDS_DIR/verify-doc.md" ]; then
        pass "verify-doc.md exists"
    else
        fail "verify-doc.md missing"
    fi

    if [ -f "$COMMANDS_DIR/small-win-check.md" ]; then
        pass "small-win-check.md exists"
    else
        fail "small-win-check.md missing"
    fi
else
    fail "commands directory missing at $COMMANDS_DIR"
fi

echo ""
echo "=============================================="
echo "Verification Summary"
echo "=============================================="
echo "  ✅ Passed: $PASS_COUNT"
echo "  ❌ Failed: $FAIL_COUNT"
echo ""

if [ $FAIL_COUNT -eq 0 ]; then
    echo "🎉 All checks passed! Deployment is correct."
    exit 0
else
    echo "⚠️  Some checks failed. Please review the output above."
    exit 1
fi
