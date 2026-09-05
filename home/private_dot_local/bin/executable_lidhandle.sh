#!/bin/bash

INTERNAL_MON="eDP-1"
EXTERNAL_MON="HDMI-A-1"

OPEN_RES="1680x1050"
OPEN_POS="0x0"
OPEN_SCALE="1"

MIRROR_RES="1920x1080"
MIRROR_POS="auto"
MIRROR_SCALE="1"

mon_eval() {
    hyprctl eval "hl.monitor({ $1 })"
}

disable_internal() {
    mon_eval "output = \"$INTERNAL_MON\", disabled = true"
}

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
        disable_internal
        ;;
    mirror)
        mon_eval "output = \"$INTERNAL_MON\", mode = \"$MIRROR_RES\", position = \"$MIRROR_POS\", scale = $MIRROR_SCALE, mirror = \"$EXTERNAL_MON\""
        ;;
    close)
        ext=$(hyprctl monitors | grep -c "$EXTERNAL_MON")
        if [ "$ext" -gt 0 ]; then
            disable_internal
        else
            loginctl lock-session
            systemctl suspend
        fi
        ;;
    open)
        mon_eval "output = \"$INTERNAL_MON\", mode = \"$OPEN_RES\", position = \"$OPEN_POS\", scale = $OPEN_SCALE"
        ;;
    load)
        wait_for_hyprland
        state=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')
        if [ "$state" == "closed" ]; then
            ext=$(hyprctl monitors | grep -c "$EXTERNAL_MON")
            [ "$ext" -gt 0 ] && disable_internal || $0 close
        else
            $0 open
        fi
        ;;
    *)
        echo "usage: $(basename "$0") {single|mirror|close|open|load}"
        exit 1
        ;;
esac
