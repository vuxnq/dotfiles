# ~/.
this repo contains the dotfiles for my fedora system

## requirements
### fedora
```sh
$ dnf install git stow
```

## usage
```sh
$ git clone git@github.com:vuxnq/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
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

# plymouth theme
sudo dnf install plymouth-theme-script
./plymouth_install.sh
```
