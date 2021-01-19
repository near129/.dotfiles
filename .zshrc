
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

# export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
