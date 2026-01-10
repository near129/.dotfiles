# Nix
if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end
for p in (string split ' ' -- $NIX_PROFILES)
    fish_add_function_path "$p/share/fish/vendor_functions.d"
    fish_add_complete_path "$p/share/fish/vendor_completions.d"
    for f in $p/share/fish/vendor_conf.d/*.fish
        test -f $f && source $f
    end
end

# Homebrew
switch (uname -s)
    case Darwin
        switch (uname -m)
            case arm64
                eval (/opt/homebrew/bin/brew shellenv)
            case x86_64
                eval (/usr/local/bin/brew shellenv)
        end
    case Linux
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
if set -q HOMEBREW_PREFIX
    fish_add_complete_path "$HOMEBREW_PREFIX/share/fish/vendor_completions.d"
    fish_add_complete_path "$HOMEBREW_PREFIX/share/fish/completions"
end

set fish_greeting
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state
# set -gx CLAUDE_CONFIG_DIR $XDG_CONFIG_HOME/claude
set -gx CODEX_HOME $XDG_CONFIG_HOME/codex
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin

fish_config theme choose Nord
# tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Few icons' --transient=No
set --global tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go kubectl distrobox toolbox terraform nix_shell crystal elixir zig

abbr -a mkdir 'mkdir -p'
abbr -a cp 'cp -r'
abbr -a mv 'mv -i'
abbr -a rm 'rm -i'
alias ls='eza --icons=auto'
alias cat='bat'
abbr -a l ls
abbr -a la 'ls -a'
abbr -a ll 'ls -l'
abbr -a lla 'ls -la'
abbr -a df 'df -kh'
abbr -a du 'du -kh'
abbr -a pbp pbpaste
abbr -a pbc pbcopy
abbr -a lg lazygit
abbr -a vi nvim
abbr -a vim nvim
abbr -a gs 'git status'
abbr -a --command git c commit
abbr -a --command git a add
abbr -a --command git w worktree
abbr -a --command git pushf 'push --force-with-lease --force-if-includes'
abbr -a --command git tree "log --graph --pretty=format:'%C(auto)%h %d %s %C(blue)(%cr) %C(green)<%an>"

zoxide init fish | source
