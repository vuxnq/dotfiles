#!/usr/bin/env bash

# Options
desktop="desktop"
area="area"
window="window"
[ $(pgrep wf-recorder) ] && record="stop recording" || record="record"

time=$(date +%Y-%m-%d-%H%M%S)
dir="$(xdg-user-dir PICTURES)/Screenshots"
file="$time.png"
[ ! -d "$dir" ] && mkdir -p "$dir"

run_rofi() {
    echo -e "$desktop\n$area\n$window\n$record" | rofi -dmenu \
        -theme-str 'window{location: northeast; anchor: northeast;}' \
        -theme-str 'window{x-offset: -10px; y-offset: 10px;}' \
        -theme-str 'listview{lines: 4;}' \
        -theme $HOME/.config/rofi/config/applets.rasi \
        $([ $(pgrep wf-recorder) ] && echo "-a 4")
}

chosen="$(run_rofi)"
case ${chosen} in
    $desktop)
        sleep 0.2 # so the rofi app disappears
        hyprshot -m output -o $dir -f $file -z
        ;;
    $area)
        sleep 0.2
        hyprshot -m region -o $dir -f $file -z
        ;;
    $window)
        sleep 0.2
        hyprshot -m window -o $dir -f $file -z
        ;;
    $record)
        if [ ! $(pgrep wf-recorder) ]; then
            notify-send "recording started"
            wf-recorder -f $(xdg-user-dir VIDEOS)/$(date +'%Y-%m-%d-%H%M%S.mp4')
        else
            pkill --signal SIGINT wf-recorder
            notify-send "recording stopped"
        fi
        ;;
esac
