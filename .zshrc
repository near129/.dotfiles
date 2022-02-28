# setup complication
fpath+=~/.zfunc
autoload -U compinit
compinit

source ~/.zcomplication

autoload -U zcalc

#
# App setting
# 


## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_reduce_blanks  # 余分な空白は詰めて記録
setopt share_history

export EDITOR="vim"
export VISUAL="vim"

bindkey -e

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
  eval "$(pyenv init -)"
fi
# nodebrew
if (( $+commands[nodebrew] )); then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# cargo
if (( $+commands[cargo] )); then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# fzf
if (( $+commands[fzf] )); then
  # インストール時にkeybindingsなどをインストールする
  export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'  # --no-ignore --follow
  # fdが探索アルゴリズムがbfsじゃないので浅い階層にあっても探索の最後の方まで表示されないのを防ぐ
  export FZF_DEFAULT_COMMAND="($FZF_DEFAULT_COMMAND -d 5 && $FZF_DEFAULT_COMMAND --min-depth 6)"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
  export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi

# zsh-autosuggestions zsh-history-substring-search
if [ ! -z "$HOMEBREW_PREFIX" ]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
elif [ -d ~/.zsh ]; then
  test -d ~/.zsh/zsh-autosuggestions && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  test -d ~/.zsh/zsh-history-substring-search && source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

if (( $+functions[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
fi

#
# alias
#

alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"
alias mv="${aliases[mv]:-mv} -i"
alias rm="${aliases[rm]:-rm} -i"

if (( $+commands[exa] )); then
    # nerd fontを入れること
    alias ls="exa --icons"
fi
if (( $+commands[bat] )); then
    alias cat="bat"
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
    no_clip_board_util=true
    echo "No clipboard util command. Should install clip or xsel"
  fi
fi

if [[ ! -v no_clip_board_util ]]; then
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
fi
