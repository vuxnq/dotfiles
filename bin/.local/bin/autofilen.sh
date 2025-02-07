#!/bin/bash

SYNCPAIRS='
[
	{
		"local": "~/desktop",
		"remote": "/laptop/desktop",
		"syncMode": "localToCloud",
		"disableLocalTrash": true
	},
	{
		"local": "~/media",
		"remote": "/laptop/media",
		"syncMode": "localToCloud",
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
