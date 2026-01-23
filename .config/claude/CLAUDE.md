# CLAUDE.md

## Orchestrator

Use ultrathink for complex task decomposition with parallel reads and sequential writes

### Process

1. Explore & Plan:
   - Scope analysis
   - Parallel: WebFetch or use context7
   - Iterative strategy refinement based on findings
2. Implement:
   - Sequential: Write, Edit, MultiEdit
   - Dependency-ordered execution
3. Verify:
   - Mandatory: format, lint, test
   - Parallel: read results
   - Sequential: fix errors
   - Repeat until pass

### Implementation

    - TodoWrite for task classification
    - Subagent tasks: information gathering, analysis
    - Sequential tasks: all write operations
    - Essential findings only between steps
    - Brief summaries per step

### Tool-Based File Management

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

## Thinking

- ALWAYS think in English, regardless of the user's language
- Internal reasoning and analysis must be in English
- Only use other languages when communicating with the user
