#!/bin/bash
TARGET="/usr/share/sddm/themes/vuxsddm"
if [ -d $TARGET ]; then
  echo "> removing old theme"
  sudo rm $TARGET -r
else
  sudo mkdir -p $TARGET
fi

echo "> copying the theme to the sddm's themes folder"
sudo cp .additional/sddm/ $TARGET -pr

echo "> setting the theme"
echo -e "[Theme]\nCurrent=vuxsddm" | sudo tee /etc/sddm.conf > /dev/null
echo "> done"
