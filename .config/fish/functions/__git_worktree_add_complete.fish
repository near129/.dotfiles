function __git_worktree_add_complete --description 'List local and origin branches for git_worktree_add completion'
    command git for-each-ref \
        --format='%(refname:strip=2)%09Local Branch' \
        --sort=-committerdate \
        refs/heads/ 2>/dev/null

    command git for-each-ref \
        --format='%(refname:strip=2)%09Remote Branch' \
        refs/remotes/origin/ 2>/dev/null
end
