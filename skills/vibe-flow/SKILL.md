---
name: vibe-flow
description: "VCO orchestration shortcut: multi-agent coordination, swarm tasks, hive-mind, and iterative workflows. Use when user types /vibe:flow or needs complex multi-agent task execution."
---

# vibe-flow — Complex Orchestration Entry

Shortcut into VCO's vibe-orchestrate protocol for XL-grade tasks requiring multi-agent coordination.

## When to Use This Skill

Trigger when any of these applies:
- User types /vibe:flow followed by a task description
- Task requires multiple agents working in parallel
- Task spans multiple modules or projects
- User explicitly asks for swarm, hive-mind, or multi-agent execution
- Task requires iterative refinement (ralph-loop)

## Not For / Boundaries

This skill will NOT:
- Handle simple single-file tasks (use /vibe or /vibe:build)
- Do planning without execution (use /vibe:plan)
- Replace explicit tool invocations (/ralph-loop, ruflo MCP tools)

Required context:
- If task scope is unclear, ask: "What are the major components to coordinate?"
- If agent count is unclear, ask: "How many parallel workstreams do you envision?"

## Quick Reference

### Orchestration Options

**Option A: Ruflo Hive-Mind (preferred for XL)**
1. `workflow_create` - Define execution phases
2. `hive-mind_spawn` - Create worker cluster
3. `coordination_orchestrate` - Coordinate execution
4. `claims_claim` - Assign tasks to agents
5. `hive-mind_status` - Monitor progress
6. `hive-mind_shutdown` - Complete and cleanup

**Option B: Superpowers Parallel Agents (L+ without swarm)**
1. `superpowers:dispatching-parallel-agents`
2. Spawn independent Task agents per subtask
3. Controller reviews and integrates

**Option C: Ralph-loop (iterative tasks)**
1. User invokes /ralph-loop explicitly
2. Set completion promise and max iterations
3. Loop until done

### Conflict Rules
- Ralph-loop and ruflo orchestration are MUTUALLY EXCLUSIVE
- Only one hive-mind per project at a time
- Do NOT use Everything-CC agents for XL tasks
- Always confirm with user at phase boundaries

## Examples

### Example 1: Full-Stack Feature
- Input: "/vibe:flow Build the complete user dashboard feature"
- Steps:
  1. Create ruflo workflow: API -> Frontend -> Tests -> Integration
  2. Spawn hive-mind: architect + 2 coders + tester
  3. Coordinate parallel execution
  4. Staged confirmations at each phase
  5. Final integration and review
- Acceptance: Feature complete, all tests pass, reviewed

### Example 2: System-Wide Refactoring
- Input: "/vibe:flow Migrate from REST to GraphQL across all services"
- Steps:
  1. Create ruflo workflow with migration phases
  2. Spawn workers per service
  3. Use claims system for task assignment
  4. Monitor with progress reports
  5. Staged rollout with confirmations
- Acceptance: All services migrated, backward compatibility maintained

### Example 3: Iterative Improvement
- Input: "/vibe:flow Iteratively optimize the search algorithm"
- Steps:
  1. User invokes /ralph-loop with optimization prompt
  2. Set completion promise: "search latency < 50ms"
  3. Each iteration: measure -> analyze -> optimize -> test
  4. Loop until target met or max iterations
- Acceptance: Performance target achieved

## References

- See vibe/references/protocols/orchestrate.md for full protocol
- See vibe/references/tool-registry.md for ruflo MCP tool details
- See vibe/references/conflict-rules.md for orchestration conflicts

## Maintenance

- Sources: VCO system design (2026-02-18)
- Last updated: 2026-02-18
- Known limits: ruflo MCP server must be running for hive-mind features
