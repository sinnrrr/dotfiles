#!/bin/sh

QuickTerminal=$(yabai -m query --windows | jq 'map(select(.title=="QuickTerminal")) | .[0]')

if [[ $QuickTerminal == "null" ]]; then
  open -n /Applications/Alacritty.app --args --title QuickTerminal
elif [[ $(echo $QuickTerminal | jq '."is-visible"') == 'true' ]]; then
  QuickTerminal_PID=$(echo $QuickTerminal | jq '.pid')
  osascript -e "tell application \"System Events\" to set visible of first process ¬" \
    -e "whose unix id = ${QuickTerminal_PID} to false"
else
  yabai -m window $(echo $QuickTerminal | jq '.id') --focus
fi
