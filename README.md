# Dotfiles

[![Tests](https://github.com/near129/.dotfiles/actions/workflows/test.yaml/badge.svg)](https://github.com/near129/.dotfiles/actions/workflows/test.yaml)

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

[official page](https://asdf-vm.com/)

- [asdf-python](https://github.com/asdf-community/asdf-python)

  ```shell
  asdf plugin-add python
  ```

  - [Suggested build environment](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
    - macOS

      ```shell
      brew install openssl readline sqlite3 xz zlib # tcl-tk
      ```

    - Ubuntu, Debian

    ```shell
    sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    ```

[other plugins](https://github.com/asdf-vm/asdf-plugins)

### Rust(rustup)

[official page](https://www.rust-lang.org/ja/tools/install)

- Example
  - Install

    ```shell
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
    ```

  - Configure

    - `~/.zshrc.local`

      ```shell
      path=(
        "$HOME/.cargo/bin"(N-/)
        "$path[@]"
      )
      ```

    - Shell completion

      ```shell
      rustup completions zsh > $XDG_DATA_HOME/zsh/completion/_rustup
      rustup completions zsh cargo > $XDG_DATA_HOME/zsh/completion/_cargo
      ```
