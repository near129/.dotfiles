sudo apt install git curl zsh fzf wget fd-find bat exa neovim xsel
chsh -s $(which zsh)
# dust https://github.com/bootandy/dust
# procs https://github.com/dalance/procs
mkdir -p $HOME/.local/bin
cat << 'EOF' >> .zshrc
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export PATH=$HOME/.local/bin:$PATH
EOF
ln -s $(which fdfind) $HOME/.local/bin/fd
ln -s $(which batcat) $HOME/.local/bin/bat

sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

cd `dirname $0`
DIR=`pwd`

# symlink dotfiles
echo "source ${DIR}/.zshrc" >> ~/.zshrc
ln -sf ${DIR}/.zcomplication ~/.zcomplication
ln -sf ${DIR}/.config ~/.config
ln -sf ${DIR}/.vimrc ~/.vimrc
