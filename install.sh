#!/bin/bash
set -eu

cd $(dirname $0)
DOTDIR=$(pwd)

usage() {
  cat << EOS
  Installer
  Usage: $0 [options]
    --no-install-packages
    --non-interactive
    --skip-git-config
    --homebrew-install-font
    --homebrew-install-python-tools
EOS
  exit "${1:-1}"
}

#TODO: usage
no_install_packages=""
non_interactive=${NONINTERACTIVE-}
skip_git_config=""
homebrew_install_font=""
homebrew_install_python_tools=""
skip_register_zsh=""

while [[ $# -gt 0 ]]
do
  case $1 in
    --no-install-packages) no_install_packages=1 ;;
    --non-interactive) non_interactive=1 ;;
    --skip-git-config) skip_git_config=1 ;;
    --homebrew-install-font) homebrew_install_font=1 ;;
    --homebrew-install-python-tools) homebrew_install_python_tools=1;;
    --skip-register-zsh) skip_register_zsh=1 ;;
    -h | --help) usage ;;
    *)
      echo "Unrecognized option: '$1'" >&2
      usage 1
      exit 1
      ;;
  esac
  shift
done

if [[ ! -n $no_install_packages ]]; then
  # homebrew https://brew.sh/
  if [[ ! -e /opt/homebrew && ! -e /home/linuxbrew/.linuxbrew ]]; then
    NONINTERACTIVE=$non_interactive \
        eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    echo "Already brew exist"
  fi

  case $OSTYPE in
  darwin*)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  linux*)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
  esac

  HOMEBREW_INSTALL_FONT=$homebrew_install_font \
    HOMEBREW_INSTALL_PYTHON=$homebrew_install_python_tools \
    brew bundle --file ${DOTDIR}/Brewfile --no-lock

  if [[ -e $(brew --prefix)/opt/fzf/install ]]; then
    $(brew --prefix)/opt/fzf/install --xdg --no-bash --no-fish --all --no-update-rc
  fi
else
  echo "Skip installing packages"
fi

# setup dotfiles
ln -sf ${DOTDIR}/{.zshrc,.zshenv,.zprofile} ~/
mkdir -p ~/.config
ln -sf ${DOTDIR}/.config/* ~/.config

# setup zsh
# no root user need sudo (maybe)
if [[ ! -n $skip_register_zsh ]] && ! grep -q $(command -v zsh) /etc/shells; then
  mkdir -p $HOME/.local/state/.zsh_history
  command -v zsh | tee -a /etc/shells
  chsh -s $(command -v zsh)
else
  echo "Skip register zsh"
fi

if [[ ! -n $skip_git_config && ! -n $non_interactive ]]; then
  echo "Git configuration"
  read -p "Enter your git username: " git_username
  read -p "Enter your e-mail: " git_email
  git config --global user.name $git_username
  git config --global user.email $git_email
else
  echo "Skip git config"
fi
echo "Finished!!"
