#!/bin/bash
set -eu

usage() {
  cat << EOS
  Installer
  Usage: $0 [options]
    --skip-install-homebrew      Skip install homebrew and packages
    --in-docker                  Deprioritize homebrew path. Prioritize local path (e.g. /usr/local/bin, tools installed by apt)
    --non-interactive            Non-interactive mode
EOS
  exit "${1:-1}"
}

skip_install_homebrew=""
in_docker=""
non_interactive=${NONINTERACTIVE-}

while [[ $# -gt 0 ]]
do
  PARAM=`echo $1 | awk -F= '{print $1}'`
  VALUE=`echo $1 | awk -F= '{print $2}'`
  case $PARAM in
    --skip-install-homebrew) skip_install_homebrew=1 ;;
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

cd $HOME
DOTFILES_DIR=$HOME/.dotfiles
if [[ ! -d $DOTFILES_DIR ]]; then
  echo "Clone dotfiles..."
  git clone https://github.com/near129/.dotfiles.git
fi

OS="$(uname)"
UNAME_MACHINE="$(uname -m)"
case $OS in
Darwin*)
  os_dir="macos"
  if [[ $UNAME_MACHINE == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    HOMEBREW_PREFIX="/usr/local"
  fi
  ;;
Linux*)
  os_dir="linux"
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  ;;
esac

if [[ ! -n $skip_install_homebrew ]]; then
  if [[ -d $HOMEBREW_PREFIX ]]; then
    echo "Already brew exist"
  else
    NONINTERACTIVE=$non_interactive \
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

  brew bundle --file ${DOTFILES_DIR}/${os_dir}/Brewfile --no-lock
else
  echo "Skip installing packages"
fi

echo "Downloading zsh-git-escape-magic"
mkdir -p ${HOME}/.local/share/zsh/site-functions/
curl "https://raw.githubusercontent.com/knu/zsh-git-escape-magic/master/git-escape-magic" \
  -o ${HOME}/.local/share/zsh/site-functions/git-escape-magic

echo "Setup(link) dotfiles"
ln -sf ${DOTFILES_DIR}/.config/zsh/.zshenv ~/
mkdir -p ~/.config
ln -sf ${DOTFILES_DIR}/.config/* ~/.config

echo "Setup zsh"
if [[ -x $HOMEBREW_PREFIX/bin/zsh ]]; then
  if ! grep -q $HOMEBREW_PREFIX/bin/zsh /etc/shells; then
    if [[ -x /usr/bin/sudo ]]; then
      echo "$HOMEBREW_PREFIX/bin/zsh" | sudo tee -a /etc/shells
    else
      echo "$HOMEBREW_PREFIX/bin/zsh" | tee -a /etc/shells
    fi
    echo "Added homebrew zsh to /etc/shells"
  fi
  chsh -s "$HOMEBREW_PREFIX/bin/zsh"
  echo "Changed default shell"
else
  echo "zsh not found"
fi
mkdir -p $HOME/.local/state
touch $HOME/.local/state/.zsh_history

if [[ -n in_docker ]]; then
  echo "Deprioritize homebrew path"
cat << "EOF" >> $HOME/.zshrc.local
path=(
  "${${path[@]:#$HOMEBREW_PREFIX/bin}[@]:#$HOMEBREW_PREFIX/sbin}"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
)
EOF
fi
echo "Finished!!"
