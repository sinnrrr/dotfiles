#!/bin/sh

notify "Yabai" "Restarting Yabai and skhd"
launchctl kickstart -k "gui/${UID}/homebrew.mxcl.fyabai"
# skhd -r &
