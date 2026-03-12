#!/bin/bash
set -e

BIN_DIR="${HOME}/.local/bin"
TMUX_CONF="${HOME}/.tmux.conf"

mkdir -p "$BIN_DIR"
cp tmux-guard tmux-compact "$BIN_DIR/"
chmod +x "$BIN_DIR/tmux-guard" "$BIN_DIR/tmux-compact"

# append to .tmux.conf if not already present
grep -q 'tmux-guard' "$TMUX_CONF" 2>/dev/null || cat >> "$TMUX_CONF" <<'EOF'
set -g history-limit 3000
set-hook -g session-created 'run-shell "pgrep -f tmux-guard >/dev/null || tmux-guard &"'
EOF

echo "done. restart tmux to activate."
