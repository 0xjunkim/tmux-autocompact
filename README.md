# tmux-autocompact

![demo](demo.svg)

tmux server holds all pane scrollback in RAM. Long sessions with high-output processes (multiple Claude Code instances, log streams, watch tasks) will eventually exhaust physical memory and freeze the system.

This monitors tmux server RSS and automatically clears scrollback before that happens. Only scrollback is lost — sessions, processes, and state are unaffected.

## Install

Read `tmux-guard` and `tmux-compact` first. They're ~30 lines each.

```bash
# copy scripts
cp tmux-guard tmux-compact ~/.local/bin/
chmod +x ~/.local/bin/tmux-guard ~/.local/bin/tmux-compact

# add to ~/.tmux.conf
set -g history-limit 3000
set-hook -g session-created 'run-shell "pgrep -f tmux-guard >/dev/null || tmux-guard &"'
```

Restart tmux. Done.

## How it works

- `tmux-guard` runs in background, checks server RSS every 60 seconds
- Below 75%: silent
- 75%+: auto-clears all pane scrollback, notifies after
- `tmux-compact` can be run manually from any terminal at any time

Default threshold is 512MB. Override: `tmux-guard 256`

## Uninstall

```bash
rm ~/.local/bin/tmux-guard ~/.local/bin/tmux-compact
```

Remove the two lines from `~/.tmux.conf`.
