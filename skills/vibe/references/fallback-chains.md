# VCO Fallback Chains

Degradation paths when primary tools are unavailable or fail.
All fallback targets are existing tools from the 6 integrated plugins.

## Principle

Every routing decision has a primary tool and 1-2 fallback tools.
Fallback triggers:
- MCP server not running (ruflo, Serena, episodic-memory)
- Agent timeout or error
- Tool produces no useful output
- Plugin not installed

## Fallback Chain Table

### Planning Tasks

| Grade | Primary | Fallback 1 | Fallback 2 |
|-------|---------|------------|------------|
| M | sc:design | everything-claude-code:planner agent | Direct Claude reasoning |
| L | superpowers:brainstorming + writing-plans | sc:brainstorm + sc:workflow | everything-claude-code:planner agent |
| XL | ruflo workflow_create | superpowers:writing-plans | sc:workflow |

### Coding Tasks

| Grade | Primary | Fallback 1 | Fallback 2 |
|-------|---------|------------|------------|
| M | everything-claude-code:tdd-guide | superpowers:test-driven-development | Direct TDD (manual RED-GREEN-REFACTOR) |
| L | superpowers:subagent-driven-dev | everything-claude-code:planner + tdd-guide | Direct implementation with TodoWrite tracking |
| XL | ruflo hive-mind_spawn | superpowers:dispatching-parallel-agents | Sequential L-grade execution |

### Review Tasks

| Grade | Primary | Fallback 1 | Fallback 2 |
|-------|---------|------------|------------|
| S/M | everything-claude-code:code-reviewer | superpowers:requesting-code-review | Direct review (manual checklist) |
| L | superpowers:requesting-code-review (two-stage) | everything-claude-code:code-reviewer + security-reviewer | Direct review |
| XL | ruflo agent cluster review | superpowers:dispatching-parallel-agents (reviewer roles) | Sequential L-grade review |

### Debug Tasks

| Grade | Primary | Fallback 1 | Fallback 2 |
|-------|---------|------------|------------|
| M | superpowers:systematic-debugging | everything-claude-code:build-error-resolver | Direct debugging |
| L | superpowers:systematic-debugging + dispatching-parallel-agents | superpowers:systematic-debugging (single) | Direct debugging with Grep/Read |

### Research Tasks

| Grade | Primary | Fallback 1 | Fallback 2 |
|-------|---------|------------|------------|
| M | sc:research | claude-code-settings:deep-research | WebSearch + WebFetch |
| L | claude-code-settings:deep-research | sc:research | WebSearch + WebFetch |
| XL | ruflo embeddings + memory | claude-code-settings:deep-research | sc:research |

### Analysis (Pre-routing)

| Grade | Primary | Fallback 1 | Fallback 2 |
|-------|---------|------------|------------|
| M | claude-code-settings:think-harder | sc:analyze | Direct reasoning |
| L | claude-code-settings:think-ultra | claude-code-settings:think-harder | Direct reasoning |
| XL | superpowers:brainstorming | claude-code-settings:think-ultra | Direct reasoning |

### Memory Systems

| System | Primary | Fallback |
|--------|---------|----------|
| Cross-session | episodic-memory:search | Serena MCP read_memory |
| Session state | ruflo memory_store | TodoWrite + conversation context |
| Pattern learning | everything-claude-code:continuous-learning-v2 | episodic-memory (manual pattern notes) |
| Project knowledge | Serena MCP write_memory | ruflo memory_store with "project" tag |

## Fallback Detection

How to detect that a fallback is needed:

1. **MCP not running**: Tool call returns connection error or timeout
2. **Agent failure**: Task agent returns error or empty result after reasonable time
3. **Quality failure**: Output doesn't address the task (requires judgment)
4. **Plugin missing**: Skill invocation returns "skill not found"

## Fallback Protocol

```
1. Attempt primary tool
2. If failure detected:
   a. Log the failure reason (for future learning via instinct system)
   b. Inform user: "Primary tool [X] unavailable, falling back to [Y]"
   c. Attempt Fallback 1
3. If Fallback 1 also fails:
   a. Attempt Fallback 2
4. If all fallbacks fail:
   a. Use direct Claude reasoning (no tool)
   b. Inform user of limitations
```

## Context Budget Awareness

For L+ grade tasks, proactively manage context window:

| Situation | Existing Tool | Source Plugin |
|-----------|--------------|---------------|
| Context getting large | `everything-claude-code:strategic-compact` | Everything-CC |
| Need to preserve state before compact | ruflo `session_save` | Claude-flow |
| Resume after compact | ruflo `session_restore` | Claude-flow |
| Store intermediate results | ruflo `memory_store` | Claude-flow |

### Context Budget Rules

1. Before starting L+ tasks, estimate context cost:
   - L grade: ~40-60% of context window
   - XL grade: ~70-90% of context window
2. At 60% context usage for L tasks: consider strategic-compact
3. At 50% context usage for XL tasks: save state to ruflo memory, compact
4. Always store key decisions in ruflo memory_store BEFORE compaction
5. After compaction, restore context from ruflo session_restore
