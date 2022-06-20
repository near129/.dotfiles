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
export BROWSER='open'

bindkey -e

(( $+commands[vivid] )) && export LS_COLORS=$(vivid generate iceberg-dark)

(( $+commands[starship] )) && eval "$(starship init zsh)"

if (( $+commands[fzf] )); then
  # need fd, exa, bat
  # インストール時にkeybindingsなどをインストールする
  # fdが探索アルゴリズムがbfsじゃないので浅い階層にあっても探索の最後の方まで表示されないのを防ぐ
  # --no-ignore --follow
  export FZF_DEFAULT_COMMAND="(fd --hidden --exclude .git -d 5 && fd --hidden --exclude .git --min-depth 6)"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="(fd --hidden --exclude .git -d 5 --type d && fd --hidden --exclude .git --min-depth 6 --type d)"
  export FZF_CTRL_T_OPTS='--select-1 --exit-0 --preview "(bat  --color=always --style=header,grid --line-range :100 {} || exa -T -L 2) 2>/dev/null"'
  export FZF_DEFAULT_OPTS='--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
  [ -f "${XDG_CONFIG_HOME}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME}"/fzf/fzf.zsh
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

alias pbc='pbcopy'
alias pbp='pbpaste'

case ${OSTYPE} in
  darwin*)
    ;;
  linux*)
    alias open='xdg-open'
    if [[ "$(uname -r)" == *microsoft* ]]; then
      alias pbcopy='/mnt/c/WINDOWS/system32/clip.exe'
      alias pbpaste='/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0//powershell.exe -Command Get-Clipboard'
    elif (( $+commands[xclip] )); then
      alias pbcopy='xclip -selection clipboard -in'
      alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'
    else
      echo "No clipboard util command. Recommned installing clip or xsel"
    fi
    ;;
esac

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
