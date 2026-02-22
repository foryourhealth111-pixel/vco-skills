# VCO Tool Registry

Complete reference of all 6 integrated tools, their capabilities, APIs, state paths, and verification status.

## Tool Overview

| # | Tool | Type | Hook Types | State Location | Verified |
|---|------|------|------------|----------------|----------|
| 1 | Superpowers | Plugin (hooks + skills) | SessionStart | Stateless (conversation context) | ✅ |
| 2 | SuperClaude | Commands (markdown) | None | Serena MCP memory | ⚠️ Partial |
| 3 | Ralph-loop | Plugin (hooks + skills) | Stop | .claude/ralph-loop.local.md | ✅ |
| 4 | Claude-code-settings | Plugin (skills + agents) | None | .specify/, .kiro/, .autonomous/ | ✅ |
| 5 | Everything-claude-code | Plugin (hooks + skills + agents) | SessionStart, PreToolUse, PostToolUse, Stop | ~/.claude/sessions/, ~/.claude/homunculus/ | ✅ |
| 6 | Claude-flow/ruflo + TeamCreate | MCP Server + Native | PreToolUse, PostToolUse, PreCompact, Stop | .claude-flow/ + ~/.claude/teams/ | ⚠️ MCP依赖 |

## Verification Status Legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Capabilities verified, works as documented |
| ⚠️ Partial | Some capabilities verified, some claimed but unverified |
| ⚠️ MCP依赖 | Requires MCP server running; capabilities verified when available |
| ❌ | Claimed capability does not work as documented |

---

## 1. Superpowers (obra/superpowers)

**Version**: 4.3.0
**Location**: ~/.claude/plugins/cache/superpowers-marketplace/superpowers/4.3.0/

### Key Skills
| Skill | Purpose | Invocation | Verified |
|-------|---------|------------|----------|
| brainstorming | Design-first requirements discovery | `superpowers:brainstorming` | ✅ |
| writing-plans | Generate implementation plans | `superpowers:writing-plans` | ✅ |
| subagent-driven-development | Execute plans with fresh subagent per task | `superpowers:subagent-driven-development` | ✅ |
| dispatching-parallel-agents | Run independent tasks concurrently | `superpowers:dispatching-parallel-agents` | ✅ |
| systematic-debugging | Structured debugging workflow | `superpowers:systematic-debugging` | ✅ |
| verification-before-completion | Final verification checklist | `superpowers:verification-before-completion` | ✅ |

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
| Command | Purpose | Category | Verified |
|---------|---------|----------|----------|
| sc:brainstorm | Requirements discovery | Planning | ✅ |
| sc:design | Architecture design | Planning | ✅ |
| sc:implement | Feature implementation | Coding | ✅ |
| sc:spawn | Task orchestration | Orchestration | ✅ |
| sc:research | Deep web research | Research | ✅ |
| sc:workflow | Implementation workflow | Planning | ✅ |
| sc:test | Test execution | Quality | ✅ |
| sc:analyze | Code analysis | Quality | ✅ |
| sc:pm | Project manager agent | Management | ⚠️ Claims "always active" but has no hook implementation |

### Characteristics
- Pure command files (markdown), NOT a plugin
- No hooks registered (despite documentation claims) ⚠️
- sc:pm claims "always active" but has no hook implementation ⚠️
- Relies on Serena MCP for state persistence
- Uses cognitive personas (architect, frontend, backend, security, etc.)

---

## 3. Ralph-loop (frankbria/ralph-claude-code)

**Location**: ~/.claude/plugins/cache/claude-plugins-official/ralph-loop/

### Skills
| Skill | Purpose | Verified |
|-------|---------|----------|
| ralph-loop | Start continuous iteration loop | ✅ |
| cancel-ralph | Cancel active loop | ✅ |
| help | Explain plugin usage | ✅ |

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
| Skill | Purpose | Verified |
|-------|---------|----------|
| deep-research | Multi-agent parallel research workflow | ✅ |
| spec-kit-skill | 7-phase constitution-based spec-driven development | ✅ |
| kiro-skill | Interactive feature development (EARS format) | ✅ |
| autonomous-skill | Long-running multi-session task automation | ✅ |
| codex-skill | OpenAI Codex/GPT integration | ⚠️ Requires external API |

### Key Commands
| Command | Purpose | Verified |
|---------|---------|----------|
| think-harder | 4-phase structured analysis | ✅ |
| think-ultra | 7-phase ultra-comprehensive analysis | ✅ |
| eureka | Technical breakthrough documentation | ✅ |

### Agents
| Agent | Purpose | Verified |
|-------|---------|----------|
| pr-reviewer | GitHub PR code review | ✅ |
| ui-engineer | Frontend/UI development | ✅ |
| github-issue-fixer | Issue resolution workflow | ✅ |

### MCP Server
- Chrome DevTools MCP (chrome-devtools-mcp) ⚠️ Requires Chrome running

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
| Agent | Model | Purpose | Verified |
|-------|-------|---------|----------|
| planner | Opus | Feature planning | ✅ |
| architect | Opus | System design | ✅ |
| code-reviewer | Sonnet | Quality/security review | ✅ |
| tdd-guide | Sonnet | Test-driven development | ✅ |
| security-reviewer | Sonnet | Vulnerability detection | ✅ |
| build-error-resolver | Sonnet | Build fix specialist | ✅ |

