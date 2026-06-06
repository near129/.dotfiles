# CLAUDE.md

## Tool-Based File Management

Prefer using appropriate tools over manual file editing when tools are available in the environment:

- **Python**: `uv add/remove`, `poetry add/remove` for pyproject.toml
- **Node.js**: `npm install`, `yarn add`, `pnpm add` for package.json
- **Git**: `git config` for .gitconfig
- **Other ecosystems**: Use corresponding package managers and configuration tools

Exceptions allowed when:

- Tool is not available in the environment
- Template generation scenarios
- Manual editing is demonstrably more appropriate

Do not install new tools solely for file generation/modification.

## System-Specific Tools

This system does not have `tree` command installed. Use `eza` command instead for directory tree visualization.

Prefer modern alternatives for common CLI tools:

- **File search**: `fd` instead of `find`
- **Content search**: `rg` (ripgrep) instead of `grep`

## Large Command Output

When a command is expected to produce large output, prefer JSON output mode if the tool supports it, then pipe through `jq` to filter or extract only the needed fields. This avoids flooding the context with unnecessary text.

Examples:

- `gh pr list --json number,title,state | jq '.[] | select(.state == "OPEN")'`
- `docker inspect <container> | jq '.[0].NetworkSettings.Ports'`
- `kubectl get pods -o json | jq '.items[] | {name: .metadata.name, phase: .status.phase}'`

Always prefer a narrow `jq` filter over printing the full JSON blob.

## Prefer Minimal, Restricted Tools

When multiple tools can accomplish the same task, prefer the one with the smallest capability footprint:

- **JSON processing**: Use `jq` instead of Python. Python enables arbitrary code execution and network access — `jq` is purpose-built, read-only, and sufficient for most JSON operations.
- **General principle**: Prefer read-only tools over read-write tools, and tools without network access over those with it, when the task does not require those capabilities.

Examples:

- Filtering/transforming JSON output → `jq`, not `python -c` or a Python script
- Querying structured data → `jq`, `awk`, `grep` before reaching for a scripting language
- File inspection → dedicated read tools (`cat`, `jq`, etc.) over a script that could have side effects

Use a more powerful tool (Python, shell scripts, etc.) only when the simpler alternative cannot handle the task.

## Capturing Exit Codes

When the shell execution tool does not provide a way to retrieve the exit code, append `; echo "exit: $?"` to the command so the exit status is visible in the output:

```sh
some-command; echo "exit: $?"
```

## Git Command Guidelines

Avoid `git -C <path>` whenever possible. The `-C` flag changes the working directory inline, which makes the tool call harder to review and auto-accept in permission prompts. Prefer `cd`-ing to the target directory first, or rely on the fact that git already operates on the current working tree.

## Working in a Worktree

When the user asks to work in a worktree without specifying a branch or path, use the `EnterWorktree` tool. Skip it only when the user's instructions make it clearly unnecessary; when in doubt, use it.

`EnterWorktree` creates worktrees from the default branch. When the project or situation requires starting from another branch, create the branch from the correct base first, then use `EnterWorktree`.

Do not add `worktree` to branch names solely because they are used for worktrees.

When entering a worktree for a project, install dependencies before running project tools if they are not already installed — or if you know they will be missing (e.g., `node_modules` absent after a fresh worktree checkout). Run the appropriate install command first:

- **Node.js**: `npm ci` (preferred for reproducibility) or `npm install`
- **Python**: `uv sync` or `pip install -r requirements.txt`
- **Other ecosystems**: use the corresponding install command

Do this proactively when you can predict the error, not only after it occurs.
