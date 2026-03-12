# tmux-autocompact

tmux server holds all pane scrollback in RAM. Long sessions with high-output processes (multiple Claude Code instances, log streams, watch tasks) will eventually exhaust physical memory and freeze the system.

This patch monitors tmux server RSS and automatically clears scrollback buffers before that happens. Scrollback is the only thing lost — sessions, processes, and state are unaffected.

## Install

```bash
git clone https://github.com/0xjunkim/tmux-autocompact.git
cd tmux-autocompact
./install.sh
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
