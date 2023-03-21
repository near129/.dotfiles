path=(
  "$HOME/.local/bin"(N-/)
  "$path[@]"
)

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
bindkey -e

(( $+commands[vivid] )) && export LS_COLORS=$(vivid generate iceberg-dark)

if [[ -v HOMEBREW_PREFIX ]]; then
   source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
   zstyle ':autocomplete:*' min-input 2
   zle -A {.,}history-incremental-search-forward
   zle -A {.,}history-incremental-search-backward
   bindkey '^N' down-line-or-select
   bindkey -M menuselect '^N' down-history
else
  autoload -U compinit
  compinit -d $XDG_CACHE_HOME/zsh/zcompdump
  zstyle ':completion:*' menu select
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion::complete:*' use-cache on
  zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' verbose yes
  zstyle ':completion:*' completer _complete _approximate
  zstyle ':completion:*:approximate:*' max-errors 2 numeric
fi
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

export HISTFILE="$XDG_STATE_HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

setopt AUTO_PUSHD
setopt AUTO_CD
setopt PUSHD_IGNORE_DUPS

setopt ALWAYS_TO_END
setopt AUTO_PARAM_SLASH
setopt COMPLETE_IN_WORD 
setopt EXTENDED_GLOB
setopt GLOB_COMPLETE
setopt MAGIC_EQUAL_SUBST


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
        # echo "No clipboard util command. Recommned installing clip or xsel"
      fi
    fi
    ;;
esac

(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[direnv] )) && . $(brew --prefix asdf)/libexec/asdf.sh
if (( $+commands[fzf] )); then
   source $XDG_CONFIG_HOME/fzf/fzf.zsh
fi
if [[ -v HOMEBREW_PREFIX ]]; then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

(( $+commands[exa] )) && alias ls="exa --icons" # need nerd font
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[nvim] )) && alias vi='nvim' && alias vim='nvim'
(( $+commands[pbcopy] )) && alias pbc='pbcopy'
(( $+commands[pbpaste] )) && alias pbp='pbpaste'

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

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local || true
