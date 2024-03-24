# dotfiles

this repo contains the dotfiles for my system

## requirements

### fedora

```sh
$ dnf install git stow
```

## installation

```sh
$ cd ~
$ git clone git@github.com:vuxnq/dotfiles.git
$ cd dotfiles
```

use GNU stow to create symlinks

```sh
# <directory> - e.g. fish / helix / kitty... 
$ stow <directory>
```
