#!/usr/bin/env bash

theme="$HOME/.config/rofi/config/applets.rasi"

# Battery Info
status="`acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '`"
percentage="`acpi -b | cut -d',' -f2 | tr -d ' ',\%`"

conservation=`cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`
ICON_CONSERVATION="󱋙"
active=""

if [ $conservation -eq 1 ]
then
	ICON_CONSERVATION="󰌪"
	active="-a 1"
	conservation=0
else
	conservation=1
fi

# Theme Elements

list_col='1'
list_row='2'

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
option_1="$ICON_BATTERY $percentage%"
option_2="$ICON_CONSERVATION conservation"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-dmenu \
		-p "$status" \
		${active} \
		-theme-str configuration{show-icons:false\;} \
		-theme-str mainbox\{children:["message","listview"]\;} \
		-theme-str window{width:300\;location:northeast\;anchor:northeast\;} \
		-theme-str window{x-offset:-10px\;y-offset:10px\;} \
		-theme-str listview{lines:2\;} \
		-theme $HOME/.config/rofi/config/launcher.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2" | rofi_cmd
}

# Execute Command
run_cmd() {
	polkit_cmd="pkexec env PATH=$PATH DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY"
	if [[ "$1" == '--opt1' ]]; then
		notify-send -u low "${percentage}% $status"
	elif [[ "$1" == '--opt2' ]]; then
		echo $conservation | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
esac
