# ~/.
this repo contains the dotfiles for my fedora system

i use [fedora (sway spin)](https://fedoraproject.org/spins/sway) as a base

## requirements
```sh
# fish
sudo dnf install fish
chsh -s $(which fish)

# stow
sudo dnf install git stow

# hyprland
sudo dnf copr enable solopasha/hyprland
sudo dnf install hyprland hypridle hyprlock hyprshot

# apps
sudo dnf install kitty nvim zoxide btop unar

# misc
sudo dnf install papirus-icon-theme rofimoji
```
\*_depedencies included in [fedora (sway spin)](https://fedoraproject.org/spins/sway) may not be listed_

## usage
```sh
git clone https://github.com/vuxnq/dotfiles.git ~/.dotfiles --recurse-submodules
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
./sddm_install.sh
```
