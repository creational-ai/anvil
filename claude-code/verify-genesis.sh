#!/bin/bash
# Verify Claude Code skills are deployed correctly on genesis via SSH
# Usage: ./verify-genesis.sh
#
# Requires: ssh genesis configured in ~/.ssh/config
#
# Mirrors verify.sh but runs all existence checks on the remote host.
# Keep arrays in sync with verify.sh.

#=============================================================================
# CONFIGURATION - Keep in sync with verify.sh
#=============================================================================
REMOTE="genesis"
REMOTE_HOME="/home/pi"

SKILLS=(
    "design"
    "dev"
    "research"
    "review"
)

# Old skill directories that should NOT exist
OLD_SKILLS=(
    "idea-to-mvp"
    "blueprint"
    "dev-design"
    "dev-cycle"
    "market-research"
    "verify"
    "skill-reviewer"
)

# Old commands that should NOT exist (replaced by skills or removed)
OLD_COMMANDS=(
    "vp-transcript.md"
    "vp-meta.md"
    "design-northstar.md"
    "design-milestones-overview.md"
    "design-milestone-design.md"
    "design-poc-design.md"
    "dev-lessons.md"
    "agent-dev-design.md"
    "agent-dev-plan.md"
    "agent-dev-execute.md"
    "agent-dev-review.md"
    "agent-dev-finalize.md"
    "agent-milestone-details.md"
    "agent-market-research.md"
    "agent-naming-research.md"
    "milestone-details.md"
    "design-naming-research.md"
    "spawn-milestone-summarizer.md"
    "verify-doc.md"
    "agent-verify-doc.md"
    "skill-review.md"
    "agent-skill-review.md"
    "review-doc-run-loop.md"
    # dev skill Stage 0: goal → usecases
    "dev-goal.md"
)

# Old agents that should NOT exist (renamed to role-based names)
OLD_AGENTS=(
    "dev-design-agent.md"
    "dev-plan-agent.md"
    "dev-execute-agent.md"
    "dev-review-agent.md"
    "dev-finalize-agent.md"
    "milestone-details-agent.md"
    "market-research-agent.md"
    "naming-research-agent.md"
    "milestone-summarizer.md"
    "verify-doc-agent.md"
    "skill-review-agent.md"
)

# Key commands that must exist (sanity check)
REQUIRED_COMMANDS=(
    "review-doc.md"
    "review-skill.md"
    "dev-health.md"
    "market-research.md"
    "dev-usecases.md"
    "dev-ready.md"
    "dev-concept.md"
)

# Key agents that must exist (sanity check)
REQUIRED_AGENTS=(
    "doc-reviewer.md"
)
#=============================================================================

REMOTE_SKILLS="$REMOTE_HOME/.claude/skills"
REMOTE_COMMANDS="$REMOTE_HOME/.claude/commands"
REMOTE_AGENTS="$REMOTE_HOME/.claude/agents"
REMOTE_WORKFLOWS="$REMOTE_HOME/.claude/workflows"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PASS_COUNT=0
FAIL_COUNT=0

echo "=============================================="
echo "Verifying deployment on $REMOTE..."
echo "=============================================="
echo ""

# Test SSH connection
if ! ssh -o ConnectTimeout=5 "$REMOTE" "echo ok" > /dev/null 2>&1; then
    echo "Error: Cannot connect to $REMOTE" >&2
    exit 1
fi

# Helper functions
pass() {
    echo "  ✅ $1"
    ((PASS_COUNT++))
}

fail() {
    echo "  ❌ $1"
    ((FAIL_COUNT++))
}

# Remote test helpers
r_dir_exists() { ssh "$REMOTE" "[ -d '$1' ]"; }
r_file_exists() { ssh "$REMOTE" "[ -f '$1' ]"; }
r_count_files() { ssh "$REMOTE" "ls -1 '$1'/*.md 2>/dev/null | wc -l | tr -d ' '"; }
r_head1_grep() { ssh "$REMOTE" "head -1 '$1' | grep -q '^# $2'"; }

