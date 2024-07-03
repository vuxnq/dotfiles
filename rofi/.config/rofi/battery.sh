#!/usr/bin/env bash

theme="$HOME/.config/rofi/config/applets.rasi"

# Battery Info
status="`acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '`"
percentage="`acpi -b | cut -d',' -f2 | tr -d ' ',\%`"

conservation=`cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`
ICON_CONSERVATION="󱋙"

if [ $conservation -eq 1 ]
then
	ICON_CONSERVATION="󰌪"
	conservation=0
	cons_text="conservation: on"
else
	conservation=1
	cons_text="conservation: off"
fi

# Discharging
ICON_BATTERY="󰁺"
if [ $percentage -ge 90 ]; then ICON_BATTERY="󰁹"
elif [ $percentage -ge 80 ]; then ICON_BATTERY="󰂂"
elif [ $percentage -ge 70 ]; then ICON_BATTERY="󰂁"
elif [ $percentage -ge 60 ]; then ICON_BATTERY="󰂀"
elif [ $percentage -ge 50 ]; then ICON_BATTERY="󰁿"
elif [ $percentage -ge 40 ]; then ICON_BATTERY="󰁾"
elif [ $percentage -ge 30 ]; then ICON_BATTERY="󰁽"
elif [ $percentage -ge 20 ]; then ICON_BATTERY="󰁼"
elif [ $percentage -ge 10 ]; then ICON_BATTERY="󰁻"
fi

# Options
cons="$ICON_CONSERVATION $cons_text"

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-mesg "$ICON_BATTERY $percentage% $status" \
		-theme-str 'window{location: northeast; anchor: northeast;}' \
		-theme-str 'window{x-offset: -10px; y-offset: 10px;}' \
		-theme-str 'listview{lines: 1;}' \
		-theme $HOME/.config/rofi/config/applets.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$cons" | rofi_cmd
}

# TODO: sudo does not work
# Execute Command
run_cmd() {
	if [[ "$1" == '--cons' ]]; then
		echo $conservation | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $cons)
		run_cmd --cons
        ;;
esac
