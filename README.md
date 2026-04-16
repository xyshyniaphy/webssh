# WebSSH — Browser Terminal via ttyd + tmux

Lightweight web shell accessible from any browser, including iPad touch screens.

## Features

- **ttyd + tmux** — share a real shell session in the browser
- **Mouse scroll** — scroll wheel enters tmux copy-mode and scrolls through buffer history
- **Touch scroll** — iPad/iPhone swipe gestures scroll the tmux scrollback (same as F7)
- **Session persistence** — closing the browser keeps your tmux session alive
- **No server-side JS** — all injection is client-side HTML

## Quick Start

```bash
# Install ttyd (or use the included static binary)
chmod +x bin/ttyd

# Edit the tmux session name in bin/webterm.sh
nano bin/webterm.sh

# Start the web shell on port 8488
./bin/ttyd -W -p 8488 -I ttyd-custom/index.html ./bin/webterm.sh
```

Open `http://<your-ip>:8488` in any browser.

## How Scroll Works

The custom `index.html` injects a script that:

1. Intercepts mouse wheel and touch events on the xterm.js viewport
2. Sends F7 (`ESC[18~`) to enter byobu/tmux copy-mode
3. Sends arrow keys (Up/Down) to scroll through buffer
4. Auto-exits copy-mode after 1.5s of inactivity

## Windows Firewall

To allow access from other machines:

```cmd
netsh advfirewall firewall add rule name="WebSSH" dir=in action=allow protocol=TCP localport=8488
```

## Files

| Path | Description |
|------|-------------|
| `bin/ttyd` | ttyd 1.7.7 static binary (x86_64) |
| `bin/webterm.sh` | Wrapper script — attaches to existing tmux session |
| `ttyd-custom/index.html` | Custom index.html with scroll injection |

## Configuration

### Change tmux session

Edit `bin/webterm.sh` and change `1` to your target session:

```bash
exec tmux attach -t YOUR_SESSION_NAME
```

### Scroll sensitivity

Edit `ttyd-custom/index.html` and adjust:

- `SCROLL_LINES = 3` — lines per mouse wheel tick
- `EXIT_DELAY = 1500` — ms before auto-exiting copy-mode
- `LINE_PX = 25` — pixels per touch scroll line (iPad)
