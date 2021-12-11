sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search

cd `dirname $0`
DIR=`pwd`

# symlink dotfiles
echo "source ${DIR}/.zshrc" >> ~/.zshrc
ln -sf ${DIR}/.zcomplication ~/.zcomplication
ln -sf ${DIR}/.config ~/.config
ln -sf ${DIR}/.vimrc ~/.vimrc
