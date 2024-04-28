#!/usr/bin/env bash

theme="$HOME/.config/rofi/config/applets.rasi"

list_col='1'
list_row='4'

# Options
option_1="" # Capture Desktop
option_2="" # Capture Area
option_3="" # Capture Window
option_4="" # Capture in 5s

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
dir="`xdg-user-dir PICTURES`/Screenshots"
file="${time}.png"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		dunstify -t 1000 --replace=699 "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	sleep 0.1 # so the rofi app disappears
	hyprshot -m output -o ${dir} -f ${file} -c
}

shotarea () {
	hyprshot -m region -o ${dir} -f ${file}
}

shotwin () {
	hyprshot -m window -o ${dir} -f ${file}
}

shotdelay () {
	countdown '5'
	sleep 1
	hyprshot -m output -o ${dir} -f ${file} -c
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shotdelay
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
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
esac