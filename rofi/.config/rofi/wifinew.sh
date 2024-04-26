#!/usr/bin/env bash

bssid=$(nmcli device wifi list | sed -n '1!P' | cut -b 9- \
    | rofi -dmenu \
    -theme-str 'inputbar {children: [ textbox-prompt-colon, entry ];}' \
    -theme-str 'window {location: northeast; anchor: northeast;}' \
    -theme-str 'window {x-offset: -10px; y-offset: 10px;}' \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -theme $HOME/.config/rofi/config/launcher.rasi -p " " -lines 10 \
    | awk '{print $1}')

# TODO: create new input window
[ -z "$bssid" ] && exit 1
pass=$(echo "" \
    | rofi -dmenu \
    -theme-str 'mainbox {children: [ inputbar ];}' \
    -theme-str 'inputbar {children: [ textbox-prompt-colon, entry ];}' \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -theme-str 'entry {placeholder: "Password";}' \
    -theme-str 'window {width: 300;}' \
    -theme $HOME/.config/rofi/config/launcher.rasi \
    -p "Enter password")

[ -z "$pass" ] && notify-send "🔑 Password not entered" && exit 1
nmcli device wifi connect $bssid password $pass
notify-send "📶 New WiFi Connected"