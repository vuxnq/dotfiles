#!/bin/bash
THPATH=$HOME/.local/share/themes
echo "> creating themes folder"
mkdir $THPATH 

echo "> getting catppuccin gtk theme"
curl -L "https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-mocha-lavender-standard+default.zip" -o $THPATH/catppuccin.zip
unzip $THPATH/catppuccin.zip -d $THPATH
rm $THPATH/catppuccin.zip

echo "> updating gtk theme"
gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-lavender-standard+default"
gsettings set org.gnome.desktop.wm.preferences theme "catppuccin-mocha-lavender-standard+default"
echo "> done"
