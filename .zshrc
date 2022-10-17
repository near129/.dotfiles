# setup complication
source $HOME/.dotfiles/.zcomplication
source $HOME/dev/tmp/zsh-autocomplete/zsh-autocomplete.plugin.zsh
zle -A {.,}history-incremental-search-forward
zle -A {.,}history-incremental-search-backward
bindkey '^N' down-line-or-select
bindkey -M menuselect '^N' down-history

fpath+=$XDG_DATA_HOME/zsh/completion
autoload -U compinit
compinit -d $XDG_STATE_HOME/zcompdump

path=(
  "$HOME/.local/bin"(N-/)
  "$path[@]"
)

## History file configuration
export HISTFILE="$XDG_STATE_HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000

setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_reduce_blanks  # 余分な空白は詰めて記録
setopt share_history

setopt magic_equal_subst # for anything=expression

setopt auto_pushd # for `cd -[0-9]`

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
# export BROWSER='open'

bindkey -e

case ${OSTYPE} in
  darwin*)
    ;;
  linux*)
    if [[ "$(uname -r)" == *microsoft* ]]; then
      alias pbcopy='/mnt/c/WINDOWS/system32/clip.exe'
      alias pbpaste='/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0//powershell.exe -Command Get-Clipboard'
    else
      alias open='xdg-open'
      if (( $+commands[xclip] )); then
        alias pbcopy='xclip -selection clipboard -in'
        alias pbpaste='xclip -selection clipboard -out'
      elif (( $+commands[xsel] )); then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
      else
        echo "No clipboard util command. Recommned installing clip or xsel"
      fi
    fi
    ;;
esac

(( $+commands[vivid] )) && export LS_COLORS=$(vivid generate iceberg-dark)

(( $+commands[starship] )) && eval "$(starship init zsh)"

if (( $+commands[fzf] )); then
   source $XDG_CONFIG_HOME/fzf/fzf.zsh
   source $XDG_CONFIG_HOME/fzf_user/config.zsh
fi

if (( $+HOMEBREW_PREFIX )); then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $HOMEBREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi


(( $+commands[exa] )) && alias ls="exa --icons" # need nerd font
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[nvim] )) && alias vi='nvim' && alias vim='nvim'

alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"
alias mv="${aliases[mv]:-mv} -i"
alias rm="${aliases[rm]:-rm} -i"

alias ll="ls -lh"
alias la="ls -a"
alias lt="ls -T"
alias lla="ls -la"
alias lal="ls -la"

alias df='df -kh'
alias du='du -kh'

(( $+commands[pbcopy] )) && alias pbc='pbcopy'
(( $+commands[pbpaste] )) && alias pbp='pbpaste'

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
