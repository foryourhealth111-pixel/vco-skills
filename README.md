# VCO — Vibe Code Orchestrator

> Unified orchestration layer for Claude Code that intelligently routes tasks across 6 integrated plugins, eliminating tool selection confusion and preventing plugin conflicts.

VCO acts as a **meta-skill** — it doesn't replace any existing tool, but sits above them as a routing and coordination layer. When you type `/vibe`, VCO classifies your task by complexity and type, selects the optimal tool combination, applies conflict avoidance rules, and executes with quality injection.

## Why VCO?

When you install multiple Claude Code plugins, you face:
- **Tool overlap**: 3+ plugins can do code review, 2+ can do brainstorming, 2+ can do research
- **Conflict risk**: Running multiple agent systems simultaneously causes unpredictable behavior
- **Decision fatigue**: Choosing between 100+ MCP tools, 30+ skills, and 20+ agents per task

VCO solves this by providing a single entry point (`/vibe`) that makes all routing decisions automatically.

## Architecture

```
                         /vibe (user input)
                              |
                    ┌─────────┴─────────┐
                    │   VCO Router      │
                    │  (SKILL.md)       │
                    └─────────┬─────────┘
                              |
              ┌───────────────┼───────────────┐
              |               |               |
        ┌─────┴─────┐  ┌─────┴─────┐  ┌─────┴─────┐
        │ Classify   │  │ Route     │  │ Execute   │
        │ S/M/L/XL   │  │ Protocol  │  │ + Verify  │
        └─────┬─────┘  └─────┬─────┘  └─────┬─────┘
              |               |               |
    ┌─────────┴─────────────┴─────────────┴─────────┐
    │              6 Integrated Plugins               │
    ├─────────┬──────────┬──────────┬────────────────┤
    │Superpow.│SuperCl.  │Every-CC  │Claude-flow     │
    │         │          │          │(ruflo)         │
    │Ralph-lp │CCS       │          │                │
    └─────────┴──────────┴──────────┴────────────────┘
```

### Core Concepts

**Grade-Based Routing**: Every task is classified into one of 4 complexity grades:

| Grade | Signal | Agent System |
|-------|--------|-------------|
| S (Simple) | Single file, clear fix | Direct action (no agent) |
| M (Medium) | Multi-file, needs context | Everything-CC agents |
| L (Large) | Architecture change, 5+ files | Superpowers subagent system |
| XL (Extra-Large) | Multi-agent, cross-project | Claude-flow/ruflo swarm |

**Protocol System**: Tasks are routed to specialized protocols:
- `vibe-analysis` — Pre-routing structured analysis
- `vibe-think` — Planning, design, research
- `vibe-code` — Implementation, debugging, testing
- `vibe-review` — Code review, security audit
- `vibe-quality-injection` — Quality pattern injection for multi-agent workflows
- `vibe-orchestrate` — Multi-agent coordination
- `vibe-memory` — Cross-session memory and learning

**Conflict Avoidance**: Behavioral rules prevent plugin conflicts:
- Agent System Mutual Exclusion (one agent system per task)
- Memory System Division (each memory system has a specific role)
- Hook Coexistence (all hooks run, VCO controls tool invocation)
- Command Priority (VCO > sc:* > individual plugins)

## Prerequisites

VCO requires the following 6 plugins to be installed in Claude Code. Each plugin provides specific capabilities that VCO orchestrates.

### Required Plugins

