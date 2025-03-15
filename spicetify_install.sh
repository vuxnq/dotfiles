#!/bin/bash
SPATH=$HOME/.config/spicetify

echo "> installing spicetify"
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh

echo "> setting prefs_path"
spicetify config > /dev/null
sed -i /prefs_path/d $SPATH/config-xpui.ini
line=$(cat --number $SPATH/config-xpui.ini | grep '\[Setting\]' | awk '{print $1}')
sed -i "$(($line + 1)) i prefs_path             = /home/$(whoami)/.var/app/com.spotify.Client/config/spotify/prefs" $SPATH/config-xpui.ini
sudo chmod a+wr /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify
sudo chmod a+wr -R /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/Apps

echo "> spicetify backup"
spicetify backup

echo "> installing marketplace"
curl -fsSL "https://raw.githubusercontent.com/spicetify/spicetify-marketplace/main/resources/install.sh" | sh

# mkdir $SPATH/Themes/vux
# cd $HOME/.dotfiles/.additional/
# echo "> stowing .additional/spicetify into Themes folder"
# stow spicetify -t $SPATH/Themes/vux
#
# echo "> curling [https://raw.githubusercontent.com/spicetify/spicetify-themes/master/text/user.css]"
# curl https://raw.githubusercontent.com/spicetify/spicetify-themes/master/text/user.css -o $SPATH/Themes/vux/user.css
#
# echo "> appending base.css to user.css"
# cat $SPATH/Themes/vux/base.css >> $SPATH/Themes/vux/user.css
#
# echo "> setting current_theme"
# spicetify config current_theme vux
#
# echo "> setting patch"
# sed -i '/\[Patch\]/,/\[/{//!d}' $SPATH/config-xpui.ini
# line=$(cat --number $SPATH/config-xpui.ini | grep '\[Patch\]' | awk '{print $1}')
# sed -i "$(($line + 1)) i xpui.js_find_8008 = ,(\\\w+=)56,\nxpui.js_repl_8008 = ,\${1}32,\n" $SPATH/config-xpui.ini

echo "> applying theme"
spicetify apply
echo "> done"

rm $HOME/.dotfiles/install.log
