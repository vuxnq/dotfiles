#!/usr/bin/env bash

# Options
option_1="desktop" # Capture Desktop
option_2="area" # Capture Area
option_3="window" # Capture Window
option_4="capture in 5s" # Capture in 5s
option_5="record" # Record
[ $(pgrep wf-recorder) ] && option_5="stop recording"

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
    -theme-str 'window{location: northeast; anchor: northeast;}' \
    -theme-str 'window{x-offset: -10px; y-offset: 10px;}' \
    -theme-str 'listview{lines: 5;}' \
    -theme $HOME/.config/rofi/config/applets.rasi \
	$([ $(pgrep wf-recorder) ] && echo "-a 4")
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H%M%S`
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
	sleep 0.2 # so the rofi app disappears
	hyprshot -m output -o ${dir} -f ${file} -c -z
}
shotarea () {
	sleep 0.2 # so the rofi app disappears
	hyprshot -m region -o ${dir} -f ${file} -z
}
shotwin () {
	sleep 0.2 # so the rofi app disappears
	hyprshot -m window -o ${dir} -f ${file} -z
}
shotdelay () {
	countdown '5'
	sleep 1
	hyprshot -m output -m active -o ${dir} -f ${file} -c -z
}
record () {
	if [ ! $(pgrep wf-recorder) ]; then
		notify-send "recording started"
		wf-recorder -f $(xdg-user-dir VIDEOS)/$(date +'%Y-%m-%d-%H%M%S.mp4')
	else
		pkill --signal SIGINT wf-recorder
		notify-send "recording stopped"
	fi
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
	elif [[ "$1" == '--opt5' ]]; then
		record
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
    $option_5)
		run_cmd --opt5
        ;;
esac