# Check old skills are removed
echo "--- Checking old skills removed ---"
for old_skill in "${OLD_SKILLS[@]}"; do
    if ! r_dir_exists "$REMOTE_SKILLS/$old_skill"; then
        pass "$old_skill skill removed"
    else
        fail "$old_skill skill still exists at $REMOTE:$REMOTE_SKILLS/$old_skill"
    fi
done
echo ""

# Check old commands are removed
echo "--- Checking old commands removed ---"
for old_cmd in "${OLD_COMMANDS[@]}"; do
    if ! r_file_exists "$REMOTE_COMMANDS/$old_cmd"; then
        pass "$old_cmd removed"
    else
        fail "$old_cmd still exists at $REMOTE:$REMOTE_COMMANDS/$old_cmd"
    fi
done
echo ""

# Check old agents are removed
echo "--- Checking old agents removed ---"
for old_agent in "${OLD_AGENTS[@]}"; do
    if ! r_file_exists "$REMOTE_AGENTS/$old_agent"; then
        pass "$old_agent removed"
    else
        fail "$old_agent still exists at $REMOTE:$REMOTE_AGENTS/$old_agent"
    fi
done
echo ""

# Check each skill
for skill in "${SKILLS[@]}"; do
    echo "--- Checking $skill skill ---"
    SKILL_DST="$REMOTE_SKILLS/$skill"

    if r_dir_exists "$SKILL_DST"; then
        pass "$skill directory exists"

        # Check SKILL.md
        if r_file_exists "$SKILL_DST/SKILL.md"; then
            pass "SKILL.md exists"

            # Check title matches skill name
            if r_head1_grep "$SKILL_DST/SKILL.md" "$skill"; then
                pass "SKILL.md has correct title"
            else
                fail "SKILL.md title should be '# $skill'"
            fi
        else
            fail "SKILL.md missing"
        fi

        # Check assets/templates/ (optional -- not all skills have templates)
        if r_dir_exists "$SKILL_DST/assets/templates"; then
            pass "assets/templates/ exists"

            template_count=$(r_count_files "$SKILL_DST/assets/templates")
            if [ "$template_count" -gt "0" ]; then
                pass "Has $template_count templates"
            else
                fail "No templates found"
            fi
        else
            echo "  ℹ️  No assets/templates/ (this is OK for some skills)"
        fi

        # Check references/
        if r_dir_exists "$SKILL_DST/references"; then
            pass "references/ exists"
        else
            fail "references/ missing"
        fi
    else
        fail "$skill directory missing at $REMOTE:$SKILL_DST"
    fi

    echo ""
done

# Check commands
echo "--- Checking global commands ---"
if r_dir_exists "$REMOTE_COMMANDS"; then
    pass "commands directory exists"

    total_cmd_count=$(r_count_files "$REMOTE_COMMANDS")
    pass "Has $total_cmd_count total commands"

    for cmd in "${REQUIRED_COMMANDS[@]}"; do
        if r_file_exists "$REMOTE_COMMANDS/$cmd"; then
            pass "$cmd exists"
        else
            fail "$cmd missing"
        fi
    done
else
    fail "commands directory missing at $REMOTE:$REMOTE_COMMANDS"
fi

echo ""

