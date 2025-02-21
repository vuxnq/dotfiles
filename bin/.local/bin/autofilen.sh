#!/bin/bash

SYNCPAIRS='
[
	{
		"local": "~/desktop",
		"remote": "/laptop/desktop",
		"syncMode": "twoWay",
		"disableLocalTrash": true
	},
	{
		"local": "~/media",
		"remote": "/laptop/media",
		"syncMode": "twoWay",
		"disableLocalTrash": true
	}
]
'

if [[ -z $(which filen) ]]; then
  notify-send -t 30000 "filen-cli is not installed!" "https://filen.io/products/cli"
  exit
fi

[ ! -d ~/.filen-cli ] && mkdir ~/.filen-cli
echo $SYNCPAIRS > ~/.filen-cli/syncPairs.json

filen sync --continuous & disown
notify-send "filen sync enabled"