### Key Skills
| Skill | Purpose | Verified |
|-------|---------|----------|
| tdd-workflow | TDD enforcement (80%+ coverage) | ✅ |
| verification-loop | Comprehensive verification | ✅ |
| continuous-learning | Pattern extraction from sessions | ✅ |
| continuous-learning-v2 | Instinct-based learning system | ✅ |

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

## 6. Claude-flow/ruflo + TeamCreate (ruvnet/claude-flow + native)

**Version**: 3.1.0-alpha.41
**MCP Server**: ruflo ⚠️ MCP 依赖
- 150+ 工具已注册为 deferred tools，需通过 ToolSearch 加载后使用
- 首次调用任何 ruflo 工具前，必须先 ToolSearch 加载对应工具
- MCP server 未运行时所有工具不可用，走 fallback chain
**Location**: ~/.npm-global/node_modules/claude-flow/

### MCP Tool Categories (100+ tools)
| Category | Key Tools | Purpose | Verified |
|----------|-----------|---------|----------|
| agent | agent_spawn, agent_list, agent_pool | Agent lifecycle management | ⚠️ MCP依赖 |
| swarm | swarm_init, swarm_status | Basic coordination | ⚠️ MCP依赖 |
| hive-mind | hive-mind_spawn, hive-mind_consensus | Advanced collective intelligence | ⚠️ MCP依赖 |
| memory | memory_store, memory_search | HNSW vector memory | ⚠️ MCP依赖 |
| workflow | workflow_create, workflow_execute | Workflow engine (5 step types) | ⚠️ MCP依赖 |
| task | task_create, task_list | Task queue management | ⚠️ MCP依赖 |
| session | session_save, session_restore | Session management | ⚠️ MCP依赖 |

### State Directory
```
.claude-flow/
  agents/store.json
  memory/ (sql.js + HNSW)
  hive-mind/state.json
  workflows/store.json
  tasks/store.json
  sessions/
```

### Characteristics
- 60+ agent type templates with model routing（基于 prompt 模板的角色分化）
- 3 aggregation modes (Majority voting, Weighted voting, Multi-perspective validation)
- HNSW vector search (150x-12,500x faster than JSON)
- File-based state in .claude-flow/ (per-project)
- No API keys required (local embeddings)

### TeamCreate Native Integration

TeamCreate is a built-in Claude Code tool (always available, no MCP dependency). ✅

| Tool | Purpose | Verified |
|------|---------|----------|
| TeamCreate | Create team + task list | ✅ Always available |
| Task (with team_name) | Spawn teammate agents | ✅ Always available |
| TaskCreate / TaskUpdate / TaskList | Task management + assignment | ✅ Always available |
| SendMessage | Inter-agent DM, broadcast, shutdown | ✅ Always available |
| TeamDelete | Clean up team resources | ✅ Always available |

TeamCreate manages agent lifecycle; ruflo provides workflow engine + vector memory.
When ruflo is unavailable, TeamCreate operates independently (degraded mode).

---

## 7. OpenAI Codex (Cross-Model Integration)

**Version**: 0.104.0+
**Location**: ~/.npm-global/node_modules/@openai/codex/
**Config**: ~/.codex/config.toml

### Integration Modes

| Mode | Method | Purpose | Verified |
|------|--------|---------|----------|
| MCP Server | `codex mcp-server` (stdio) | Deep integration — Codex tools appear as native MCP tools in Claude Code | ⚠️ Requires Codex API key |
| exec 委派 | `codex exec "task" --full-auto` | Non-interactive task delegation with structured output | ⚠️ Requires Codex API key |
| review 审查 | `codex review --uncommitted` | Cross-model code review (different model = different blind spots) | ⚠️ Requires Codex API key |

### MCP Server Registration

Add to Claude Code MCP config:
```json
{
  "codex": {
    "command": "codex",
    "args": ["mcp-server"]
  }
}
```

### exec Key Flags

| Flag | Purpose |
|------|---------|
| `--full-auto` | Autonomous execution (sandbox + auto-approve) |
| `--json` | JSONL event stream output |
| `-o FILE` | Write final message to file |
| `--output-schema FILE` | Structured output via JSON Schema |
| `-C DIR` | Working directory |
| `-m MODEL` | Override model |
| `-s MODE` | Sandbox: read-only, workspace-write, danger-full-access |

### review Key Flags

| Flag | Purpose |
|------|---------|
| `--uncommitted` | Review staged + unstaged + untracked changes |
| `--base BRANCH` | Review changes against base branch |
| `--commit SHA` | Review specific commit |

### Cross-Tool Compatibility

- `CLAUDE.md` ↔ `AGENTS.md` symlink: both tools read the same instructions
- Shared MCP servers: context7, playwright, github can be configured in both tools
- Shared workspace: both tools operate on the same filesystem and git repo

### Characteristics
- Different model family (GPT/o3) provides complementary perspective to Claude
- exec mode supports timeout and structured output for automation
- MCP server mode enables deepest integration (Codex tools as Claude Code tools)
- No hooks registered (external tool, invoked on demand)
- Requires separate API key (OpenAI or Azure OpenAI)
