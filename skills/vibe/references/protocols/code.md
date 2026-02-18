# vibe-code Protocol

Protocol for coding, implementation, debugging, and testing tasks.

## Scope
Activated when the task requires writing or modifying code:
- Feature implementation
- Bug fixing and debugging
- Code refactoring
- Test writing

## Tool Orchestration by Grade

### S Grade (Simple)
1. Directly edit the code using Claude Code native tools
2. No agent system needed
3. Everything-CC hooks auto-run (format, type-check)

### M Grade (Medium)
1. Pre-implementation: Invoke Everything-CC tdd-guide agent
   - Write tests first (RED)
   - Implement to pass (GREEN)
   - Refactor (IMPROVE)
2. Implementation: Use Claude Code native tools
3. Post-implementation: Everything-CC code-reviewer auto-triggers
4. If security-relevant: Invoke Everything-CC security-reviewer

### L Grade (Large)
1. Ensure design exists (from vibe-think protocol)
2. Invoke Superpowers subagent-driven-development
   - Fresh subagent per task
   - Two-stage review: spec compliance + code quality
   - Sequential execution to avoid conflicts
3. Use TodoWrite to track progress across tasks
4. Final review with Superpowers verification-before-completion

### XL Grade
Defer to vibe-orchestrate protocol.

## Debug Mode
When the task is debugging:
1. S grade bug: Direct fix
2. M grade bug: Invoke Superpowers systematic-debugging (4-phase root cause methodology)
3. L grade bug: Invoke Superpowers systematic-debugging + dispatching-parallel-agents (multi-component investigation)
4. Build-specific errors at any grade: Everything-CC build-error-resolver* is available as a specialized tool

*build-error-resolver is a specialized diagnostic agent exempt from agent mutual exclusion Rule 1

## Browser Testing
When UI testing is needed:
- Primary: Claude-code-settings Chrome MCP (chrome-devtools-mcp)
- Alternative: Playwright MCP (if available)

## Conflict Avoidance
- Do NOT use ruflo agent_spawn for S/M/L coding tasks
- Do NOT use SuperClaude sc:implement (use VCO flow)
- Everything-CC hooks always run - do not disable
- For L grade, use Superpowers subagent system, NOT Everything-CC agents

## Quality Gates
Before marking code task complete:
1. All tests pass
2. Code review completed
3. No security vulnerabilities (for user-facing code)
4. No console.log left in production code
