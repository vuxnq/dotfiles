#!/bin/bash

get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'
}

is_mute() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED
}

send_notification() {
    volume=$(get_volume)
    notify-send -i NONE -r 2593 -t 500 "  volume $volume%" -h int:value:$volume
}

change=5
if [ -n "$2" ]; then change=$2; fi

case $1 in
    up)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ ${change}%+ 
    send_notification
    ;;
    
    down)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${change}%- 
    send_notification
    ;;
    
    mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle 
    
    if is_mute ; then
        notify-send -i NONE -r 2593 "  mute"
    else
        send_notification
    fi
    ;;
esac
