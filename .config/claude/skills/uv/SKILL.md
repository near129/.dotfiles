---
name: uv
description: Prefer uv for Python projects unless other tools are detected in pyproject.toml or config
user-invocable: false
---

# uv Skill

Prefer **uv** for Python projects. However, respect existing tools when detected in the project.

## Priority Rules

### Default Behavior
- Use uv for Python projects

### Exceptions: Existing Tool Detection
Use existing tools when detected:
- `[tool.poetry]` in `pyproject.toml` → use **poetry**
- `Pipfile` exists → use **pipenv**
- Only `requirements.txt` without `pyproject.toml` → use **pip**

## Correct Command Patterns

### Dependency Management

```bash
# Add dependencies
uv add <package>              # Regular dependency
uv add --dev <package>        # Development dependency (alias for --group dev)
uv add --group <name> <pkg>   # Add to specific group

# Remove dependencies
uv remove <package>
```

### Environment & Lockfile

```bash
# Sync lockfile and environment
uv sync

# Update lockfile only
uv lock

# Run commands in project environment
uv run <command>
uv run pytest                 # Run tests
uv run python script.py       # Run script
```

### Tool & Python Management

```bash
# Install global tools
uv tool install <package>

# Run tools temporarily (no install required)
uvx <command>

# Python version management
uv python install 3.12        # Install Python
uv python pin 3.12            # Pin project version
```

### Scripts (PEP 723 Inline Metadata)

```bash
# Add dependency to script
uv add --script example.py 'requests'

# Generate lockfile for script
uv lock --script example.py

# Run script with dependencies
uv run example.py
```

## Using dependency-groups

Define dependency-groups in `pyproject.toml`:

```toml
[dependency-groups]
dev = ["pytest", "ruff"]
lint = ["ruff"]
test = ["pytest", "pytest-cov"]

# Include other groups
dev = [
  {include-group = "lint"},
  {include-group = "test"}
]

[tool.uv]
default-groups = ["dev"]  # Groups to include by default
```

Command examples:
```bash
# Install specific group dependencies
uv sync --group test

# Multiple groups
uv sync --group test --group lint

# All groups
uv sync --all-groups
```

## Additional Information

For more detailed information about uv:
- Access `https://docs.astral.sh/uv/llms.txt` for latest documentation
