# Dotfiles

[![Check](https://github.com/near129/.dotfiles/actions/workflows/check.yaml/badge.svg)](https://github.com/near129/.dotfiles/actions/workflows/check.yaml)

Personal dotfiles managed with Nix (nix-darwin + home-manager)

## Requirements

### Install Nix

<https://github.com/NixOS/nix-installer>

```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://artifacts.nixos.org/experimental-installer | \
  sh -s -- install
```

### Install Homebrew (macOS only)

<https://brew.sh/ja/>

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
sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
sudo nix --extra-experimental-features 'nix-command flakes' run "nix-darwin/master#darwin-rebuild" -- switch --flake ".#napoli25"
# For subsequent runs
nh darwin switch $HOME/.dotfiles -H napoli25
```
