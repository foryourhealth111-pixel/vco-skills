# VCO Routing Table

Detailed task classification criteria and routing decision rules.

## Classification Criteria

### Grade S (Simple)
- Single file modification
- Clear, unambiguous requirement
- No architectural impact
- Examples: typo fix, add a log line, rename variable, answer a question
- Execution: Full auto, no confirmation needed

### Grade M (Medium)
- 2-5 files affected
- Requires understanding existing code context
- May need minor design decisions
- Examples: add a new API endpoint, fix a multi-file bug, add form validation
- Execution: Auto with checkpoints (confirm before commit)

### Grade L (Large)
- 5+ files affected or architectural change
- Requires design phase before implementation
- Significant impact on codebase structure
- Examples: new authentication system, database migration, major refactor
- Execution: Staged confirmation (design -> approve -> implement -> review)

### Grade XL (Extra-Large)
- Cross-module or cross-project scope
- Requires multiple agents working in parallel
- Long-running task (multiple iterations)
- Examples: full-stack feature, system-wide refactoring, migration project
- Execution: Orchestration mode (workflow definition -> agent cluster -> coordination)

## Type Classification

### Planning/Design
Signals: "design", "plan", "architect", "how should", "what approach", "evaluate options"
Protocol: vibe-think

### Coding/Implementation
Signals: "implement", "add feature", "create", "build", "write code", "develop"
Protocol: vibe-code

### Debugging/Fixing
Signals: "fix", "bug", "error", "not working", "broken", "debug", "troubleshoot"
Protocol: vibe-code (debug mode)

### Review/Quality
Signals: "review", "check", "audit", "security", "test", "quality"
Protocol: vibe-review (see protocols/review.md)

### Research/Analysis
Signals: "research", "investigate", "analyze", "compare", "evaluate", "explore"
Protocol: vibe-think (research mode)

### Complex Orchestration
Signals: "refactor entire", "migrate all", "rewrite", "multi-agent", "parallel"
Protocol: vibe-orchestrate

## Routing Priority

When multiple types match:
1. If user explicitly specified a /vibe:* command, use that
2. If task involves design decisions, start with vibe-think
3. If task is purely code changes, use vibe-code
4. If task requires multiple agents, use vibe-orchestrate
5. Default to vibe-code for ambiguous cases

## Grade Escalation

A task may escalate during execution:
- S -> M: When you discover the fix requires multiple files
- M -> L: When you realize architectural decisions are needed
- L -> XL: When the scope exceeds what a single agent can handle

On escalation:
1. Pause current work
2. Inform user of the escalation and reason
3. Switch to the appropriate protocol for the new grade
4. Continue from where you left off
