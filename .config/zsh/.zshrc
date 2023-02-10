if [[ -e $HOME/dev/tmp/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]]; then
  source $HOME/dev/tmp/zsh-autocomplete/zsh-autocomplete.plugin.zsh
  zstyle ':autocomplete:*' min-input 1
  zle -A {.,}history-incremental-search-forward
  zle -A {.,}history-incremental-search-backward
  bindkey '^N' down-line-or-select
  bindkey -M menuselect '^N' down-history
fi

fpath+=$XDG_DATA_HOME/zsh/completion
autoload -U compinit
compinit -d $XDG_STATE_HOME/zcompdump

path=(
  "$HOME/.local/bin"(N-/)
  "$path[@]"
)

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
# export BROWSER='open'
bindkey -e

export HISTFILE="$XDG_STATE_HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

setopt AUTO_PUSHD

setopt MAGIC_EQUAL_SUBST
setopt COMPLETE_IN_WORD 
setopt ALWAYS_TO_END
setopt PATH_DIRS
setopt AUTO_MENU
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
setopt EXTENDED_GLOB
unsetopt MENU_COMPLETE
unsetopt FLOW_CONTROL
unsetopt CASE_GLOB

# Standard style used by default for 'list-colors'
# LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}
# Defaults.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
# zstyle ':completion:*' format ' -- %d --'

zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
# Environment Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
# ... unless we really want to.
zstyle '*' single-ignored show
# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# SSH/SCP/RSYNC
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

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

(( $+commands[vivid] )) && export LS_COLORS=$(vivid generate iceberg-dark)
(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
if (( $+commands[fzf] )); then
   source $XDG_CONFIG_HOME/fzf/fzf.zsh
   source $XDG_CONFIG_HOME/fzf_user/config.zsh
fi
if (( $+HOMEBREW_PREFIX )); then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $HOMEBREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
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