# Check command frontmatter parity (source -> deployed on remote)
# Mirrors verify.sh. One SSH round-trip fetches every remote flag at once.
echo "--- Checking command frontmatter parity ---"
if r_dir_exists "$REMOTE_COMMANDS"; then
    remote_flags=$(ssh "$REMOTE" "grep -m1 -H '^disable-model-invocation:' $REMOTE_COMMANDS/*.md 2>/dev/null | tr -d '[:blank:]'")
    flag_bad=0
    flag_checked=0
    flag_nofield=""
    for src in "$SCRIPT_DIR"/*/commands/*.md; do
        [ -f "$src" ] || continue
        base=$(basename "$src")
        s=$(grep -m1 '^disable-model-invocation:' "$src" | tr -d '[:space:]' | cut -d: -f2)
        if [ -z "$s" ]; then
            flag_nofield="$flag_nofield $base"
            if echo "$remote_flags" | grep -q "/$base:disable-model-invocation:"; then
                rd=$(echo "$remote_flags" | grep "/$base:disable-model-invocation:" | sed 's/.*disable-model-invocation://')
                fail "$base: disable-model-invocation absent at source but $REMOTE=$rd"
                flag_bad=1
            fi
            continue
        fi
        line=$(echo "$remote_flags" | grep "/$base:disable-model-invocation:" || true)
        [ -n "$line" ] || continue
        d=$(echo "$line" | sed 's/.*disable-model-invocation://')
        flag_checked=$((flag_checked + 1))
        if [ "$s" != "$d" ]; then
            fail "$base: disable-model-invocation source=$s $REMOTE=${d:-<absent>}"
            flag_bad=1
        fi
    done
    if [ "$flag_bad" -eq 0 ]; then
        pass "disable-model-invocation matches source for $flag_checked commands"
    fi
    if [ -n "$flag_nofield" ]; then
        echo "    (no disable-model-invocation field:$flag_nofield)"
    fi
else
    fail "commands directory missing at $REMOTE:$REMOTE_COMMANDS"
fi

# Check agents
echo "--- Checking agents ---"
if r_dir_exists "$REMOTE_AGENTS"; then
    pass "agents directory exists"

    agent_count=$(r_count_files "$REMOTE_AGENTS")
    if [ "$agent_count" -gt "0" ]; then
        pass "Has $agent_count agents"
    else
        echo "  ℹ️  No agents deployed (this may be expected)"
    fi

    for agent in "${REQUIRED_AGENTS[@]}"; do
        if r_file_exists "$REMOTE_AGENTS/$agent"; then
            pass "$agent exists"
        else
            fail "$agent missing"
        fi
    done
else
    echo "  ℹ️  agents directory not found (this may be expected)"
fi

echo ""

# Check workflows: remote copy is byte-identical to source, and each skill's
# regression guard (workflows/*-guard.sh) passes against the REMOTE live guides.
echo "--- Checking workflows ---"
wf_src_count=0
for skill in "${SKILLS[@]}"; do
    SKILL_WF="$SCRIPT_DIR/$skill/workflows"
    [ -d "$SKILL_WF" ] || continue

    # Byte-identity: stream the remote *.js and compare to the local source.
    for js in "$SKILL_WF/"*.js; do
        [ -f "$js" ] || continue
        ((wf_src_count++))
        wf_name=$(basename "$js")
        if ! r_file_exists "$REMOTE_WORKFLOWS/$wf_name"; then
            fail "$wf_name not deployed to $REMOTE:$REMOTE_WORKFLOWS"
        elif ssh "$REMOTE" "cat '$REMOTE_WORKFLOWS/$wf_name'" 2>/dev/null | cmp -s "$js" -; then
            pass "$wf_name deployed (byte-identical)"
        else
            fail "$wf_name DRIFT — source and $REMOTE:$REMOTE_WORKFLOWS copy differ (re-run ./deploy-genesis.sh)"
        fi
    done

    # Regression guards: run each *-guard.sh on the REMOTE so it checks the
    # remote deployed guides. scp to a temp path, execute via ssh, clean up.
    for guard in "$SKILL_WF/"*-guard.sh; do
        [ -f "$guard" ] || continue
        guard_name=$(basename "$guard")
        remote_tmp="/tmp/$guard_name.$$"
        if scp -q "$guard" "$REMOTE:$remote_tmp" 2>/dev/null \
           && ssh "$REMOTE" "bash '$remote_tmp' >/dev/null 2>&1; rc=\$?; rm -f '$remote_tmp'; exit \$rc"; then
            pass "$guard_name passed (remote)"
        else
            fail "$guard_name FAILED on $REMOTE — run it there to see drift"
        fi
    done
done
if [ "$wf_src_count" -eq "0" ]; then
    echo "  ℹ️  No skill workflows/ in source (this is OK)"
fi

echo ""
echo "=============================================="
echo "Verification Summary ($REMOTE)"
echo "=============================================="
echo "  ✅ Passed: $PASS_COUNT"
echo "  ❌ Failed: $FAIL_COUNT"
echo ""

if [ $FAIL_COUNT -eq 0 ]; then
    echo "🎉 All checks passed! Deployment on $REMOTE is correct."
    exit 0
else
    echo "⚠️  Some checks failed. Please review the output above."
    exit 1
fi
