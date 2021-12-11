# setup complication
fpath+=~/.zfunc
autoload -U compinit
compinit

source ~/.zcomplication

#
# App setting
# 


setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_reduce_blanks  # 余分な空白は詰めて記録

export EDITOR="vim"

# homebrew 
# https://brew.sh/
if [[ "$OSTYPE" == darwin* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d /home/linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# starship
# https://github.com/starship/starship
eval "$(starship init zsh)"

# pyenv
if (( $+commands[pyenv] )); then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi
# nodebrew
if (( $+commands[nodebrew] )); then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# cargo
if (( $+commands[cargo] )); then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# zsh-autosuggestions zsh-history-substring-search
if [ ! -z "$HOMEBREW_PREFIX" ]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
else
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

#
# alias
#

alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"
alias mv="${aliases[mv]:-mv} -i"
alias rm="${aliases[rm]:-rm} -i"

if (( $+commands[exa] )); then
    alias ls="exa --icons"
fi
alias l="ls -1"
alias ll="ls -lh"
alias la="ll -a"

if (( $+commands[nvim] )); then
    alias vi='nvim'
    alias vim='nvim'
fi

alias df='df -kh'
alias du='du -kh'
alias dua=' du -scmh ./* ./.[^.]* | sort -rh'

alias ipython='jupyter-console'

if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
else
  alias o='xdg-open'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  else
    echo "No clipboard util command. Should install clip or xsel"
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

# zshのキルリングとクリップボードを共有する
function copy-line-as-kill() {
    zle kill-line
    print -rn $CUTBUFFER | pbcopy
}
zle -N copy-line-as-kill
bindkey '^k' copy-line-as-kill

function paste-as-yank() {
    pbpaste
}
zle -N paste-as-yank
bindkey "^y" paste-as-yank
