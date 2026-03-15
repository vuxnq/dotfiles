#!/usr/bin/env bash

player_status="$(playerctl status)"

status_function () {
	if playerctl status > /dev/null; then
        player="$(playerctl status -f "{{playerName}}")"
        player_track="$(playerctl metadata -f "{{trunc(default(title, \"[Unknown]\"), 25)}}")"
        player_artist="$(playerctl metadata -f "{{trunc(default(artist, \"[Unknown]\"), 25)}}")"
        
		echo -e "$player $player_status:\n$player_track by $player_artist"
	else
		echo "nothing is playing"
	fi
}
status=$(status_function)

# Options
[ $player_status == "Paused" ] && toggle="play" || toggle="pause"
next="next"
prev="previous"
seekminus="seek -15s"
seekplus="seek +15s"
switch="switch player"

run_rofi() {
    echo -e "$toggle\n$next\n$prev\n$seekplus\n$seekminus\n$switch" | rofi -show -dmenu \
        -mesg "${status^}" \
        -theme-str 'window{location: north; anchor:north;}' \
        -theme-str 'window{x-offset: -10px; y-offset: 10px;}' \
        -theme $HOME/.config/rofi/config/applets.rasi 
}

chosen="$(run_rofi)"
case ${chosen} in
    $toggle)
		playerctl play-pause
        ;;
    $next)
		playerctl next
        ;;
    $prev)
        playerctl previous
        ;;
    $seekminus)
		playerctl position 15-
        ;;
    $seekplus)
		playerctl position 15+
        ;;
    $switch)
        playerctld shift
        ;;
esac
