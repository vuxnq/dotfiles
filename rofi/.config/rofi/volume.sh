#!/usr/bin/env bash

all_sinks=$(pactl list short sinks | cut -f 2)

default_sink=$(pactl info | grep 'Default Sink' | cut -d : -f 2)

active_sink=$(echo "$all_sinks" | grep -n $default_sink | cut -d : -f 1)

selected_sink=$(echo "$all_sinks" | rofi -dmenu -i -a $(($active_sink - 1)) \
    -theme-str configuration{show-icons:false\;} \
    -theme-str mainbox\{children:["message","listview"]\;} \
    -theme-str window{width:300\;location:northeast\;anchor:northeast\;} \
    -theme-str window{x-offset:-10px\;y-offset:10px\;} \
    -theme-str listview{lines:4\;} \
    -theme $HOME/.config/rofi/config/launcher.rasi
)

pactl set-default-sink $selected_sink