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
nix --extra-experimental-features 'nix-command flakes' run nixpkgs#home-manager -- --extra-experimental-features "nix-command flakes" switch
nix --extra-experimental-features 'nix-command flakes' run "nix-darwin/master#darwin-rebuild" -- switch --flake ".#MacBook-Air"
```

## TODO

- [ ] READMEの整理
    - [ ] インストール手順
- [ ] macOSのdefaults系の整理
    - [ ] home-managerでも管理できそう
- [ ] nixのzshをデフォルトシェルにしたけどchshが自動で実行されない
- [ ] .dotfilesの置き場所
    - [ ] ~/.config/home-manager
    - [ ] /etc/nix-darwin/
- [ ] zshの設定
- [ ] その他ツールの設定をnixに入れるかどうか判断
