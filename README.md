# Dotfiles

[![Tests](https://github.com/near129/.dotfiles/actions/workflows/test.yaml/badge.svg)](https://github.com/near129/.dotfiles/actions/workflows/test.yaml)

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
- modern unix command
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
# for Ubuntu
# sudo apt-get install build-essential procps curl file git

# Option. Install script will install homebrew, but it may fail.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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

- [asdf-python](https://github.com/asdf-community/asdf-python)
  - [Suggested build environment](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)

[other plugins](https://github.com/asdf-vm/asdf-plugins)

### Rust(rustup)

[official page](https://www.rust-lang.org/ja/tools/install)

- Example
  - Install

    ```shell
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
    ```

  - Configure(ex. `~/.zshrc.local`)

    ```shell
    path=(
      "$HOME/.cargo/bin"(N-/)
      "$path[@]"
    )
    ```
