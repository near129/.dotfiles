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

## Prefer Minimal, Restricted Tools

When multiple tools can accomplish the same task, prefer the one with the smallest capability footprint:

- **JSON processing**: Use `jq` instead of Python. Python enables arbitrary code execution and network access — `jq` is purpose-built, read-only, and sufficient for most JSON operations.
- **General principle**: Prefer read-only tools over read-write tools, and tools without network access over those with it, when the task does not require those capabilities.

Examples:

- Filtering/transforming JSON output → `jq`, not `python -c` or a Python script
- Querying structured data → `jq`, `awk`, `grep` before reaching for a scripting language
- File inspection → dedicated read tools (`cat`, `jq`, etc.) over a script that could have side effects

Use a more powerful tool (Python, shell scripts, etc.) only when the simpler alternative cannot handle the task.

## Working in a Worktree

When the user asks to work in a worktree without specifying a branch or path, use the `EnterWorktree` tool. Skip it only when the user's instructions make it clearly unnecessary; when in doubt, use it.
