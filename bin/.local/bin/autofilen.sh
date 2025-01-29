#!/bin/bash

if [[ ! -z $(which filen) ]]; then
  # [[ ! -d ~/filen ]] && mkdir ~/filen
  # filen mount ~/filen & disown
  # notify-send "filen mounted"

  filen sync \
    ~/desktop:tw:/Sync \
    --disable-local-trash --continuous & disown
  notify-send "filen sync enabled"
else
  notify-send "filen-cli is not installed!"
  # firefox https://filen.io/products/cli
fi

