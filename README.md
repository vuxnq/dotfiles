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
$ stow *
# or choose specifically
$ stow <directory>
# <directory> - e.g. fish / helix / kitty...
```

### additional
```sh
# grub theme
sudo ./grub_install.sh

# plymouth theme
sudo ./plymouth_install.sh
```

## info
for firefox to work, the profile folder must be renamed
