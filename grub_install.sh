#!/bin/bash
TARGET="/usr/share/grub/themes/vuxgrub"
if [ -d $TARGET ]; then
  echo "> removing old theme"
  rm $TARGET -r
fi

echo "> copying the theme to the grub's themes folder"
cp .additional/grub $TARGET -r
echo "> setting the theme"
sed -i '/GRUB_THEME/c\GRUB_THEME=\"/usr/share/grub/themes/vuxgrub/theme.txt\"' /etc/default/grub
sed -i '/GRUB_TERMINAL_OUTPUT/d' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
echo "> done"
