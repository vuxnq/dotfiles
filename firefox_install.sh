#!/bin/bash
PROFILE=$(grep "Default=.*\.default*" "$HOME/.mozilla/firefox/profiles.ini" | cut -d"=" -f2)
echo "> firefox profile folder name = $PROFILE"

if ! [ -d "$HOME/.mozilla/firefox/$PROFILE/chrome" ]; then
    echo "> chrome folder does not exist"
    echo "  creating chrome folder ($HOME/.mozilla/firefox/$PROFILE/chrome)"
    mkdir $HOME/.mozilla/firefox/$PROFILE/chrome
fi

echo "> manually install theme [https://addons.mozilla.org/firefox/addon/catppuccin-mocha-lavender-git/]"
firefox https://addons.mozilla.org/firefox/addon/catppuccin-mocha-lavender-git/

cd $HOME/.dotfiles/.additional/
echo "> stowing .additional/firefox into chrome folder"
stow firefox -t $HOME/.mozilla/firefox/$PROFILE/chrome
echo "> done"
