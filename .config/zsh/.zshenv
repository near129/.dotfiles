### locale ###
export LANG="en_US.UTF-8"

### XDG ###
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

typeset -U path fpath PATH

path=(
  "$HOME/.local/bin"(N-/)
  "$HOME/go/bin"(N-/) # for golang
  "$HOME/.cargo/bin"(N-/) # for rust
  "$path[@]"
)
