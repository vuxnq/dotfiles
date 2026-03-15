#!/usr/bin/env bash

status=$(acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' ')
percentage=$(acpi -b | cut -d',' -f2 | tr -d ' ',\%)
cons_status=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)

case $percentage in
    9[0-9]|100) ICON_BATTERY="󰁹" ;;
    8[0-9]) ICON_BATTERY="󰂂" ;;
    7[0-9]) ICON_BATTERY="󰂁" ;;
    6[0-9]) ICON_BATTERY="󰂀" ;;
    5[0-9]) ICON_BATTERY="󰁿" ;;
    4[0-9]) ICON_BATTERY="󰁾" ;;
    3[0-9]) ICON_BATTERY="󰁽" ;;
    2[0-9]) ICON_BATTERY="󰁼" ;;
    1[0-9]) ICON_BATTERY="󰁻" ;;
esac

# Options
cons="conservation: $cons_status"

run_rofi() {
	echo -e "$cons" | rofi -dmenu \
        -mesg "$ICON_BATTERY $percentage% $status" \
        -theme-str 'window{location: northeast; anchor: northeast;}' \
        -theme-str 'window{x-offset: -10px; y-offset: 10px;}' \
        -theme-str 'listview{lines: 1;}' \
        -theme $HOME/.config/rofi/config/applets.rasi
}

chosen="$(run_rofi)"
case ${chosen} in
    $cons)
        pass=$(rofi -password -dmenu -theme $HOME/.config/rofi/config/password.rasi)
        [ $cons_status -eq 1 ] && cons_set=0 || cons_set=1
        echo "$pass" | sudo -S bash -c "echo $cons_set > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
        cons_status=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)
        [ "$cons_status" == "$cons_set" ] && notify-send "conservation mode changed" || notify-send "failed to change conservation mode"
        ;;
esac
