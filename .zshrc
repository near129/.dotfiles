# setup complication
fpath+=~/.zfunc
autoload -U compinit
compinit

source ./zcomplication

#
# App setting
# 


setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_reduce_blanks  # 余分な空白は詰めて記録

export EDITOR="vim"

# homebrew 
# https://brew.sh/
case $OSTYPE in
  darwin*) eval "$(/opt/homebrew/bin/brew shellenv)" ;;
  linux*) eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" ;;
esac

# starship
# https://github.com/starship/starship
if (( $+commands[starship] == 0 )) ; then
  echo "Install starship ..."
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
fi
eval "$(starship init zsh)"

# pyenv
if (( $+commands[pyenv] )); then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
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
  if [ ! -e {~/.zsh} ]; then
    echo 'zsh extension tool install to ~/.zsh'
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
  fi
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



if [[ "$OSTYPE" == darwin* && "$USER" == near129 ]]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
          . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
      else
          export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
  # for google cloud
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  # for pencv
  export PYTHONPATH="/opt/homebrew/Cellar/opencv/4.5.2_1/lib/python3.9/site-packages"

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

  export PATH=$HOME/.nodebrew/current/bin:$PATH
  export PATH="/opt/homebrew/opt/llvm@11/bin:$PATH"
fi
