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

## Thinking

- ALWAYS think in English, regardless of the user's language
- Internal reasoning and analysis must be in English
- Only use other languages when communicating with the user
