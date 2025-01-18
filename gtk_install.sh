#!/bin/bash
THPATH=$HOME/.local/share/themes
CATPPUCCIN=catppuccin-mocha-lavender-standard+default
if [ -d $THPATH ]; then
  [ -d $THPATH/$CATPPUCCIN ] && rm -r $THPATH/$CATPPUCCIN
  [ -d $THPATH/$CATPPUCCIN-hdpi ] && rm -r $THPATH/$CATPPUCCIN-hdpi
  [ -d $THPATH/$CATPPUCCIN-xhdpi ] && rm -r $THPATH/$CATPPUCCIN-xhdpi
else
  echo "> creating themes folder"
  mkdir $THPATH 
fi

echo "> getting catppuccin gtk theme"
curl -L "https://github.com/catppuccin/gtk/releases/download/v1.0.3/$CATPPUCCIN.zip" -o $THPATH/catppuccin.zip
unzip -q $THPATH/catppuccin.zip -d $THPATH
rm $THPATH/catppuccin.zip

echo "> updating gtk theme"
gsettings set org.gnome.desktop.interface gtk-theme "$CATPPUCCIN"
gsettings set org.gnome.desktop.wm.preferences theme "$CATPPUCCIN"
echo "> done"
