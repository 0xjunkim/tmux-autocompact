# tmux-autocompact v2

![demo](demo.svg)

tmux keeps pane scrollback in the server process. Long sessions with high-output workloads such as AI coding agents, REPLs, log streams, watch tasks, and builds will eventually grow RSS enough to freeze the machine.

`tmux-autocompact` is model-agnostic. It does not care whether the pane is running Claude Code, Codex, Gemini, shell scripts, or anything else. It only watches tmux server RSS and clears scrollback before memory pressure becomes dangerous. Only scrollback is lost; sessions, processes, and pane state are unaffected.

## Install

Read `tmux-autocompact` and `tmux-autocompact-compact` first. They are small Bash scripts.

```bash
# copy scripts
cp tmux-autocompact tmux-autocompact-compact ~/.local/bin/
chmod +x ~/.local/bin/tmux-autocompact ~/.local/bin/tmux-autocompact-compact

# optional: keep legacy names for older configs
cp tmux-guard tmux-compact ~/.local/bin/
chmod +x ~/.local/bin/tmux-guard ~/.local/bin/tmux-compact

# add to ~/.tmux.conf
set -g history-limit 3000
set-hook -g session-created 'run-shell -b "pgrep -f \"$HOME/.local/bin/tmux-autocompact 256\" >/dev/null || exec \"$HOME/.local/bin/tmux-autocompact 256\""'
```

Reload tmux, or start it once immediately:

```bash
tmux run-shell -b "$HOME/.local/bin/tmux-autocompact 256"
```

## How it works

- `tmux-autocompact` runs in background and checks server RSS every 60 seconds
- Below 75%: silent
- 75%+: auto-clears all pane scrollback, notifies after
- `tmux-autocompact-compact` can be run manually from any terminal at any time

Default threshold is 256MB. Override: `tmux-autocompact 128`

## Compatibility

- `tmux-guard` and `tmux-compact` remain as thin wrappers for older installs.

## Uninstall

```bash
rm ~/.local/bin/tmux-autocompact ~/.local/bin/tmux-autocompact-compact
rm ~/.local/bin/tmux-guard ~/.local/bin/tmux-compact
```

Remove the two lines from `~/.tmux.conf`.
