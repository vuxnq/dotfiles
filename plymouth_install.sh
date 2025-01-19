#!/bin/bash
TARGET="/usr/share/plymouth/themes/vuxplymouth"
if [ -d $TARGET ]; then
  echo "> removing old theme"
  sudo rm $TARGET -r
fi

echo "> copying the theme to the plymouth's themes folder"
sudo cp -a .additional/plymouth/. $TARGET
echo "> setting the theme"
sudo plymouth-set-default-theme -R vuxplymouth
echo "> done"
