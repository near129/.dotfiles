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
  - zsh-syntax-highlighting
  - zsh-autocomplete
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
# sudo apt-get install build-essential procps curl file git  # for Ubuntu
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Option. My installer maybe fail to install homebrew.
git clone https://github.com/near129/.dotfiles.git
./.dotfiles/install.sh
# register zsh
command -v zsh | sudo tee -a /etc/shells
chsh -s $(command -v zsh)
```

Install script options

```text
❯ ./install.sh --help
  Installer
  Usage: ./install.sh [options]
    --brewfile=path/to/Brewfile  (default: <os>/Brewfile)
    --skip-install-homebrew      Skip install homebrew and packages
    --in-docker                  Deprioritize homebrew path. Prioritize local path (e.g. /usr/local/bin, tools installed by apt)
    --non-interactive            Non-interactive mode
```

## Other tools

### asdf

[Getting Started](https://asdf-vm.com/guide/getting-started.html)

```shell
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3
cat <<EOF >>${ZDOTDIR:-~}/.zshrc
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
EOF

# OR
brew install asdf
echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
```

- [asdf-python](https://github.com/asdf-community/asdf-python)
  - [Suggested build environment](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)

### Rust(rustup)

[official rust page for install](https://www.rust-lang.org/ja/tools/install)

example

```shell
path=(
  "$HOME/.cargo/bin"(N-/)
  "$path[@]"
)
```
