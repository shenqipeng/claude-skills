#!/usr/bin/env bash
# Install Claude Code skills and hooks to ~/.claude/
# Usage: ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== Claude Skills Installer ==="
echo "Source: $SCRIPT_DIR"
echo "Target: $CLAUDE_DIR"
echo ""

# Create ~/.claude if not exists
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/hooks"

# Copy skills
echo "[1/3] Copying skills..."
if [ -d "$SCRIPT_DIR/skills" ]; then
    cp -r "$SCRIPT_DIR/skills/"* "$CLAUDE_DIR/skills/"
    skill_count=$(ls -d "$CLAUDE_DIR/skills"/*/ 2>/dev/null | wc -l)
    echo "  -> $skill_count skills installed"
else
    echo "  -> No skills directory found, skipping"
fi

# Copy hooks
echo "[2/3] Copying hooks..."
if [ -d "$SCRIPT_DIR/hooks" ]; then
    cp -r "$SCRIPT_DIR/hooks/"* "$CLAUDE_DIR/hooks/"
    echo "  -> Hooks installed"
else
    echo "  -> No hooks directory found, skipping"
fi

# Merge settings
echo "[3/3] Merging settings..."
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
SETTINGS_LOCAL="$CLAUDE_DIR/settings.local.json"

if [ -f "$SCRIPT_DIR/settings.json.example" ]; then
    # Check if settings.json already has additionalDirectories
    if [ -f "$SETTINGS_FILE" ]; then
        has_additional=$(python3 -c "
import json, sys
d = json.load(open('$SETTINGS_FILE'))
perms = d.get('permissions', {})
dirs = perms.get('additionalDirectories', [])
print('yes' if '$CLAUDE_DIR' in dirs or '$HOME/.claude' in dirs else 'no')
" 2>/dev/null || echo "no")

        if [ "$has_additional" = "no" ]; then
            python3 -c "
import json
with open('$SETTINGS_FILE', 'r') as f:
    d = json.load(f)
if 'permissions' not in d:
    d['permissions'] = {}
if 'additionalDirectories' not in d['permissions']:
    d['permissions']['additionalDirectories'] = []
claude_dir = '$CLAUDE_DIR'.replace('\\\\', '/')
if claude_dir not in d['permissions']['additionalDirectories']:
    d['permissions']['additionalDirectories'].append(claude_dir)
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(d, f, indent=2)
print('  -> Added additionalDirectories to settings.json')
"
        else
            echo "  -> additionalDirectories already configured"
        fi
    else
        # No settings.json, copy example as starting point
        cp "$SCRIPT_DIR/settings.json.example" "$SETTINGS_FILE"
        echo "  -> Created settings.json from example (please fill in your API keys!)"
    fi
fi

# Merge permissions from settings.local.json.example
if [ -f "$SCRIPT_DIR/settings.local.json.example" ]; then
    if [ ! -f "$SETTINGS_LOCAL" ]; then
        cp "$SCRIPT_DIR/settings.local.json.example" "$SETTINGS_LOCAL"
        echo "  -> Created settings.local.json from example"
    else
        echo "  -> settings.local.json already exists, not overwriting"
        echo "     You may need to manually merge permissions from settings.local.json.example"
    fi
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit $SETTINGS_FILE to add your API keys"
echo "  2. Edit $SETTINGS_FILE to add the SessionStart hook (see README)"
echo "  3. Restart Claude Code to load the new skills"
echo ""
echo "To update skills later, run: git pull && ./install.sh"
