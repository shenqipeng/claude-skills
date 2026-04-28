#!/usr/bin/env bash
# Install MCU Ironclad skills for OpenCode
# Usage: ./install-opencode.sh [path-to-repo]
#
# After cloning: git clone https://github.com/shenqipeng/mcu-ironclad.git
#                cd mcu-ironclad && ./install-opencode.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OPENCODE_CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"

echo "=== MCU Ironclad — OpenCode Installer ==="
echo "Repo:      $SCRIPT_DIR"
echo "Config:    $OPENCODE_CONFIG_DIR"
echo ""

# 1. Ensure OpenCode config directory exists
mkdir -p "$OPENCODE_CONFIG_DIR"

# 2. Add plugin path to opencode.json
CONFIG_FILE="$OPENCODE_CONFIG_DIR/opencode.json"

# Normalize the repo path for JSON (forward slashes)
REPO_PATH_JSON=$(echo "$SCRIPT_DIR" | sed 's/\\/\\//g')

echo "[1/2] Configuring opencode.json..."

if [ -f "$CONFIG_FILE" ]; then
    # Check if plugin already configured
    if grep -q "$REPO_PATH_JSON" "$CONFIG_FILE" 2>/dev/null; then
        echo "  -> Plugin already configured in opencode.json"
    else
        # Add plugin path to existing config using python
        python3 -c "
import json, sys

config_path = '$CONFIG_FILE'
plugin_path = '$REPO_PATH_JSON'

with open(config_path, 'r') as f:
    config = json.load(f)

if 'plugin' not in config:
    config['plugin'] = []

if plugin_path not in config['plugin']:
    config['plugin'].append(plugin_path)

with open(config_path, 'w') as f:
    json.dump(config, f, indent=2, ensure_ascii=False)

print('  -> Added plugin path to opencode.json')
" 2>/dev/null || echo "  -> WARNING: Could not auto-update opencode.json. Please add \"$REPO_PATH_JSON\" to the plugin array manually."
    fi
else
    # Create new config
    cat > "$CONFIG_FILE" << EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "plugin": [
    "$REPO_PATH_JSON"
  ]
}
EOF
    echo "  -> Created opencode.json with plugin path"
fi

# 3. Verify
echo ""
echo "[2/2] Verifying installation..."

SKILL_COUNT=$(ls -d "$SCRIPT_DIR/skills"/*/ 2>/dev/null | wc -l)
PLUGIN_FILE="$SCRIPT_DIR/.opencode/plugins/superpowers.js"

if [ -f "$PLUGIN_FILE" ]; then
    echo "  -> Plugin: OK ($PLUGIN_FILE)"
else
    echo "  -> Plugin: MISSING ($PLUGIN_FILE)"
fi

echo "  -> Skills: $SKILL_COUNT found in $SCRIPT_DIR/skills/"

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Skills are auto-discovered via the plugin's config hook."
echo "The superpowers.js plugin will:"
echo "  1. Register ALL 25 skills from skills/ (14 core + 11 independent)"
echo "  2. Inject 'using-superpowers' bootstrap on session start"
echo "  3. Run health check for skill graph integrity"
echo ""
echo "Restart OpenCode to load the skills."
echo ""
echo "To update later: cd $SCRIPT_DIR && git pull"
