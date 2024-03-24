# ~/.
this repo contains the dotfiles for my system

## requirements
### fedora
```sh
$ dnf install git stow
```

## usage
```sh
$ cd ~
$ git clone git@github.com:vuxnq/.dotfiles.git
$ cd dotfiles
```

use [stow](https://www.gnu.org/software/stow/) to create symlinks
```sh
$ cd ~/.dotfiles
# <directory> - e.g. fish / helix / kitty... 
$ stow <directory>
```
