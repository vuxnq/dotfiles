# ~/.
this repo contains the dotfiles for my fedora system

i use [fedora (sway spin)](https://fedoraproject.org/spins/sway) as a base

## requirements
```sh
# stow
sudo dnf install git stow

# hyprland
sudo dnf copr enable solopasha/hyprland
sudo dnf install hyprland hypridle hyprlock hyprshot

# apps
sudo dnf install kitty

# misc
sudo dnf install papirus-icon-theme rofimoji
```
\*_depedencies included in [fedora (sway spin)](https://fedoraproject.org/spins/sway) may not be listed_

## usage
```sh
git clone git@github.com:vuxnq/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

use [stow](https://www.gnu.org/software/stow/) to create symlinks
```sh
$ stow <directory>
# <directory> - e.g. fish / helix / kitty...
```

### additional
```sh
# spotify theme
./spicetify_install.sh

# firefox theme
./firefox_install.sh

# grub theme
./grub_install.sh

# gtk theme
./gtk_install.sh

# plymouth theme
sudo dnf install plymouth-theme-script
./plymouth_install.sh

# sddm theme
sudo dnf install qt6-qtsvg
./sddm_install.sh
```
