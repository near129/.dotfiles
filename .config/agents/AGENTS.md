# AGENTS.md

## Design Principles

Prioritize simplicity and better design; large changes are acceptable:

- Backward compatibility does not need to be maintained.
- Minimizing diff size is not a goal.
- Do not define fallback logic for unspecified cases — treat them as errors.
- Split into multiple files rather than separating concerns with comments within one file.

## Confirming Before Implementing

When receiving a proposal or question without an explicit implementation request, do not implement until alignment is reached:

- When multiple approaches are possible, present each option with trade-offs and ask the user to decide.

## Subagent Model Selection

Use lighter models for subagents to reduce cost:

- Search and exploration tasks → a lightweight model (e.g., `haiku`, `luna`)
- Implementation tasks (clear spec) → a mid-tier model (e.g., `sonnet`, `terra`)

If a task fails, retry with the session's main model.

## Tool-Based File Management

Prefer each ecosystem's package manager and project generator over manual file editing — e.g., `cargo` for Rust, `uv`/`poetry` for Python, `npm`/`yarn`/`pnpm` and `npx create-*` templates for Node.js.

Tools generate schema-valid output in the format each ecosystem recommends, and resolve versions correctly within configured constraints.

## System-Specific Tools

Prefer modern CLI alternatives:

- `eza` over `tree`
- `fd` over `find`
- `rg` over `grep`

Use `rg` and `jq` to filter output and keep context concise.

## Working in a Worktree

When asked to work in a worktree without a specified branch or path, create one using the tool's built-in worktree helper if available, otherwise `git worktree add`.

- Create worktrees from the default branch; create the correct base branch first if needed.
- Do not include `worktree` in branch names.
- Install dependencies after creation if the tool does not handle it automatically (e.g., `npm ci` for Node.js).
