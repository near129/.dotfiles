#!/bin/bash
set -eu

cd $(dirname $0)
DOTDIR=$(pwd)

usage() {
  cat << EOS
  Installer
  Usage: $0 [options]
    --minimum
    --no-install-packages
    --non-interactive
    --skip-register-zsh
    --in-docker
EOS
  exit "${1:-1}"
}

#TODO: usage
no_install_packages=""
non_interactive=${NONINTERACTIVE-}
skip_register_zsh=""
in_docker=""

while [[ $# -gt 0 ]]
do
  case $1 in
    --minimum)
      no_install_packages=1
      non_interactive=1
      skip_register_zsh=1
    ;;
    --no-install-packages) no_install_packages=1 ;;
    --non-interactive) non_interactive=1 ;;
    --skip-register-zsh) skip_register_zsh=1 ;;
    --in-docker) in_docker=1 ;;
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
  case $OSTYPE in
  darwin*)
    os_dir="macos"
    if [[ $(uname -m) == "arm64" ]]; then
      HOMEBREW_PREFIX="/opt/homebrew"
    else
      HOMEBREW_PREFIX="/usr/local"
    fi
    ;;
  linux*)
    os_dir="linux"
    HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    ;;
  esac

  if [[ -d $HOMEBREW_PREFIX ]]; then
    echo "Already brew exist"
  else
    NONINTERACTIVE=$non_interactive \
        eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi


  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

  brew bundle --file ${DOTDIR}/${os_dir}/Brewfile --no-lock
else
  echo "Skip installing packages"
fi

# setup dotfiles
ln -sf ${DOTDIR}/.config/zsh/.zshenv ~/
mkdir -p ~/.config
ln -sf ${DOTDIR}/.config/* ~/.config

# setup zsh
mkdir -p $HOME/.local/state
touch $HOME/.local/state/.zsh_history
# no root user need sudo (maybe)
# if [[ ! -n $skip_register_zsh ]] && ! grep -q $(command -v zsh) /etc/shells; then
#   command -v zsh | sudo tee -a /etc/shells
#   chsh -s $(command -v zsh)
# else
#   echo "Skip register zsh"
# fi

if [[ -n in_docker ]]; then
cat << "EOF" >> $HOME/.zshrc.local
path=(
  "${${path[@]:#$HOMEBREW_PREFIX/bin}[@]:#$HOMEBREW_PREFIX/sbin}"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
)
EOF
fi
echo "Finished!!"
