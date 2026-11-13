function __git_worktree_branches --description 'List "<branch>\t<path>" for each worktree of the current repository'
    set -l path
    for line in (command git worktree list --porcelain 2>/dev/null)
        if string match -q 'worktree *' -- $line
            set path (string replace 'worktree ' '' -- $line)
        else if string match -q 'branch refs/heads/*' -- $line
            printf '%s\t%s\n' (string replace 'branch refs/heads/' '' -- $line) $path
        end
    end
end
