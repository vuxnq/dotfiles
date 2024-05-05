#!/bin/bash

state=$(cat /proc/acpi/button/lid/LID/state | tr -s ' ' | cut -d ' ' -f 2)

if [ "$state" == "closed" ]; then
    hyprctl keyword monitor "eDP-1, disable"
    count=$(hyprctl monitors | grep -c '^Monitor')
    [ "$count" = 0 ] && systemctl suspend
else
    hyprctl keyword monitor "eDP-1, preferred, 0x0, auto"
fi