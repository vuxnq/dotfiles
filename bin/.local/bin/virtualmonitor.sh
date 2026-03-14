#!/usr/bin/env bash

[[ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]] && exit 1
sock="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

toggle_monitor() {
    m=$(hyprctl monitors)
    has_real=$(grep -c '^Monitor ' <<< "$m" | xargs)
    has_real=$(grep '^Monitor ' <<< "$m" | grep -vc 'DP-3')
    dp3_on=$(grep -c '^Monitor DP-3 ' <<< "$m")

    (( has_real == 0 && dp3_on == 0 )) && hyprctl keyword monitor "DP-3, 1920x1080@60, auto, auto"
    (( has_real > 0 && dp3_on > 0 )) && hyprctl keyword monitor "DP-3, disabled"
}

toggle_monitor

nc -U "$sock" | while read -r event; do
    [[ "$event" == *monitoradded* || "$event" == *monitorremoved* ]] && \
    [[ "$event" != *DP-3* ]] && { sleep 0.5; toggle_monitor; }
done
