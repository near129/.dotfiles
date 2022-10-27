# Dotfiles

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
git clone https://github.com/near129/.dotfiles.git
./.dotfiles/install.sh
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

### Pyenv

1. `./install.sh --homebrew-install-python-tools`
2. setup shell [document](https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv)

example

```shell
export PYENV_ROOT="$HOME/.pyenv"
path=(
  "$PYENV_ROOT/bin"(N-/)
  "$path[@]"
)
eval "$(pyenv init -)"
```

### Rust(rustup)

[official rust page for install](https://www.rust-lang.org/ja/tools/install)

example

```shell
path=(
  "$HOME/.cargo/bin"(N-/)
  "$path[@]"
)
```

### google cloud sdk (gcloud)

`brew install google-cloud-sdk`

```shell
source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
```

### Nodebrew

WIP
