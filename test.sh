#!/bin/bash
set -u
exit_code=0

OS="$(uname)"
UNAME_MACHINE="$(uname -m)"
echo "====================================="
echo "Testing on $OS $UNAME_MACHINE"
case $OS in
Darwin*)
  if [[ $UNAME_MACHINE == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    HOMEBREW_PREFIX="/usr/local"
  fi
  ;;
Linux*)
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  ;;
esac
export PATH="$HOMEBREW_PREFIX/bin:$PATH"

echo "====================================="
echo "Linting all files in \$ZDOTDIR"
for file in $HOME/.config/zsh/.[!.]*; do
  echo "Linting $file"
  zsh -n $file
  [ $? -eq 0 ] || exit_code=1
done

# Not working
# echo "====================================="
# echo "Execute zsh"
# export TERM=xterm
# error=$(zsh -lie -c exit 2>&1 /dev/null)
# if [[ -n "$error" ]]; then
#   echo "Error: $error"
#   exit_code=1
# fi

echo "====================================="
echo "Execute neovim"
nvim --headless "+Lazy! sync" +qa
[ $? -eq 0 ] || exit_code=1

echo "====================================="
if [[ $exit_code -eq 0 ]]; then
  printf "\e[32mSuccess\e[m\n"
else
  printf "\e[31mFailed\e[m\n"
fi
exit $exit_code
