# vibe-orchestrate Protocol

Protocol for complex multi-agent tasks requiring coordination.

## Scope
Activated for XL grade tasks that require:
- Multiple agents working in parallel
- Workflow-based execution with phases
- Swarm or hive-mind coordination
- Long-running iterative tasks

## Tool Orchestration

### Option A: Ruflo Hive-Mind (Preferred for XL)
1. Define workflow: ruflo workflow_create (step types: task/condition/parallel/loop/wait)
2. Spawn workers: ruflo hive-mind_spawn (types: Researcher/Coder/Analyst/Tester/Architect/Reviewer)
3. Coordinate: ruflo coordination_orchestrate + claims_claim for task assignment
4. Monitor: ruflo hive-mind_status + claims_board + progress_report
5. Complete: ruflo hive-mind_shutdown, store results in memory_store

### Option B: Superpowers Parallel Agents (For L+ without swarm)
When ruflo is unavailable or task does not need full swarm:
1. Use Superpowers dispatching-parallel-agents
2. Spawn independent Task agents for each subtask
3. Controller reviews and integrates results

### Option C: Ralph-loop (For Iterative Tasks)
When the task requires repeated iteration on the same prompt:
1. User explicitly invokes /ralph-loop
2. Define completion promise (exit condition)
3. Set max iterations (safety limit)
4. Loop runs until completion or max iterations

IMPORTANT: Ralph-loop is MUTUALLY EXCLUSIVE with ruflo orchestration.

## Staged Confirmation
For XL tasks, always confirm with user at these points:
1. After workflow definition (before spawning agents)
2. After each major phase completion
3. Before final integration of results
4. Before committing changes

## Conflict Avoidance
- Do NOT use Everything-CC agents for XL tasks
- Do NOT use Superpowers subagent-driven-dev for XL tasks
- Ralph-loop and ruflo orchestration are mutually exclusive
- Only one hive-mind can be active per project at a time
