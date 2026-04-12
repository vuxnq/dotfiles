#!/bin/bash

INTERNAL_MON="eDP-1"
EXTERNAL_MON="HDMI-A-1"

OPEN_RES="1680x1050"
OPEN_POS="0x0"
OPEN_SCALE="1"

MIRROR_RES="1920x1080"
MIRROR_POS="auto"
MIRROR_SCALE="1"

wait_for_hyprland() {
    local tries=0
    while ! hyprctl monitors &>/dev/null; do
        sleep 0.5
        (( tries++ ))
        [ "$tries" -ge 20 ] && break
    done
    sleep 1
}

case $1 in
    single)
        hyprctl keyword monitor "$INTERNAL_MON, disable"
        ;;
    mirror)
        hyprctl keyword monitor "$INTERNAL_MON, $MIRROR_RES, $MIRROR_POS, $MIRROR_SCALE, mirror, $EXTERNAL_MON"
        ;;
    close)
        ext=$(hyprctl monitors | grep -c "$EXTERNAL_MON")
        if [ "$ext" -gt 0 ]; then
            hyprctl keyword monitor "$INTERNAL_MON, disable"
        else
            loginctl lock-session
            systemctl suspend
        fi
        ;;
    open)
        hyprctl keyword monitor "$INTERNAL_MON, $OPEN_RES, $OPEN_POS, $OPEN_SCALE" > /dev/null
        ;;
    load)
        wait_for_hyprland
        state=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')
        if [ "$state" == "closed" ]; then
            ext=$(hyprctl monitors | grep -c "$EXTERNAL_MON")
            [ "$ext" -gt 0 ] && hyprctl keyword monitor "$INTERNAL_MON, disable" || $0 close
        else
            $0 open
        fi
        ;;
    *)
        echo "usage: $(basename "$0") {single|mirror|close|open|load}"
        exit 1
        ;;
esac
