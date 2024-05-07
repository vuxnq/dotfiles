#!/usr/bin/env bash

playerctl -F metadata --player=spotify --format \
    '{"text": "{{markup_escape(trunc(title, 40))}} | {{markup_escape(trunc(artist, 20))}}", "class": "custom-spotify", "alt": "{{lc(status)}}"}'