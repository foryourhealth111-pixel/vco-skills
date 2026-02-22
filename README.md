# VCO — Vibe Code Orchestrator

> One-stop ecosystem for Claude Code: unified task routing across 6+ plugins, with rules, hooks, commands, and automated installation.

VCO is a meta-skill that sits above your Claude Code plugins as a routing and coordination layer. Type `/vibe` and VCO classifies your task, selects optimal tools, applies conflict avoidance rules, and executes with quality gates.

## Quick Start

```bash
# Clone
git clone https://github.com/foryourhealth111-pixel/vco-skills.git
cd vco-skills

# Install everything (bash)
bash install.sh

# Or PowerShell (Windows)
.\install.ps1

# Verify
bash check.sh
```

Then edit `~/.claude/settings.json` to add your API credentials, start a new Claude Code session, and type `/vibe <your task>`.

## What Gets Installed

| Component | Files | Target |
|-----------|-------|--------|
| VCO Skill | SKILL.md + 5 protocols + 7 references | `~/.claude/skills/vibe/` |
| Rules | 9 common + 5 typescript | `~/.claude/rules/` |
| Hooks | write-guard.js + 2 hookify configs | `~/.claude/hooks/` |
| SuperClaude | 30+ sc:* commands (cloned from upstream) | `~/.claude/commands/sc/` |
| Plugins | 10 marketplace plugins | via `claude plugins install` |
| claude-flow | Multi-agent orchestration | via `npm install -g` |
| codex/ | Codex integration (exec wrapper, MCP config, templates) | `~/.codex/` |

## Architecture

```
/vibe <task>
    │
    ├── Quick Probe (Glob/Grep ×2)
    │
    ├── Grade Classification
    │   ├── M — Single agent (≤5 files, clear path)
    │   ├── L — Design → subagent (cross-module, design decisions)
    │   └── XL — TeamCreate swarm (parallelizable)
    │
    ├── Tool Selection (per grade × task type)
    │   ├── Planning:  sc:design │ brainstorming+plans │ TeamCreate
    │   ├── Coding:    tdd-guide │ subagent-driven-dev │ TeamCreate
    │   ├── Review:    code-reviewer │ two-stage review │ multi-reviewer
    │   ├── Debug:     systematic-debugging │ parallel │ debug team
    │   └── Research:  sc:research │ deep-research │ research team
    │
    └── Quality Gates: P5 (evidence-based) + V2 (completion) + V3 (pipeline)
```

## Plugin Ecosystem

### Core (Required)

| Plugin | Source | Role in VCO |
|--------|--------|-------------|
| [superpowers](https://github.com/obra/superpowers) | superpowers-marketplace | L grade: brainstorming, writing-plans, subagent-driven-dev, deep-research |
| [everything-claude-code](https://github.com/punkpeye/everything-claude-code) | everything-claude-code | M grade agents: tdd-guide, code-reviewer, planner, architect |
| [claude-code-settings](https://github.com/feiskyer/claude-code-settings) | claude-code-settings | Structured analysis: think-harder, think-ultra |
| [hookify](https://github.com/anthropics/claude-code-plugins) | claude-plugins-official | Hook management |
| [ralph-loop](https://github.com/frankbria/ralph-claude-code) | claude-plugins-official | Autonomous development loop |
| [SuperClaude](https://github.com/SuperClaude-Org/SuperClaude_Framework) | Git clone | sc:* commands (design, research, brainstorm) |

### Recommended (Optional)

| Plugin | Role | Fallback |
|--------|------|----------|
| [episodic-memory](https://github.com/obra/superpowers) | Cross-session vector memory | TodoWrite |
| [serena](https://github.com/anthropics/claude-code-plugins) | Semantic code analysis + project memory | Glob/Grep |
| [context7](https://github.com/anthropics/claude-code-plugins) | Library documentation lookup | WebSearch |
| [claude-flow](https://github.com/ruvnet/claude-flow) | XL grade multi-agent swarm | TeamCreate native |
| [spec-kit](https://github.com/github/spec-kit) | Spec-driven development reference | — |

## Repository Structure

```
vco-skills/
├── install.sh                  # Bash installer
├── install.ps1                 # PowerShell installer
├── check.sh                    # Health check
├── skills/
│   └── vibe/                   # VCO core
│       ├── SKILL.md            # Router + grade definitions
│       ├── protocols/          # 5 execution protocols
│       └── references/         # 7 reference docs
├── rules/
│   ├── common/                 # 9 universal rules
│   │   ├── agents.md           # Agent orchestration patterns
│   │   ├── coding-style.md     # Immutability, file organization
│   │   ├── engineering-instincts.md  # Core engineering principles
│   │   ├── git-workflow.md     # Commit format, PR workflow
│   │   ├── hooks.md            # Hook system usage
│   │   ├── patterns.md         # Design patterns
│   │   ├── performance.md      # Model selection, context management
│   │   ├── security.md         # Security checklist
│   │   └── testing.md          # TDD, 80% coverage requirement
│   └── typescript/             # 5 TypeScript-specific rules
├── hooks/
│   ├── write-guard.js          # Block unnecessary file creation
│   └── hookify-configs/        # Hookify plugin configs
├── config/
│   ├── settings.template.json  # Sanitized settings (add your API key)
│   └── plugins-manifest.json   # Full plugin list with install commands
└── CHANGELOG.md
```

## Install Options

```bash
# Full install (everything)
bash install.sh

# Skip marketplace plugins (install them manually later)
bash install.sh --skip-plugins

# Skip SuperClaude (if you already have it)
bash install.sh --skip-superclaude

# Skip claude-flow (only needed for XL grade)
bash install.sh --skip-claude-flow
```

## Conflict Avoidance

| Rule | Prevents |
|------|----------|
| Agent Boundary | M=single-agent, L=subagent, XL=TeamCreate. One system per task. |
| Memory Division | TodoWrite=state, ruflo=vectors, Serena=project, instincts=behavior. |
| Command Priority | User explicit > VCO routing > plugin defaults. |

## Codex Cross-Model IntegrationVCO can delegate tasks to OpenAI Codex for cross-model benefits:```bash# MCP integration — Codex tools appear as native Claude Code tools# Add to Claude Code MCP config:# "codex": { "command": "codex", "args": ["mcp-server"] }# Task delegation — non-interactive executioncodex exec "optimize the sorting algorithm" --full-auto -o result.txt# Dual-model review — different model = different blind spotscodex review --uncommitted "Focus on security vulnerabilities"# Cross-tool shared instructionsln -s CLAUDE.md AGENTS.md```See `codex/` directory for wrapper scripts, MCP config, and templates.
## Version

- VCO: 2.1.0
- Ecosystem: 1.0.0

## License

MIT
