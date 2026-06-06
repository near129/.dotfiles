---
name: git-merge
description: Merge another branch's latest changes into the current branch. Shows incoming changes before merging and verifies both the original and incoming changes are reflected afterward.
argument-hint: [target-branch]
allowed-tools: Bash(git status:*), Bash(git branch:*), Bash(git fetch:*), Bash(git log:*), Bash(git diff:*), Bash(git rev-list:*), Bash(git rev-parse:*), Bash(git symbolic-ref:*), Bash(git merge:*), Bash(git stash:*), Bash(git add:*), Bash(git push:*), Read
---

Merge the latest changes from another branch into the current branch.

## Steps

1. **Validate preconditions**
   - Run `git branch --show-current` to get the current branch. If empty (detached HEAD), stop and inform the user.
   - Run `git status --porcelain` to check for uncommitted changes. If any exist, use `AskUserQuestion` to ask whether to stash or abort. If stash: run `git stash` and proceed; if abort: stop.

2. **Determine the target branch**
   - If `$ARGUMENTS` is provided, use it as the target branch.
   - Otherwise, detect the default branch: `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'`
   - If detection fails, use `AskUserQuestion` to ask the user.
   - Verify the branch exists: `git rev-parse --verify origin/<target> 2>/dev/null`. If not found on remote, try `git rev-parse --verify <target>` for local-only repos.

3. **Fetch latest remote state**
   - Run `git fetch origin`. If no remote exists, skip and use local branch ref directly.

4. **Show incoming changes (pre-check)**
   - Run `git rev-list --count HEAD..origin/<target>` to get the incoming commit count.
   - If count is 0, inform the user the branch is already up-to-date and stop.
   - Run `git log --oneline HEAD..origin/<target>` to list incoming commits.
   - Run `git diff --stat HEAD...origin/<target>` for a file-level summary.
   - If the user wants more detail, use `Read` on specific files or run `git diff HEAD...origin/<target>` on individual paths.
   - Present the summary and wait for the user to acknowledge before proceeding.

5. **Run the merge**
   - Run `git merge origin/<target>`.
   - If the merge fails due to conflicts, go to step 6. Otherwise, go to step 7.

6. **Handle conflicts (if any)**
   - Run `git diff --name-only --diff-filter=U` to list conflicted files.
   - Use `Read` to inspect each conflicted file and show the conflict markers to the user.
   - Use `AskUserQuestion` to ask whether to resolve conflicts or abort.
   - If abort: run `git merge --abort` and inform the user.
   - If resolve: help the user fix each conflict, stage resolved files with `git add <file>`, then run `git merge --continue`.

7. **Verify the result**
   - Run `git log --oneline -10` to confirm the current branch history. The merge commit should be at HEAD, and the user's original commits should be present.
   - Run `git log --oneline HEAD..origin/<target>` — this must be empty (no commits on the target that are not in the current branch).
   - Run `git diff --stat origin/<target>...HEAD` to show what the current branch has beyond the target (the user's own work).
   - Report: method used (merge), target branch, number of commits integrated, and current HEAD.
   - If changes were stashed in step 1, run `git stash pop` and report any conflicts.

8. **Check if incoming changes require follow-up work on this branch**
   - Regardless of whether conflicts occurred, review the incoming changes with `git diff HEAD~1...origin/<target>` (or compare the full incoming diff) and the current branch's diff with `git diff --stat origin/<target>...HEAD`.
   - Use `Read` to inspect relevant files from both sides as needed.
   - Analyze whether the incoming changes (e.g., API changes, interface updates, dependency bumps, renamed symbols, behavior changes) require corresponding modifications in the files that the current branch has changed or depends on.
   - Report any follow-up actions the user should take, even if there were no git conflicts. Examples: an interface the current branch implements was changed upstream, a function signature was updated, a shared config was restructured.
   - If no follow-up is needed, explicitly confirm that the current branch's changes are compatible with the incoming changes.

9. **Push (if needed)**
   - Ask the user if they want to push the updated branch: `git push origin <current-branch>`.

## Rules

- Never force-push.
- Always fetch before comparing to ensure remote-tracking refs are current.
- Use `origin/<target>` as the comparison ref after fetching; fall back to the local ref only when no remote exists.
- Do not modify files to resolve conflicts without user guidance.
- Do not proceed past the pre-check without user acknowledgment.
