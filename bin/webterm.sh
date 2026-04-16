#!/bin/bash
# Attach to existing tmux session with mouse mode enabled for scrollback
tmux set-option -t 1 mouse on 2>/dev/null
tmux set-option -t 1 -g mouse on 2>/dev/null
exec tmux attach -t 1
