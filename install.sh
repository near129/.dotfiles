#!/bin/bash
set -eux

# homebrew https://brew.sh/
if [[ ! -e /opt/homebrew && ! -e /home/linuxbrew ]]; then
  NONINTERACTIVE=1 eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

case $OSTYPE in
darwin*)
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle
  ;;
linux*)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  brew bundle --file Brewfile_linux
  ;;
esac

$(brew --prefix)/opt/fzf/install --xdg --no-bash --no-fish --all --no-update-rc

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
