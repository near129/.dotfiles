
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# setup complication
fpath+=~/.zfunc
autoload -U compinit
compinit

# export path
export PATH="/opt/homebrew/bin:$PATH"
# initialize pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
# initialize zsh-autosuggestion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH="$HOME/.cargo/bin:$PATH"
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
# alias
alias ls="exa --icons"
alias ll="exa -lh --icons"
alias l="exa --icons"
alias la="exa -a --icons"
alias youtube-dlx="youtube-dl -o '~/Movies/%(uploader)s/%(playlist)s/%(title)s.%(ext)s' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias vi='nvim'
alias vim='nvim'
alias dua=' du -scmh ./* ./.[^.]* | sort -rh'
alias ipython='jupyter-console'

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

