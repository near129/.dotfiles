# Dotfiles

[![Tests](https://github.com/near129/.dotfiles/actions/workflows/test.yaml/badge.svg)](https://github.com/near129/.dotfiles/actions/workflows/test.yaml)

homebrew(linuxbrew), vim, zsh, starship, fzf, modern unix commands

## Supported OS

- macOS
- Ubuntu
- Ubuntu(WSL, Docker)

## Tool set

- zsh
  - zsh-autosuggestions
  - starship
- moden unix command
  - bat
  - dust
  - exa
  - fd
  - httpie
  - procs
  - ripgrep
- fzf
  - key bindings
- neovim
  - vscode-neovim
  - vim-plug
  - lightline
  - vim-easymotion
  - nvim-cmp (no lsp)
- iceberg(color theme)

## Installation

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # https://brew.sh/
git clone https://github.com/near129/.dotfiles.git
./.dotfiles/install.sh
# register zsh
command -v zsh | sudo tee -a /etc/shells
chsh -s $(command -v zsh)
```

Install script options

```shell
❯ ./install.sh --help
  Installer
  Usage: ./install.sh [options]
    --no-install-packages
    --non-interactive
    --skip-git-config
    --homebrew-install-font
    --homebrew-install-python-tools
    --skip-register-zsh
```

## Other tools

### asdf

TODO

### Rust(rustup)

[official rust page for install](https://www.rust-lang.org/ja/tools/install)

example

```shell
path=(
  "$HOME/.cargo/bin"(N-/)
  "$path[@]"
)
```
