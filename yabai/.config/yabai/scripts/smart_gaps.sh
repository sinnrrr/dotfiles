#!/bin/sh

# Only have borders/gaps/padding if there is >1 VISIBLE window

if [[ -z "${YABAI_SPACE_ID}" ]]; then
	space_sel="mouse"
else
	export space_id=$YABAI_SPACE_ID
	space_sel=$(yabai -m query --spaces | jq -r '.[] | select(.id==(env.space_id|tonumber)).index')
fi

windows_ids=$(yabai -m query --windows --space $space_sel | jq '.[] | select(."is-floating"==false).id')
windows_count=$(echo $windows_ids | wc -w)

if [[ $windows_count -le 1 ]]; then
	p=0
	echo $windows_ids | xargs -n1 -P10 $YABAI/border_off.sh
	yabai -m space $space_sel --padding abs:$p:$p:$p:$p
else
	p=8
	echo $windows_ids | xargs -n1 -P10 $YABAI/border_on.sh
	yabai -m space $space_sel --padding abs:$p:$p:$p:$p
fi
