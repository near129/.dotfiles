#!/bin/bash
set -e

if [[ $1 == "--apt" ]] ; then
  echo "Use apt installation"
  apt update
  apt install git curl zsh fzf wget fd-find bat exa neovim xsel
  # dust https://github.com/bootandy/dust
  # procs https://github.com/dalance/procs
  mkdir -p $HOME/.local/bin
  mkdir -p $HOME/.zsh/fzf
  cat << EOF > $HOME/.fzf..zsh
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
EOF
  cat << 'EOF' >> .zshrc
  export PATH=$HOME/.local/bin:$PATH
EOF
  ln -s $(which fdfind) $HOME/.local/bin/fd
  ln -s $(which batcat) $HOME/.local/bin/bat

  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
else
  echo "Use homebrew installation"
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
fi

cd `dirname $0`
DIR=`pwd`

# symlink dotfiles
echo "source ${DIR}/.zshrc" >> ~/.zshrc
ln -sf ${DIR}/.zcomplication ~/.zcomplication
ln -sf ${DIR}/.config ~/.config
ln -sf ${DIR}/.vimrc ~/.vimrc

chsh -s $(which zsh)
source $HOME/.zshrc
