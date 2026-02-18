# VCO Tool Registry

Complete reference of all 6 integrated tools, their capabilities, APIs, and state paths.

## Tool Overview

| # | Tool | Type | Hook Types | State Location |
|---|------|------|------------|----------------|
| 1 | Superpowers | Plugin (hooks + skills) | SessionStart | Stateless (conversation context) |
| 2 | SuperClaude | Commands (markdown) | None | Serena MCP memory |
| 3 | Ralph-loop | Plugin (hooks + skills) | Stop | .claude/ralph-loop.local.md |
| 4 | Claude-code-settings | Plugin (skills + agents) | None | .specify/, .kiro/, .autonomous/ |
| 5 | Everything-claude-code | Plugin (hooks + skills + agents) | SessionStart, PreToolUse, PostToolUse, Stop | ~/.claude/sessions/, ~/.claude/homunculus/ |
| 6 | Claude-flow/ruflo | MCP Server | PreToolUse, PostToolUse, PreCompact, Stop | .claude-flow/ |

---

## 1. Superpowers (obra/superpowers)

**Version**: 4.3.0
**Location**: ~/.claude/plugins/cache/superpowers-marketplace/superpowers/4.3.0/

### Key Skills
| Skill | Purpose | Invocation |
|-------|---------|------------|
| brainstorming | Design-first requirements discovery | `superpowers:brainstorming` |
| writing-plans | Generate implementation plans | `superpowers:writing-plans` |
| subagent-driven-development | Execute plans with fresh subagent per task | `superpowers:subagent-driven-development` |
| dispatching-parallel-agents | Run independent tasks concurrently | `superpowers:dispatching-parallel-agents` |
| systematic-debugging | Structured debugging workflow | `superpowers:systematic-debugging` |
| verification-before-completion | Final verification checklist | `superpowers:verification-before-completion` |

### Characteristics
- Soft-gate enforcement via persuasive language (not technical blocks)
- HARD-GATE on brainstorming: no implementation before design approval
- Stateless: no global state, all context in conversation
- Skill shadowing: personal skills override superpowers skills

### Sub-plugin: episodic-memory
- MCP server with `search` and `read` tools
- Backend: SQLite + sqlite-vec (384-dim vectors)
- Storage: ~/.claude/episodic-memory/
- Tool names: `episodic-memory:search`, `episodic-memory:read`

---

## 2. SuperClaude Framework

**Location**: ~/.claude/commands/sc/

### Key Commands
| Command | Purpose | Category |
|---------|---------|----------|
| sc:brainstorm | Requirements discovery | Planning |
| sc:design | Architecture design | Planning |
| sc:implement | Feature implementation | Coding |
| sc:spawn | Task orchestration | Orchestration |
| sc:research | Deep web research | Research |
| sc:workflow | Implementation workflow | Planning |
| sc:test | Test execution | Quality |
| sc:analyze | Code analysis | Quality |
| sc:pm | Project manager agent | Management |

### Characteristics
- Pure command files (markdown), NOT a plugin
- No hooks registered (despite documentation claims)
- sc:pm claims "always active" but has no hook implementation
- Relies on Serena MCP for state persistence
- Uses cognitive personas (architect, frontend, backend, security, etc.)

---

## 3. Ralph-loop (frankbria/ralph-claude-code)

**Location**: ~/.claude/plugins/cache/claude-plugins-official/ralph-loop/

### Skills
| Skill | Purpose |
|-------|---------|
| ralph-loop | Start continuous iteration loop |
| cancel-ralph | Cancel active loop |
| help | Explain plugin usage |

### Characteristics
- Only registers Stop hook
- Blocks ALL session exits when active
- State file: .claude/ralph-loop.local.md (per-project)
- Intelligent exit detection: max iterations, completion promise
- No coordination with other plugins

---

## 4. Claude-code-settings (feiskyer/claude-code-settings)

**Version**: 2.1.4
**Location**: ~/.claude/plugins/cache/claude-code-settings/claude-code-settings/2.1.4/

### Key Skills
| Skill | Purpose |
|-------|---------|
| deep-research | Multi-agent parallel research workflow |
| spec-kit-skill | 7-phase constitution-based spec-driven development |
| kiro-skill | Interactive feature development (EARS format) |
| autonomous-skill | Long-running multi-session task automation |
| codex-skill | OpenAI Codex/GPT integration |

