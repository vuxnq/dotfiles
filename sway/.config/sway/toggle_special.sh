#!/bin/bash
if swaymsg -t get_workspaces -r | jq -e '.[] | select(.name == "s" and .focused == true)' >/dev/null; then
    swaymsg workspace back_and_forth
else
    swaymsg workspace s
fi
