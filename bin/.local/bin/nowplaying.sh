#!/bin/bash

get_metadata() {
    local format="$1"
    local follow="$2"

    if [[ "$follow" == "true" ]]; then
        playerctl -F metadata --player=spotify --format "$format"
    else
        playerctl metadata --player=spotify --format "$format"
    fi
}

waybar_output() {
    get_metadata '{"text": "{{markup_escape(trunc(title, 40))}} | {{markup_escape(trunc(artist, 30))}}", "class": "custom-spotify", "alt": "{{lc(status)}}" }' true
}

simple_output() {
    get_metadata '  {{title}} | {{artist}}' false
}

case "$1" in
    waybar)
        waybar_output
        ;;
    *)
        simple_output
        ;;
esac
