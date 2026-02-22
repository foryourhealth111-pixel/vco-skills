#!/usr/bin/env bash
set -euo pipefail

# VCO Ecosystem Installer
# Usage: bash install.sh [--skip-plugins] [--skip-superclaude] [--skip-claude-flow]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
SKIP_PLUGINS=false
SKIP_SC=false
SKIP_CF=false

for arg in "$@"; do
  case $arg in
    --skip-plugins) SKIP_PLUGINS=true ;;
    --skip-superclaude) SKIP_SC=true ;;
    --skip-claude-flow) SKIP_CF=true ;;
    --help) echo "Usage: bash install.sh [--skip-plugins] [--skip-superclaude] [--skip-claude-flow]"; exit 0 ;;
  esac
done

echo "=== VCO Ecosystem Installer ==="
echo "Target: ${CLAUDE_DIR}"
echo ""

# 1. Create directories
echo "[1/7] Creating directories..."
mkdir -p "${CLAUDE_DIR}/rules/common"
mkdir -p "${CLAUDE_DIR}/rules/typescript"
mkdir -p "${CLAUDE_DIR}/skills/vibe"
mkdir -p "${CLAUDE_DIR}/hooks"
mkdir -p "${CLAUDE_DIR}/commands"

# 2. Copy rules
echo "[2/7] Installing rules..."
cp -r "${SCRIPT_DIR}/rules/common/"* "${CLAUDE_DIR}/rules/common/"
cp -r "${SCRIPT_DIR}/rules/typescript/"* "${CLAUDE_DIR}/rules/typescript/"
echo "  Installed $(ls "${SCRIPT_DIR}/rules/common/" | wc -l) common rules + $(ls "${SCRIPT_DIR}/rules/typescript/" | wc -l) typescript rules"

# 3. Copy VCO skill
echo "[3/7] Installing VCO skill..."
cp -r "${SCRIPT_DIR}/skills/vibe/"* "${CLAUDE_DIR}/skills/vibe/"
echo "  Installed skills/vibe/"

# 4. Copy hooks
echo "[4/7] Installing hooks..."
cp "${SCRIPT_DIR}/hooks/write-guard.js" "${CLAUDE_DIR}/hooks/"
cp "${SCRIPT_DIR}/hooks/hookify-configs/auto-plugin-discovery.local.md" "${CLAUDE_DIR}/hookify.auto-plugin-discovery.local.md"
cp "${SCRIPT_DIR}/hooks/hookify-configs/prevent-large-file-write.local.md" "${CLAUDE_DIR}/hookify.prevent-large-file-write.local.md"
echo "  Installed write-guard.js + 2 hookify configs"

# 5. Settings template
echo "[5/7] Checking settings..."
if [ -f "${CLAUDE_DIR}/settings.json" ]; then
  echo "  settings.json already exists — skipping (see config/settings.template.json for reference)"
else
  cp "${SCRIPT_DIR}/config/settings.template.json" "${CLAUDE_DIR}/settings.json"
  echo "  Created settings.json from template — EDIT IT to add your API key"
fi

# 6. SuperClaude commands
if [ "$SKIP_SC" = false ]; then
  echo "[6/7] Installing SuperClaude commands..."
  if [ -d "${CLAUDE_DIR}/commands/sc" ]; then
    echo "  commands/sc/ already exists — updating..."
    rm -rf "${CLAUDE_DIR}/commands/sc"
  fi
  TEMP_SC=$(mktemp -d)
  git clone --depth 1 https://github.com/SuperClaude-Org/SuperClaude_Framework.git "${TEMP_SC}" 2>/dev/null
  if [ -d "${TEMP_SC}/commands/sc" ]; then
    cp -r "${TEMP_SC}/commands/sc" "${CLAUDE_DIR}/commands/sc"
  elif [ -d "${TEMP_SC}/sc" ]; then
    cp -r "${TEMP_SC}/sc" "${CLAUDE_DIR}/commands/sc"
  else
    # Fallback: copy all .md files from root
    mkdir -p "${CLAUDE_DIR}/commands/sc"
    find "${TEMP_SC}" -maxdepth 2 -name "*.md" -exec cp {} "${CLAUDE_DIR}/commands/sc/" \;
  fi
  rm -rf "${TEMP_SC}"
  echo "  Installed $(ls "${CLAUDE_DIR}/commands/sc/"*.md 2>/dev/null | wc -l) sc:* commands"
else
  echo "[6/7] Skipping SuperClaude (--skip-superclaude)"
fi

# 7. Plugins + claude-flow
if [ "$SKIP_PLUGINS" = false ]; then
  echo "[7/7] Installing plugins..."
  if command -v claude &>/dev/null; then
    CORE_PLUGINS=(
      "hookify@claude-plugins-official"
      "claude-code-settings@claude-code-settings"
      "everything-claude-code@everything-claude-code"
      "ralph-loop@claude-plugins-official"
      "superpowers@superpowers-marketplace"
      "episodic-memory@superpowers-marketplace"
      "context7@claude-plugins-official"
      "serena@claude-plugins-official"
      "github@claude-plugins-official"
      "elements-of-style@superpowers-marketplace"
    )
    for plugin in "${CORE_PLUGINS[@]}"; do
      echo "  Installing ${plugin}..."
      claude plugins install "${plugin}" 2>/dev/null || echo "  Warning: failed to install ${plugin}"
    done
  else
    echo "  'claude' CLI not found — install plugins manually (see config/plugins-manifest.json)"
  fi
else
  echo "[7/7] Skipping plugins (--skip-plugins)"
fi

# claude-flow
if [ "$SKIP_CF" = false ]; then
  if command -v npm &>/dev/null; then
    echo "  Installing claude-flow..."
    npm install -g claude-flow 2>/dev/null || echo "  Warning: failed to install claude-flow"
  else
    echo "  npm not found — install claude-flow manually: npm install -g claude-flow"
  fi
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit ~/.claude/settings.json — add your ANTHROPIC_AUTH_TOKEN and ANTHROPIC_BASE_URL"
echo "  2. Start a new Claude Code session"
echo "  3. Type: /vibe Hello, verify VCO is working"
echo ""
echo "Run 'bash check.sh' to verify all dependencies are installed."
