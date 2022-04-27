#!/bin/bash
set -eux

# homebrew 
# https://brew.sh/
# apt update && apt install build-essential procps curl file git
NONINTERACTIVE=1 eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

case $OSTYPE in
  darwin*) 
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> .zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)" 
    brew bundle
    ;;
  linux*) 
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> .zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 
    brew bundle --file Brewfile_linux
    ;;
esac
$(brew --prefix)/opt/fzf/install
# intel mac
# eval "$(/usr/local/opt/bin/brew shellenv)"

cd `dirname $0`
DIR=`pwd`

# symlink dotfiles
echo "source ${DIR}/.zshrc" >> ~/.zshrc
ln -sf ${DIR}/.config ~/.config
ln -sf ${DIR}/.vimrc ~/.vimrc

chsh -s $(which zsh)
source $HOME/.zshrc
