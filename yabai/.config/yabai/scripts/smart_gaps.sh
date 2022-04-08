#!/bin/sh

# Only have borders/gaps/padding if there is >1 VISIBLE window

YABAI="$HOME/.config/yabai/scripts"
p=8
windows=$(yabai -m query --windows --space)
quick_term_id=$(yabai -m query --windows | jq -r 'map(select(.title=="QuickTerminal")) | .[0].id')
windows_ids=$(yabai -m query --spaces --space | jq ".windows |  map(select(. != $quick_term_id)) | .[]")
non_floated_count=$(echo $windows | jq 'map(select(."is-floating" == false)) | length')

if [[ $non_floated_count -le 1 ]]; then
	p=0
	echo $windows_ids | xargs -n1 $YABAI/border_off.sh
else
	echo $windows_ids | xargs -n1 $YABAI/border_on.sh
fi

yabai -m space --padding abs:$p:$p:$p:$p
