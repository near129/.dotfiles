case $OSTYPE in
darwin*)
  if [[ $CPUTYPE == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    HOMEBREW_PREFIX="/usr/local"
  fi
  ;;
linux*)
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  ;;
esac

if [[ -d $HOMEBREW_PREFIX ]]; then
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
else
    unset HOMEBREW_PREFIX
fi
