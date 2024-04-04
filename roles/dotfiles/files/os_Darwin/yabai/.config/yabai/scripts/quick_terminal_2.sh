#!/bin/sh

{ kitty --single-instance --instance-group quickterm --title QuickTerminal --directory "${HOME}" tmux new -A -s quickterm & } &> /dev/null
kitty_pid=$!
disown -r "${kitty_pid}"
