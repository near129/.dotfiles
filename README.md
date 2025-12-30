# Dotfiles

[![Tests](https://github.com/near129/.dotfiles/actions/workflows/test.yaml/badge.svg)](https://github.com/near129/.dotfiles/actions/workflows/test.yaml)

Personal dotfiles managed with Nix (nix-darwin + home-manager)

## Requirements

### Install Nix

```shell
sh <(curl -L https://nixos.org/nix/install)
```

### Install Homebrew (macOS only)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Installation

1. Clone this repository:

```shell
git clone https://github.com/near129/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Install nix-darwin and apply configuration (first time only):

```shell
nix --extra-experimental-features 'nix-command flakes' run "nix-darwin/master#darwin-rebuild" -- switch --flake ".#napoli25"
# For subsequent runs
nh darwin switch $HOME/.dotfiles -H napoli25
```
