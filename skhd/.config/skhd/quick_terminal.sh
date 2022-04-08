#!/usr/bin/env zsh

QuickTerminal=$(yabai -m query --windows | jq -r 'map(select(.title=="QuickTerminal")) | .[0]')

if [[ $(echo $QuickTerminal) == 'null' ]]; then
	open -n /Applications/Alacritty.app --args --title QuickTerminal
elif [[ $(echo $QuickTerminal | jq -r '."is-visible"') == 'true' ]]; then
	QuickTerminal_PID=$(echo $QuickTerminal | jq -r '.pid')
	osascript -e "tell application \"System Events\" to set visible of first process Â" \
		-e "whose unix id = ${QuickTerminal_PID} to false"
else
	QuickTerminal_ID=$(echo $QuickTerminal | jq -r '.id')
	yabai -m window $QuickTerminal_ID --focus
fi
