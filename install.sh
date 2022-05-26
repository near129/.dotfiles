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

$(brew --prefix)/opt/fzf/install --xdg

# setup dotfiles
cd `dirname $0`
DIR=`pwd`

echo "source ${DIR}/.zshrc" >> ~/.zshrc
ln -sf ${DIR}/{.zshenv,.zprofile} ~/
ln -sf ${DIR}/.config/* ~/.config

# setup zsh
command -v zsh | sudo tee -a /etc/shells
# sudo sed --in-place -e '/auth.*required.*pam_shells.so/s/required/sufficient/g' /etc/pam.d/chsh
# chsh -s $(which zsh)
# exec $SHELL
