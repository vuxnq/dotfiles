#!/bin/bash

state=$(cat /proc/acpi/button/lid/LID/state | tr -s ' ' | cut -d ' ' -f 2)

case $1 in
    single)
    hyprctl keyword monitor "eDP-1, disable"
    exit
    ;;
esac

if [ "$state" == "closed" ]; then
    hyprctl keyword monitor "eDP-1, disable"
    count=$(hyprctl monitors | grep -c '^Monitor')
    [ "$count" = 0 ] && loginctl lock-session | systemctl suspend
else
    hyprctl keyword monitor "eDP-1, preferred, 0x0, 1" > /dev/null
    count=$(hyprctl monitors | grep -c '^Monitor')
    [ "$count" = 1 ] && hyprctl keyword monitor "eDP-1, preferred, 0x0, auto" || :
fi
