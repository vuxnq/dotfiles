#!/usr/bin/env bash

# https://github.com/ericmurphyxyz/rofi-wifi-menu


connected=$(nmcli -fields WIFI g)

[ "$1" == "toggle" ] && [[ "$connected" =~ "disabled" ]] && nmcli radio wifi on && exit
[ "$1" == "toggle" ] && [[ "$connected" =~ "enabled" ]] && nmcli radio wifi off && exit

notify-send "Getting list of available Wi-Fi networks..."
# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(echo "" && nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="󰖩  Enable Wi-Fi"
fi

# Use rofi to select wifi network
rofi_command="rofi -dmenu \
    -theme-str window{location:northeast;anchor:northeast;} \
    -theme-str window{x-offset:-10px;y-offset:10px;} \
    -theme-str listview{lines:4;} \
    -theme $HOME/.config/rofi/config/applets.rasi"

chosen_network=$(echo -e "$toggle$wifi_list\n󰈆  Exit" | $rofi_command)

read -r chosen_id <<< "${chosen_network:3}"

if [ "$chosen_network" = "" ] || [ "$chosen_network" = "󰈆  Exit" ]; then
	exit
elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
  	success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."

	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -theme-str 'mainbox {children: [inputbar];}' -theme-str 'inputbar {children: [ textbox-prompt-colon, entry ];}' -theme-str 'textbox-prompt-colon {str: "";}' -theme-str 'entry {placeholder: "Password";}' -theme $HOME/.config/rofi/config/applets.rasi -p "Enter password")
		fi

        if [ $(nmcli device wifi connect "$chosen_id" password "$wifi_password" | -q grep "successfully") ]; then
            notify-send "Connection Established" "$success_message"
        else
            nmcli connection delete $chosen_id && notify-send "Connection Failed"
        fi
    fi
fi
