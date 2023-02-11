# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# need fd, exa, bat
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
