#!/bin/bash
PROFILE=$(grep "Default=.*\.default*" "$HOME/.mozilla/firefox/profiles.ini" | cut -d"=" -f2)
echo "> firefox profile folder name = $PROFILE"

if ! [ -d "$HOME/.mozilla/firefox/$PROFILE/chrome" ]; then
    echo "> chrome folder does not exist"
    echo "  creating chrome folder ($HOME/.mozilla/firefox/$PROFILE/chrome)"
    mkdir $HOME/.mozilla/firefox/$PROFILE/chrome
fi

if [ -d "$HOME/.mozilla/firefox/$PROFILE/chrome/onebar" ]; then
    echo "> onebar already folder exists - cloning skipped"
else
    echo "> cloning [https://git.gay/Freeplay/firefox-onebar.git] into chrome/onebar folder"
    git clone https://git.gay/Freeplay/firefox-onebar.git $HOME/.mozilla/firefox/$PROFILE/chrome/onebar
fi

cd $HOME/.dotfiles/.additional/
echo "> stowing .additional/firefox into chrome folder"
stow firefox -t $HOME/.mozilla/firefox/$PROFILE/chrome
echo "> done"
