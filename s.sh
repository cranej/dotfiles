#!/bin/sh

tmux new-session -d -s locals -n 'work1'

tmux new-window -t locals:1 -n 'work2'
tmux new-window -t locals:2 -n 'mutt' 'mutt'
tmux new-window -t locals:3 -n 'imap' 'offlineimap'

tmux select-window -t locals:0
tmux -2 attach-session -t locals
