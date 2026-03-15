#!/usr/bin/env bash

# https://github.com/ericmurphyxyz/rofi-wifi-menu

connected=$(nmcli -fields WIFI g)

[ "$1" == "toggle" ] && [[ "$connected" =~ "disabled" ]] && nmcli radio wifi on && exit
[ "$1" == "toggle" ] && [[ "$connected" =~ "enabled" ]] && nmcli radio wifi off && exit

notify-send "getting list of available wi-fi networks..."
# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(echo "" && nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

[[ "$connected" =~ "enabled" ]] && toggle="disable wi-fi" || toggle="enable wi-fi"

run_rofi() {
	echo -e "$toggle$wifi_list\nexit" | rofi -dmenu \
		-theme-str 'window{location:northeast;anchor:northeast;}' \
		-theme-str 'window{x-offset:-10px;y-offset:10px;}' \
		-theme-str 'listview{lines:4;}' \
		-theme $HOME/.config/rofi/config/applets.rasi
}

chosen=$(run_rofi)

read -r chosen_id <<< "${chosen:3}"

if [ "$chosen" = "" ] || [ "$chosen" = "exit" ]; then
	exit
elif [ "$chosen" = "enable wi-fi" ]; then
	nmcli radio wifi on
elif [ "$chosen" = "disable wi-fi" ]; then
	nmcli radio wifi off
else
  	success_message="you are now connected to the wi-fi network \"$chosen_id\"."

	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "connection established" "$success_message"
	else
		if [[ "$chosen" =~ "" ]]; then
        	pass=$(rofi -password -dmenu -theme $HOME/.config/rofi/config/password.rasi)
		fi
		if nmcli device wifi connect "$chosen_id" password "$pass" | grep -q "successfully"; then
			notify-send "Connection established" "$success_message"
		else
			notify-send "Connection failed"
			nmcli connection delete "$chosen_id"
		fi
    fi
fi
