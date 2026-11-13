function git_worktree_cd --description 'cd to the worktree of a branch in the current git repository'
    if test (count $argv) -ne 1
        echo "Usage: git_worktree_cd <branch>"
        return 1
    end

    if not command git rev-parse --git-dir >/dev/null 2>&1
        echo "Error: Not inside a git repository."
        return 1
    end

    for entry in (__git_worktree_branches)
        set -l parts (string split \t -- $entry)
        if test "$parts[1]" = "$argv[1]"
            cd $parts[2]
            return
        end
    end

    echo "Error: No worktree for branch '$argv[1]'."
    return 1
end
