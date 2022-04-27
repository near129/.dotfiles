# setup complication
fpath+=~/.zfunc
autoload -U compinit
compinit

source `dirname $0`/.zcomplication

autoload -U zcalc

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_reduce_blanks  # 余分な空白は詰めて記録
setopt share_history

setopt magic_equal_subst # for anything=expression

setopt auto_pushd # for `cd -[0-9]`

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
(( $+commands[bat] )) && export PAGER="bat"
export BROWSER='open'

bindkey -e

#export LS_COLORS=$(vivid generate nord)

# https://github.com/starship/starship
(( $+commands[starship] )) && eval "$(starship init zsh)"

# fzf
if (( $+commands[fzf] )); then
  # need fd, exa, bat
  # インストール時にkeybindingsなどをインストールする
  # ~/.zsh/fzf.pluting_.zsh
  export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --color=always'  # --no-ignore --follow
  # fdが探索アルゴリズムがbfsじゃないので浅い階層にあっても探索の最後の方まで表示されないのを防ぐ
  export FZF_DEFAULT_COMMAND="($FZF_DEFAULT_COMMAND -d 5 && $FZF_DEFAULT_COMMAND --min-depth 6)"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
  export FZF_CTRL_T_OPTS='--select-1 --exit-0 --preview "(bat  --color=always --style=header,grid --line-range :100 {} || exa -T -L 2) 2>/dev/null"'
  export FZF_DEFAULT_OPTS='--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git" . "$1"
  }
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

if (( $+commands[brew] )); then
  source `brew --prefix`/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


alias mkdir="${aliases[mkdir]:-mkdir} -p"
alias cp="${aliases[cp]:-cp} -i"
alias ln="${aliases[ln]:-ln} -i"
alias mv="${aliases[mv]:-mv} -i"
alias rm="${aliases[rm]:-rm} -i"

(( $+commands[exa] )) && alias ls="exa --icons" # need nerd font
(( $+commands[bat] )) && alias cat="bat"

alias ll="ls -lh"
alias la="ls -a"
alias lt="ls -T"
alias lla="ls -la"
alias lal="ls -la"

(( $+commands[nvim] )) && alias vi='nvim' && alias vim='nvim'

alias df='df -kh'
alias du='du -kh'


case ${OSTYPE} in
  darwin*)
    ;;
  linux*)
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
    ;;
esac

 alias pbc='pbcopy'
 alias pbp='pbpaste'
