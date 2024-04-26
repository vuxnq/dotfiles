#!/usr/bin/env bash

bssid=$(nmcli device wifi list | sed -n '1!P' | cut -b 9- \
    | rofi -dmenu \
    -theme-str 'inputbar {children: [ textbox-prompt-colon, entry ];}' \
    -theme-str 'window {location: northeast; anchor: northeast;}' \
    -theme-str 'window {x-offset: -10px; y-offset: 10px;}' \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -theme $HOME/.config/rofi/config/launcher.rasi -p ' ' -lines 10 \
    | awk '{print $1}')

[ -z "$bssid" ] && exit 1
nmcli device wifi connect $bssid
notify-send "📶 WiFi Connected"
