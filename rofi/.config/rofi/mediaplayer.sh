#!/usr/bin/env bash

status_function () {
	if playerctl status > /dev/null; then
		echo "$(playerctl status -f "{{playerName}}"): $(playerctl metadata -f "{{trunc(default(title, \"[Unknown]\"), 25)}} by {{trunc(default(artist, \"[Unknown]\"), 25)}}") ($(playerctl status))"
	else
		echo "Nothing is playing"
	fi
}

toggle_function () {
	[ "$(playerctl status)" == "Paused" ] && echo "Play" || echo "Pause"
}

status=$(status_function)

# Options
toggle=$(toggle_function)
next="Next"
prev="Previous"
seekminus="Go back 15 seconds"
seekplus="Go ahead 15 seconds"
switch="Change selected player"

# Variable passed to rofi
options="$toggle\n$next\n$prev\n$seekplus\n$seekminus\n$switch"

chosen="$(echo -e "$options" | rofi -show -dmenu \
    -mesg "${status^}" \
    -theme-str 'window{location: north; anchor:north;}' \
    -theme-str 'window{x-offset: -10px; y-offset: 10px;}' \
    -theme $HOME/.config/rofi/config/applets.rasi )"

case $chosen in
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
