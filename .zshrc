# setup complication
fpath+=~/.zfunc
autoload -U compinit
compinit

export EDITOR="vim"
# homebrew 
# https://brew.sh/
eval "$(/opt/homebrew/bin/brew shellenv)"
# starship
# https://github.com/starship/starship
eval "$(starship init zsh)"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
# cargo
export PATH="$HOME/.cargo/bin:$PATH"
# zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# zsh-autosuggestions
# https://github.com/zsh-users/zsh-history-substring-search
source "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down


# alias
alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"
alias mv="${aliases[mv]:-mv} -i"
alias rm="${aliases[rm]:-rm} -i"

if (type "exa" > /dev/null 2>&1); then
    alias ls="exa --icons"
fi
alias l="ls -1"
alias ll="ls -lh"
alias la="ll -a"

if (type "nvim" > /dev/null 2>&1); then
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

