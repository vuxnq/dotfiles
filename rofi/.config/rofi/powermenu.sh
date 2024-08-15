#!/usr/bin/env bash

mesg="uptime: `uptime -p | sed -e 's/up //g'`"

# Options
lock="lock"
logout="logout"
suspend="suspend"
reboot="reboot"
shutdown="shutdown"
yes='yes'
no='no'

run_rofi() {
	echo -e "$lock\n$logout\n$suspend\n$reboot\n$shutdown" | rofi -dmenu \
		-mesg "$mesg" \
		-theme-str 'window {location: northeast; anchor: northeast;}' \
		-theme-str 'window {x-offset: -10px; y-offset: 10px;}' \
    	-theme-str 'listview{lines: 5;}' \
		-theme $HOME/.config/rofi/config/applets.rasi
}

confirm () {
	prompt() {
		echo -e "$no\n$yes" | rofi -dmenu \
			-mesg 'are you sure?' \
    		-theme-str 'listview{lines: 2;}' \
			-theme $HOME/.config/rofi/config/applets.rasi
	}

	if [[ "$(prompt)" == "$yes" ]]; then
        for cmd in "$@"; do
            $cmd || exit 1
        done
	else
        exit
    fi	
}

chosen="$(run_rofi)"
case ${chosen} in
    $lock)
		loginctl lock-session
        ;;
    $logout)
		confirm 'kill -9 -1'
        ;;
    $suspend)
		confirm 'loginctl lock-session' 'systemctl suspend'
        ;;
    $reboot)
		confirm 'systemctl reboot'
        ;;
    $shutdown)
		confirm 'systemctl poweroff'
        ;;
esac
