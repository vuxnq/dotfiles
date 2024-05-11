#!/bin/bash

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=$(get_volume)
    notify-send -i NONE -r 2593 -t 500 "  volume $volume%" -h int:value:$volume
}

change=5
if [ -n "$2" ]; then change=$2; fi

case $1 in
    up)
	amixer set Master on > /dev/null
	amixer sset Master $change%+ > /dev/null
	send_notification
	;;
    down)
	amixer set Master on > /dev/null
	amixer sset Master $change%- > /dev/null
	send_notification
	;;
    mute)
	amixer set Master 1+ toggle > /dev/null
	if is_mute ; then
	    notify-send -i NONE -r 2593 "  mute"
	else
	    send_notification
	fi
	;;
esac
