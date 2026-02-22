# Agent Instructions

Shared guidance for all AI coding tools (Claude Code, OpenAI Codex, Gemini CLI, Cursor, Copilot).

## Core Principles

- Do what has been asked; nothing more, nothing less.
- Prefer editing existing files over creating new ones.
- Never create documentation files unless explicitly requested.
- Verify your solution before finishing.
- Reuse existing code wherever possible.
- Focus on targeted modifications rather than large-scale changes.
- When updating code, check for related code that may need consistent updates.

## Code Quality

- Immutable data patterns — create new objects, never mutate existing ones.
- Functions under 50 lines, files under 800 lines.
- Handle errors explicitly at every level.
- Validate all user input at system boundaries.
- No hardcoded secrets — use environment variables.

## Workflow

- Write tests first (RED), implement to pass (GREEN), refactor (IMPROVE).
- Commit messages: `<type>: <description>` (feat, fix, refactor, docs, test, chore).
- Review code for security before committing.

## Cross-Tool Setup

This file is shared across tools via symlink:
```bash
ln -s AGENTS.md CLAUDE.md   # Claude Code reads CLAUDE.md
# Or: ln -s CLAUDE.md AGENTS.md  # If CLAUDE.md is primary
```
