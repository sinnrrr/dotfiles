#!/bin/sh

if yabai -m query --windows --space |
	jq -er 'map(select(."has-focus" == true)) | length == 0' >/dev/null; then
	yabai -m window --focus mouse 2>/dev/null || true
fi
