#!/bin/bash
set -eu

TMP_PWD=$(pwd)
cd $(dirname $0)
DOTDIR=$(pwd)
cd $TMP_PWD

usage() {
  cat << EOS
  Installer
  Usage: $0 [options]
    --brewfile=path/to/Brewfile  (default: <os>/Brewfile)
    --skip-install-homebrew      Skip install homebrew and packages
    --in-docker                  Deprioritize homebrew path. Prioritize local path (e.g. /usr/local/bin, tools installed by apt)
    --non-interactive            Non-interactive mode
EOS
  exit "${1:-1}"
}

brewfile=""
skip_install_homebrew=""
in_docker=""
non_interactive=${NONINTERACTIVE-}

while [[ $# -gt 0 ]]
do
  PARAM=`echo $1 | awk -F= '{print $1}'`
  VALUE=`echo $1 | awk -F= '{print $2}'`
  case $PARAM in
    --skip-install-homebrew) skip_install_homebrew=1 ;;
    --brewfile) brewfile=$VALUE ;;
    --in-docker) in_docker=1 ;;
    --non-interactive) non_interactive=1 ;;
    -h | --help) usage ;;
    *)
      echo "Unrecognized option: '$1' (PARAM='$PARAM', VALUE='$VALUE')" >&2
      usage 1
      exit 1
      ;;
  esac
  shift
done

if [[ ! -n $skip_install_homebrew ]]; then
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
  cd $TMP_PWD

  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

  if [[ -n $brewfile ]]; then
    brew bundle --file $brewfile --no-lock
  else
    brew bundle --file ${DOTDIR}/${os_dir}/Brewfile --no-lock
  fi
else
  echo "Skip installing packages"
fi

mkdir -p ${HOME}/.local/share/zsh/site-functions/
curl "https://raw.githubusercontent.com/knu/zsh-git-escape-magic/master/git-escape-magic" \
  -o ${HOME}/.local/share/zsh/site-functions/git-escape-magic

# setup dotfiles
ln -sf ${DOTDIR}/.config/zsh/.zshenv ~/
mkdir -p ~/.config
ln -sf ${DOTDIR}/.config/* ~/.config

# setup zsh
mkdir -p $HOME/.local/state
touch $HOME/.local/state/.zsh_history

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
