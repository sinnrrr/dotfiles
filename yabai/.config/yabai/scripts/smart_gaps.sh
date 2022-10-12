#!/bin/sh

# Only have borders/gaps/padding if there is >1 VISIBLE window
windows_ids=$(yabai -m query --windows --space | jq '.[] | select(."is-floating"==false).id')
windows_count=$(echo $windows_ids | wc -w)

if [[ $windows_count -le 1 ]]; then
	p=0
	echo $windows_ids | xargs -n1 -P10 $YABAI/border_off.sh
	yabai -m space --padding abs:$p:$p:$p:$p
else
	p=8
	echo $windows_ids | xargs -n1 -P10 $YABAI/border_on.sh
	yabai -m space --padding abs:$p:$p:$p:$p
fi