| # | Plugin | Source | Install |
|---|--------|--------|---------|
| 1 | **Superpowers** | [obra/superpowers](https://github.com/anthropics/claude-code-plugins) | Claude Code marketplace |
| 2 | **SuperClaude** | [bsmi021/superclaude](https://github.com/bsmi021/superclaude) | Manual install to `~/.claude/commands/sc/` |
| 3 | **Ralph-loop** | [frankbria/ralph-claude-code](https://github.com/frankbria/ralph-claude-code) | Claude Code marketplace |
| 4 | **Claude-code-settings** | [feiskyer/claude-code-settings](https://github.com/feiskyer/claude-code-settings) | Claude Code marketplace |
| 5 | **Everything-claude-code** | [punkpeye/everything-claude-code](https://github.com/punkpeye/everything-claude-code) | Claude Code marketplace |
| 6 | **Claude-flow/ruflo** | [ruvnet/claude-flow](https://github.com/ruvnet/claude-flow) | `npm install -g claude-flow` + MCP config |

### Plugin Installation

**Marketplace plugins** (1, 3, 4, 5): Install via Claude Code settings or `claude plugins install <name>`.

**SuperClaude** (2): Follow the [SuperClaude installation guide](https://github.com/bsmi021/superclaude). Typically:
```bash
git clone https://github.com/bsmi021/superclaude.git
# Copy commands to ~/.claude/commands/sc/
```

**Claude-flow** (6): Install globally and configure MCP:
```bash
npm install -g claude-flow
# Add ruflo MCP server to your Claude Code MCP config
```

> VCO degrades gracefully — if a plugin is missing, it falls back to the next available tool in the fallback chain. See `references/fallback-chains.md` for details.

## Installation

### Step 1: Clone this repository

```bash
git clone https://github.com/foryourhealth111-pixel/vco-skills.git
```

### Step 2: Copy skills to Claude Code skills directory

```bash
# Copy all 5 skill directories
cp -r vco-skills/skills/vibe ~/.claude/skills/vibe
cp -r vco-skills/skills/vibe-build ~/.claude/skills/vibe-build
cp -r vco-skills/skills/vibe-flow ~/.claude/skills/vibe-flow
cp -r vco-skills/skills/vibe-plan ~/.claude/skills/vibe-plan
cp -r vco-skills/skills/vibe-review ~/.claude/skills/vibe-review
```

### Step 3: Verify installation

Start a new Claude Code session and type:
```
/vibe Hello, verify VCO is working
```

VCO should classify this as an S-grade task and respond directly.

## Usage

### Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `/vibe <task>` | Auto-route any task | `/vibe Add user authentication` |
| `/vibe:build <task>` | Direct to coding mode | `/vibe:build Fix the login bug` |
| `/vibe:plan <task>` | Direct to planning mode | `/vibe:plan Design the API layer` |
| `/vibe:review <task>` | Direct to review mode | `/vibe:review Security audit the auth module` |
| `/vibe:flow <task>` | Direct to orchestration mode | `/vibe:flow Refactor the entire data layer` |

### How Routing Works

When you type `/vibe Add a caching layer to the API`:

1. **CLASSIFY**: VCO determines this is L grade (architecture change) + Coding type
2. **ANALYZE**: Invokes `claude-code-settings:think-ultra` for structured analysis
3. **DECOMPOSE**: Invokes `superpowers:writing-plans` to break into phases
4. **SELECT**: Picks Superpowers subagent-driven-dev (L grade coding)
5. **CHECK**: Verifies no agent conflicts, checks fallback availability
6. **CONTEXT**: Estimates context budget, plans compaction points
7. **MEMORY**: Queries episodic-memory for related past decisions
7.5. **QUALITY-INJECT**: Injects quality patterns from single-agent tools
8. **EXECUTE**: Runs the selected protocol
8.5. **QUALITY-VERIFY**: Validates output against quality checklist
9. **REVIEW**: Auto-triggers code reviewer
10. **FEEDBACK**: Extracts learning for future sessions

### Tool Selection Matrix

| Task Type | S Grade | M Grade | L Grade | XL Grade |
|-----------|---------|---------|---------|----------|
| Planning | Direct answer | SuperClaude sc:design | Superpowers brainstorming + writing-plans | ruflo workflow_create |
| Coding | Direct edit | Everything-CC tdd-guide | Superpowers subagent-driven-dev | ruflo hive-mind_spawn |
| Review | ECC code-reviewer | Parallel: code + security | Superpowers two-stage review | ruflo agent cluster |
| Debug | Direct fix | systematic-debugging | systematic-debugging + parallel | ruflo swarm debug |
| Research | Direct search | sc:research | deep-research | ruflo embeddings + memory |

### Quality Injection (L/XL Grade)

VCO's unique feature: it extracts quality patterns from single-agent tools and injects them into multi-agent workflows.

**Pre-Injection Patterns** (before execution):
- P1: Root Cause Discipline (from systematic-debugging)
- P2: Effort Allocation (from sc:research)
- P3: Structured Analysis (from think-ultra)
- P4: Scientific Method (from systematic-debugging)
- P5: Evidence-Based Communication (from verification-before-completion)
- P6: PDCA Cycle (from sc:pm)

**Post-Validation Patterns** (after execution):
- V1: Evidence Chain Verification
- V2: Completion Gate
- V3: 6-Phase Quality Pipeline
- V4: Red Flags Self-Check
- V5: Rationalization Blocker
- V6: Agent Trust-But-Verify
- V7: Learning Capture

## File Structure

```
skills/
├── vibe/                          # Main VCO router (entry point)
│   ├── SKILL.md                   # Core routing logic, matrix, execution flow
│   └── references/
│       ├── index.md               # Navigation index
│       ├── tool-registry.md       # All 6 plugins: capabilities, APIs, state
│       ├── routing-table.md       # Detailed routing rules
│       ├── conflict-rules.md      # 6 conflict avoidance rules
│       ├── fallback-chains.md     # Degradation paths per task type
│       ├── extending-vco.md       # Guide for adding new tools
│       └── protocols/
│           ├── analysis.md        # Pre-routing analysis protocol
│           ├── think.md           # Planning/design/research protocol
│           ├── code.md            # Implementation/debug protocol
│           ├── review.md          # Code review/security protocol
│           ├── quality-injection.md # Quality pattern injection (13 patterns)
│           ├── orchestrate.md     # Multi-agent coordination protocol
│           └── memory.md          # Memory and learning protocol
├── vibe-build/                    # Shortcut: /vibe:build
│   └── SKILL.md
├── vibe-plan/                     # Shortcut: /vibe:plan
│   └── SKILL.md
├── vibe-review/                   # Shortcut: /vibe:review
│   └── SKILL.md
└── vibe-flow/                     # Shortcut: /vibe:flow
    └── SKILL.md
```

## Conflict Avoidance Rules

VCO prevents the most common multi-plugin conflicts:

| Rule | What It Prevents |
|------|-----------------|
| Rule 1: Agent Mutual Exclusion | Running multiple agent systems on the same task |
| Rule 2: Memory Division | Writing to the wrong memory system |
| Rule 3: Hook Coexistence | Hooks interfering with each other |
| Rule 4: Command Priority | Conflicting instructions from different plugins |
| Rule 5: Brainstorming Deconfliction | Two brainstorming systems running simultaneously |
| Rule 6: Review Deconfliction | Multiple review systems on the same code |

## Extending VCO

To add a new plugin to VCO:

1. **Analyze** the tool (hooks, state, capabilities)
2. **Register** in `references/tool-registry.md`
3. **Identify conflicts** with existing tools
4. **Add conflict rules** to `references/conflict-rules.md`
5. **Update routing** in `references/routing-table.md`
6. **Update protocols** in `references/protocols/`
7. **Update SKILL.md** tool selection matrix

See `references/extending-vco.md` for the full guide.

## Limitations

- **Behavioral enforcement only**: VCO uses instructions, not technical enforcement. Claude may occasionally deviate.
- **Hook execution order**: VCO cannot control the order hooks from different plugins execute.
- **Plugin availability**: VCO degrades gracefully but works best with all 6 plugins installed.
- **ruflo MCP dependency**: XL-grade features require the ruflo MCP server to be running.
- **Context window**: Complex L/XL tasks may consume significant context. VCO includes compaction strategies but cannot prevent context exhaustion.

## License

MIT

## Credits

VCO integrates and orchestrates the following open-source projects:
- [Superpowers](https://github.com/anthropics/claude-code-plugins) by obra
- [SuperClaude](https://github.com/bsmi021/superclaude) by bsmi021
- [Ralph-loop](https://github.com/frankbria/ralph-claude-code) by frankbria
- [Claude-code-settings](https://github.com/feiskyer/claude-code-settings) by feiskyer
- [Everything-claude-code](https://github.com/punkpeye/everything-claude-code) by punkpeye
- [Claude-flow](https://github.com/ruvnet/claude-flow) by ruvnet
