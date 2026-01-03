function git_worktree_add --description 'Add a git worktree under ~/dev/git-worktrees/<repo>/<branch>'
    if not type -q git
        echo "Error: git command not found."
        return 1
    end

    if test (count $argv) -ne 1
        echo "Usage: git_worktree_add <branch-or-remote-name>"
        return 1
    end

    set name $argv[1]

    set repo_root (command git rev-parse --show-toplevel 2>/dev/null)
    if test $status -ne 0 -o -z "$repo_root"
        echo "Error: Not inside a git repository."
        return 1
    end

    set base $HOME/dev/git-worktrees/(basename "$repo_root")
    mkdir -p "$base"

    set dir_name (string replace -r '^origin/' '' -- "$name")

    set worktree_path "$base/$dir_name"

    if test -d "$worktree_path"
        echo "Error: Worktree already exists at '$worktree_path'."
        return 1
    end

    command git worktree add "$worktree_path" "$name"

    if test $status -ne 0
        echo "Error: Failed to add worktree for '$name'."
        return 1
    end

    echo "Worktree for '$name' added at '$worktree_path'."
end

function __git_worktree_add_complete
    command git for-each-ref \
        --format='%(refname:strip=2)%09Local Branch' \
        --sort=-committerdate \
        refs/heads/ 2>/dev/null

    command git for-each-ref \
        --format='%(refname:strip=2)%09Remote Branch' \
        refs/remotes/origin/ 2>/dev/null
end

complete -c git_worktree_add -f -a "(__git_worktree_add_complete)"