### Key Commands
| Command | Purpose |
|---------|---------|
| think-harder | 4-phase structured analysis |
| think-ultra | 7-phase ultra-comprehensive analysis |
| eureka | Technical breakthrough documentation |

### Agents
| Agent | Purpose |
|-------|---------|
| pr-reviewer | GitHub PR code review |
| ui-engineer | Frontend/UI development |
| github-issue-fixer | Issue resolution workflow |

### MCP Server
- Chrome DevTools MCP (chrome-devtools-mcp)

### Characteristics
- No hooks registered
- Provides LiteLLM proxy configuration (localhost:4000)
- Model mapping: Haiku -> gpt-5-mini
- Additive only, no behavior modification

---

## 5. Everything-claude-code

**Version**: 1.4.1
**Location**: ~/.claude/plugins/cache/everything-claude-code/everything-claude-code/1.4.1/

### Key Agents
| Agent | Model | Purpose |
|-------|-------|---------|
| planner | Opus | Feature planning |
| architect | Opus | System design |
| code-reviewer | Sonnet | Quality/security review |
| tdd-guide | Sonnet | Test-driven development |
| security-reviewer | Sonnet | Vulnerability detection |
| build-error-resolver | Sonnet | Build fix specialist |

### Key Skills
| Skill | Purpose |
|-------|---------|
| tdd-workflow | TDD enforcement (80%+ coverage) |
| verification-loop | Comprehensive verification |
| continuous-learning | Pattern extraction from sessions |
| continuous-learning-v2 | Instinct-based learning system |

### Instinct System (v2)
- Observations: ~/.claude/homunculus/observations.jsonl
- Instincts: ~/.claude/homunculus/instincts/personal/
- Evolved: ~/.claude/homunculus/evolved/
- Confidence scoring: 0.3 (tentative) to 0.9 (near-certain)
- Auto-approve threshold: 0.7

### Hooks
- PreToolUse: dev server blocker, tmux reminder, git push reminder, doc blocker, compaction suggester
- PostToolUse: PR logger, build completion, auto-format, TypeScript check, console.log warning
- SessionStart: context loader
- Stop: console.log checker

---

## 6. Claude-flow/ruflo (ruvnet/claude-flow)

**Version**: 3.1.0-alpha.41
**MCP Server**: ruflo (via claude-flow.cmd mcp start)
**Location**: ~/.npm-global/node_modules/claude-flow/

### MCP Tool Categories (100+ tools)
| Category | Key Tools | Purpose |
|----------|-----------|---------|
| agent | agent_spawn, agent_list, agent_pool | Agent lifecycle management |
| swarm | swarm_init, swarm_status | Basic coordination |
| hive-mind | hive-mind_spawn, hive-mind_consensus | Advanced collective intelligence |
| memory | memory_store, memory_search | HNSW vector memory (150x-12500x faster) |
| workflow | workflow_create, workflow_execute | Workflow engine (5 step types) |
| task | task_create, task_list | Task queue management |
| claims | claims_claim, claims_board | Collaborative issue claims |
| embeddings | embeddings_generate, embeddings_search | ONNX + hyperbolic embeddings |
| neural | neural_train, neural_patterns | Neural model operations |
| browser | browser_open, browser_click | Browser automation |
| hooks | hooks_route, hooks_metrics | Semantic routing + learning |
| session | session_save, session_restore | Session management |
| coordination | coordination_orchestrate | Multi-agent coordination |

### State Directory
```
.claude-flow/
  agents/store.json
  memory/ (sql.js + HNSW)
  hive-mind/state.json
  workflows/store.json
  tasks/store.json
  claims/claims.json
  sessions/
  neural/models.json
  performance/metrics.json
```

### Characteristics
- 60+ specialized agent types with intelligent model routing
- 3 consensus algorithms (Majority, Weighted, Byzantine)
- HNSW vector search (150x-12,500x faster than JSON)
- RuVector neural components (SONA, EWC++, Flash Attention)
- File-based state in .claude-flow/ (per-project)
- No API keys required (local embeddings)
