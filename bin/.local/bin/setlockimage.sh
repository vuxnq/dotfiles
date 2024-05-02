#!/usr/bin/env bash

current_display=$(hyprctl activeworkspace | cut -f7 -d" " | cut -f1 -d":" | head -n1)
grim -l 0 -o $current_display ~/.cache/screenlock.png
convert .cache/screenlock.png -scale 10% .cache/screenlock.png
