#!/bin/bash
# /etc/systemd/logind.conf - [Login] HandleLidSwitch=ignore

state=$(cat /proc/acpi/button/lid/LID/state | tr -s ' ' | cut -d ' ' -f 2)

case $1 in
    single)
    hyprctl keyword monitor "eDP-1, disable"
    exit
    ;;
    mirror)
    # hyprctl keyword monitor "eDP-1, preferred, auto, auto, mirror, HDMI-A-1"
    hyprctl keyword monitor "eDP-1, preferred, 1920x1080, auto, mirror, HDMI-A-1"
    exit
    ;;
    load)
    sleep 2
    ;;
esac

if [ "$state" == "closed" ]; then
    edp=$(hyprctl monitors | grep -c 'eDP-1')
    count=$(($(hyprctl monitors | grep -c '^Monitor') - $edp))
    [ "$count" = 0 ] && loginctl lock-session | systemctl suspend || hyprctl keyword monitor "eDP-1, disable"
else
    hyprctl keyword monitor "eDP-1, 1680x1050, 0x0, 1" > /dev/null
fi
