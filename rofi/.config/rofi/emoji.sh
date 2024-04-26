#!/usr/bin/sh

rofimoji --selector-args=" \
    -theme-str 'configuration {show-icons: false; display-emoji: \"\";}' \
    -theme-str 'inputbar {children: [ "textbox-prompt-colon", "entry" ];}' \
    -theme-str 'listview {columns: 3;}' \
    -theme ~/.config/rofi/config/launcher.rasi"