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
	},
	{
		"local": "~/.ssh",
		"remote": "/laptop/.ssh",
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

filen sync --continuous > /tmp/filen-sync.log 2>&1 &

SYNC_PID=$!

sleep 5
if ps -p $SYNC_PID > /dev/null; then
  notify-send "filen sync enabled"
else
  notify-send "ERROR: filen failed to sync"
fi

