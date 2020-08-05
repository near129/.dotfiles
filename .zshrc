
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

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:/Users/ryotaro/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$PATH:/Users/ryotaro/.lacal/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$HOME/.poetry/bin:$PATH"
export PIPENV_VENV_IN_PROJECT=1export PATH="/usr/local/opt/tcl-tk/bin:$PATH"

export PIPENV_VENV_IN_PROJECT=true
export PYTHON_CONFIGURE_OPTS="--with-tcltk-includes='-I/usr/local/opt/tcl-tk/include' --with-tcltk-libs='-L/usr/local/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"

# /Users/ryotaro/.zprezto/modules/directory/init.zsh内に元々入っていたエリアスがある！！
d() {
    /Users/ryotaro/.pyenv/versions/3.8.0/bin/python ~/python/dictionary/dict.py $1
}
chrome() {open -a "Google Chrome.app" $1}
dict() {open dict://$1; }
g() {open "https://www.google.co.jp/search?q=$1"}
alias sl="osascript -e 'tell application \"Finder\" to sleep'"

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

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH="/usr/local/bin:$PATH"
alias ls="exa --icons"
alias ll="exa -lh --icons"
alias l="exa --icons"
alias la="exa -a --icons"

# alias ojc="oj-prepare `pbp`" # コピーしたurlでコンテストのディレクトリを作成
ojc() {oj-prepare `pbp`}
ojac() {oj-prepare "https://atcoder.jp/contests/$1"} # 引数にコンテスト名
# t() {oj t -d $1/test -c "~/.pyenv/versions/pypy3.6-7.3.0/bin/pypy3 $1/main.py" -S}
t() {oj t -d $1/test -c "python $1/main.py" -S}
tcpp() {
    g++ $1/main.cpp
    oj t -d $1/test -S
}
s() {
    # test and submit(python)
    current=`pwd`
    cd $1
    oj test -c "python main.py" && oj s main.py --no-open -l Python -y -w 0
    cd $current
}
ss() {
    current=`pwd`
    cd $1
    oj s main.py --no-open -l Python -y -w 0
    cd $current
}
sp() {
    current=`pwd`
    cd $1
    oj s main.py --no-open --guess-python-interpreter pypy -y -w 0
    cd $current 
}
scpp() {
    current=`pwd`
    cd $1
    oj s main.cpp --no-open -y -w 0
    cd $current
}

alias vi='nvim'
alias vim='nvim'
alias vimcf='vim ~/.config/nvim/init.vim'
alias zshcf='vim ~/.zshrc'
alias source_nvim='source ~/.config/nvim/init.vim'
# vimでターミナルを操作する時こっちだと反映されないので.zshvevにも記述する
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi
