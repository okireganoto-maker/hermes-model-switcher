#!/usr/bin/env bash
# install.sh — Hermes Model Switcher installer
set -uo pipefail

BOLD='\033[1m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HERMES_BIN="$HOME/.local/bin/hermes"
DEST="/usr/local/bin/hermes-model"
APP_SRC="$SCRIPT_DIR/Hermes Model Switcher.app"
APP_DEST="$HOME/Desktop/Hermes Model Switcher.app"

echo ""
echo -e "${BOLD}Hermes Model Switcher — Installer${RESET}"
echo "────────────────────────────────────────"

# Check Hermes
if [[ -x "$HERMES_BIN" ]]; then
  echo -e "${GREEN}  ✓ Hermes found at $HERMES_BIN${RESET}"
else
  echo -e "${YELLOW}  ⚠ Hermes not found at $HERMES_BIN${RESET}"
  echo "    Install Hermes first: https://herm.es"
  echo "    Continuing anyway — hermes-model will still work but gateway restart will be skipped."
fi

# Install CLI script (requires sudo)
echo ""
echo "  Installing hermes-model to $DEST (requires admin password)..."
sudo mkdir -p /usr/local/bin
sudo cp "$SCRIPT_DIR/hermes-model" "$DEST"
sudo chmod +x "$DEST"
echo -e "${GREEN}  ✓ Installed: $DEST${RESET}"

# Install .app to Desktop
echo ""
echo "  Copying .app to Desktop..."
if [[ -d "$APP_DEST" ]]; then
  rm -rf "$APP_DEST"
fi
cp -r "$APP_SRC" "$APP_DEST"
chmod +x "$APP_DEST/Contents/MacOS/launcher"
echo -e "${GREEN}  ✓ Installed: $APP_DEST${RESET}"

# Quick smoke test
echo ""
echo "  Running smoke test..."
"$DEST" --dry-run
echo ""
echo -e "${BOLD}${GREEN}✓ Installation complete!${RESET}"
echo ""
echo "  How to use:"
echo "    • Terminal    : hermes-model"
echo "    • Desktop app : double-click 'Hermes Model Switcher' on your Desktop"
echo ""
