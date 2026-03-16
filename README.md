# ~/.

HELLO EVERYONE I USE CHEZMOI NOW BRUHHHUHUHUHUH

this repo contains the dotfiles for my fedora system

opinionated [hyprland](https://hypr.land) setup on
[fedora (sway spin)](https://fedoraproject.org/spins/sway),
[catppuccin mocha](https://catppuccin.com) theme throuput,
managed with [chezmoi](https://chezmoi.io)

## info
- packages and copr repos declared in [`home/.chezmoidata/packages.yaml`](home/.chezmoidata/packages.yaml)
- externals defined in [`home/.chezmoiexternals/`](home/.chezmoiexternals/)

## requirements
```sh
# chezmoi
sudo dnf install chezmoi
```

## usage
```sh
# clone repo, install packages and apply dotfiles
chezmoi init --apply vuxnq
```

```sh
# move to chezmoi directory
chezmoi cd

# add dotfiles
chezmoi add $FILENAME

# edit dofile with
chezmoi edit $FILENAME

# pull the latest changes and apply
chezmoi update

# dry-run
chezmoi apply -v -n
```
