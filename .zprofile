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

eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
