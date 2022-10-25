#!/bin/bash
set -eux

if [[ $1 == "--no-install-packages" ]]; then
  # homebrew https://brew.sh/
  if [[ ! -e /opt/homebrew && ! -e /home/linuxbrew ]]; then
    NONINTERACTIVE=1 eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  case $OSTYPE in
  darwin*)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  linux*)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
  esac

  brew bundle

  $(brew --prefix)/opt/fzf/install --xdg --no-bash --no-fish --all --no-update-rc
fi

# setup dotfiles
cd $(dirname $0)
DIR=$(pwd)

ln -sf ${DIR}/{.zshrc,.zshenv,.zprofile} ~/
ln -sf ${DIR}/.config/* ~/.config

# setup zsh
if ! grep -q $(command -v zsh) /etc/shells; then
  command -v zsh | sudo tee -a /etc/shells
  # chsh -s $(which zsh)
fi
