#!/bin/bash

function get_brightness {
	brightnessctl i | head -n2 | tail -n1 | cut -d"(" -f2 | cut -d"%" -f1
}

function send_notification {
    brightness=$(get_brightness)
    notify-send -i NONE -r 2500 -t 500 "󰳲 brightness $brightness%" -h int:value:$brightness
}

change=5
if [ -n "$2" ]; then change=$2; fi

case $1 in
    up)
	brightnessctl set $change%+ > /dev/null
	send_notification
	;;
    down)
	brightnessctl set $change%- > /dev/null
	send_notification
	;;
esac
