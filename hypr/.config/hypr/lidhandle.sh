#!/bin/bash

state=$1

if [ "$state" == "on" ]; then
    hyprctl keyword monitor "eDP-1, preferred, 0x0, auto"
else
    count_monitors=$(hyprctl monitors | grep -c '^Monitor')
    hyprctl keyword monitor "eDP-1, disable"
    [ "$count_monitors" = 1 ] && systemctl suspend
fi