#!/bin/bash
TARGET="/usr/share/plymouth/themes/vux"
if [ -d $TARGET ]; then
  echo "> removing old theme"
  sudo rm $TARGET -r
fi

echo "> copying the theme to the plymouth's themes folder"
sudo cp .additional/plymouth $TARGET -r
echo "> setting the theme"
sudo plymouth-set-default-theme -R vux
echo "> done"
