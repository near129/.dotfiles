#!/bin/zsh

# symlink dotfiles
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zpreztorc ~/.zpreztorc
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

source ~/dotfiles/.zshrc
source ~/dotfiles/.zpreztorc