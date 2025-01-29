#!/bin/bash
TARGET="/usr/share/grub/themes/vuxgrub"
if [ -d $TARGET ]; then
  echo "> removing old theme"
  sudo rm $TARGET -r
else
  sudo mkdir -p $TARGET
fi

echo "> copying the theme to the grub's themes folder"
sudo cp -a .additional/grub/. $TARGET

echo "> setting the theme"
sudo sed -i /GRUB_TIMEOUT_STYLE=/d /etc/default/grub
sudo sed -i 1i\GRUB_TIMEOUT_STYLE=menu /etc/default/grub
sudo sed -i /GRUB_TIMEOUT=/d /etc/default/grub
sudo sed -i 1i\GRUB_TIMEOUT=2 /etc/default/grub
sudo sed -i /GRUB_THEME=/d /etc/default/grub
sudo sed -i 1i\GRUB_THEME="/usr/share/grub/themes/vuxgrub/theme.txt" /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
echo "> done"
