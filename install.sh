#!/bin/zsh

# homebrew 
# https://brew.sh/
# apt update && apt install build-essential procps curl file git
eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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
# intel mac
# eval "$(/usr/local/opt/bin/brew shellenv)"

# symlink dotfiles
ln -sf ~/.dotfiles/.vimrc ~/.vimrc
echo 'source ~/.dotfiles/.zshrc' >> ~/.zshrc
# l -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.zcomplication ~/.zcomplication
ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/.config/starship.toml ~/.config/starship.toml
