#!/usr/bin/env bash

status_function () {
	if playerctl status > /dev/null; then
		echo "$(playerctl status -f "{{playerName}}"): $(playerctl metadata -f "{{trunc(default(title, \"[Unknown]\"), 25)}} by {{trunc(default(artist, \"[Unknown]\"), 25)}}") ($(playerctl status))"
	else
		echo "Nothing is playing"
	fi
}

status=$(status_function)

# Options
toggle="Play/Pause"
next="Next"
prev="Previous"
seekminus="Go back 15 seconds"
seekplus="Go ahead 15 seconds"
switch="Change selected player"

# Variable passed to rofi
options="${status^}\n$toggle\n$next\n$prev\n$seekplus\n$seekminus\n$switch"

chosen="$(echo -e "$options" | rofi -show -dmenu\
	-theme-str configuration{show-icons:false\;} \
    -theme-str mainbox\{children:["message","listview"]\;} \
    -theme-str window{width:300\;location:north\;anchor:north\;} \
    -theme-str window{x-offset:-10px\;y-offset:10px\;} \
    -theme-str listview{lines:4\;} \
    -theme $HOME/.config/rofi/config/launcher.rasi
)"

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
