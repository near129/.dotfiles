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
