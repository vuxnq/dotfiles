#!/usr/bin/env bash

# Options
desktop="desktop"
area="area"
wfr_running=$(pgrep wf-recorder)
[ $wfr_running ] && record="stop recording" || record="record"

time=$(date +%Y-%m-%d-%H%M%S)
file="$(xdg-user-dir PICTURES)/screenshots/$time.png"
[ ! -d "$dir" ] && mkdir -p "$dir"

run_rofi() {
    echo -e "$desktop\n$area\n$record" | rofi -dmenu \
        -theme-str 'window{location: northeast; anchor: northeast;}' \
        -theme-str 'window{x-offset: -10px; y-offset: 10px;}' \
        -theme-str 'listview{lines: 3;}' \
        -theme $HOME/.config/rofi/config/applets.rasi \
        $([ $wfr_running ] && echo "-a 2")
}

chosen="$(run_rofi)"
case ${chosen} in
    $desktop)
        sleep 0.2 # so the rofi app disappears
        grim -c $file
        wl-copy < $file
        notify-send 'screenshot taken' "$file and clipboard" -i $file
        ;;
    $area)
        sleep 0.2
        hyprpicker -r -z &
        sleep 0.1
        HYPRPICKER_PID=$!
        if grim -g "$(slurp)" $file; then
            wl-copy < $file
            notify-send 'screenshot taken' "$file and clipboard" -i $file
        fi
        kill $HYPRPICKER_PID
        ;;
    $record)
        [ ! $(which wf-recorder) ] && notify-send "unable to record" "wf-recorder not found" && exit
        if [ ! $wfr_running ]; then
            file=$(xdg-user-dir VIDEOS)/$time.mp4
            notify-send "recording started"
            wf-recorder -a$(pactl get-default-sink).monitor -p preset=ultrafast -r 60 -c libx264rgb -f $file
        else
            pkill --signal SIGINT wf-recorder
            notify-send "recording stopped"
        fi
        ;;
esac
