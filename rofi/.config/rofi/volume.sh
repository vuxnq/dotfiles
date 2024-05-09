#!/usr/bin/env bash

# TODO: BRUH CLEANUP

if [ -n "$1" ]; then
    all_sources=$(pactl list short sources | cut -f 2)
    default_source=$(pactl get-default-source)
    active_source=$(echo "$all_sources" | grep -n $default_source | cut -d : -f 1)

    selected_source=$(echo "$all_sources" | rofi -dmenu -i -a $(($active_source - 1)) \
        -theme-str configuration{show-icons:false\;} \
        -theme-str mainbox\{children:["message","listview"]\;} \
        -theme-str window{width:300\;location:northeast\;anchor:northeast\;} \
        -theme-str window{x-offset:-10px\;y-offset:10px\;} \
        -theme-str listview{lines:4\;} \
        -theme $HOME/.config/rofi/config/launcher.rasi
    )
    pactl set-default-source $selected_source
else
    all_sinks=$(pactl list short sinks | cut -f 2)
    default_sink=$(pactl get-default-sink)
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
fi