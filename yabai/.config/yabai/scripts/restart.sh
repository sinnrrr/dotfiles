#!/bin/sh

osascript <<< "display notification \"Restarting Yabai and skhd\" with title \"Yabai\""
launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"
skhd -r
