#!/usr/bin/env bash

# Theme Elements
mesg="Uptime : `uptime -p | sed -e 's/up //g'`"

list_col='1'
list_row='6'

# Options
option_1="lock" # Lock
option_2="logout" # Logout
option_3="suspend" # Suspend
option_4="hibernate" # Hibernate
option_5="reboot" # Reboot
option_6="shutdown" # Shutdown
yes='yes'
no='no'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-mesg "$mesg" \
		-theme-str 'window {location: northeast; anchor: northeast;}' \
		-theme-str 'window {x-offset: -10px; y-offset: 10px;}' \
		-theme $HOME/.config/rofi/config/applets.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-mesg 'Are you Sure?' \
		-theme $HOME/.config/rofi/config/applets.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$no\n$yes" | confirm_cmd
}

# Confirm and execute
confirm_run () {	
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
        ${1} && ${2} && ${3}
    else
        exit
    fi	
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		~/.local/bin/setlockimage.sh
		hyprlock
	elif [[ "$1" == '--opt2' ]]; then
		confirm_run 'kill -9 -1'
	elif [[ "$1" == '--opt3' ]]; then
		confirm_run 'systemctl suspend'
	elif [[ "$1" == '--opt4' ]]; then
		confirm_run 'systemctl hibernate'
	elif [[ "$1" == '--opt5' ]]; then
		confirm_run 'systemctl reboot'
	elif [[ "$1" == '--opt6' ]]; then
		confirm_run 'systemctl poweroff'
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
    $option_6)
		run_cmd --opt6
        ;;
esac

