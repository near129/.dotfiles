---
name: git-sync
description: Merge or rebase the current branch against another branch. Use when the user asks to merge or rebase a branch.
allowed-tools: Bash(git status:*), Bash(git branch:*), Bash(git fetch:*), Bash(git log:*), Bash(git diff:*), Bash(git rev-list:*), Bash(git rev-parse:*), Bash(git symbolic-ref:*), Bash(git merge:*), Bash(git rebase:*), Bash(git stash:*), Bash(git add:*), Bash(git push:*), Read
---

Sync the current branch with another branch via merge or rebase.

## Method

Determine from the user's instruction (merge/rebase). If unclear, ask.

## Steps

1. Get current branch (`git branch --show-current`). Stop if detached HEAD.
2. If uncommitted changes exist, ask to stash or abort.
3. Determine target from `$ARGUMENTS`, detect default branch, or ask.
4. `git fetch origin` (skip if no remote).
5. **Rebase only**: Show incoming commits and diff stat. Stop if already up-to-date. Wait for acknowledgment.
6. Run `git merge origin/<target>` or `git rebase origin/<target>`.
   - Rebase: check for in-progress rebase first.
7. Conflicts: **merge resolves automatically**, **rebase shows conflicted files and asks to resolve or abort**.
8. Verify commits landed and current branch's changes are intact.
9. Review incoming changes for API/interface/behavior changes requiring follow-up in the current branch.
10. Ask whether to push. Use `--force-with-lease` for rebase.

## Rules

- Never use `--force` without `--force-with-lease`.
- Do not proceed past step 5 (rebase) without user acknowledgment.
