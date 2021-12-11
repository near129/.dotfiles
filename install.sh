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

cd `dirname $0`
DIR=`pwd`

# symlink dotfiles
echo "source ${DIR}/.zshrc" >> ~/.zshrc
ln -sf ${DIR}/.zcomplication ~/.zcomplication
ln -sf ${DIR}/.config ~/.config
ln -sf ${DIR}/.vimrc ~/.vimrc
