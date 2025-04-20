# Dotfiles

[![Tests](https://github.com/near129/.dotfiles/actions/workflows/test.yaml/badge.svg)](https://github.com/near129/.dotfiles/actions/workflows/test.yaml)

## Requirements

### Install [Nix](https://nixos.org/)

```shell
sh <(curl -L https://nixos.org/nix/install)
```

### Install [Homebrew](https://brew.sh/)(Only for macOS)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Installation

```shell
nix --extra-experimental-features 'nix-command flakes' run nixpkgs#home-manager -- switch
```
