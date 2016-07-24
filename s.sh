#!/bin/sh

tmux new-session -d -s locals

tmux new-window -t locals:1
# tmux new-window -t locals:2 -n 'mutt' 'mutt'
tmux new-window -t locals:2 -n 'imap' 'offlineimap'

tmux select-window -t locals:1
tmux -2 attach-session -t locals
