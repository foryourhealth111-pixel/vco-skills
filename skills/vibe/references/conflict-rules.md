# VCO Conflict Avoidance Rules

Full specification for preventing conflicts between the 6 integrated tools.

## Principle

VCO uses behavioral instructions (not code) to prevent conflicts. All existing
hooks remain active. Conflicts are avoided by giving Claude clear rules about
which tools to use in which situations.

## Rule 1: Agent System Mutual Exclusion

NEVER use multiple agent systems for the same task.

| Grade | Agent System | Reason |
|-------|-------------|--------|
| S | None (direct action) | No overhead needed |
| M | Everything-CC agents | Lightweight, focused |
| L | Superpowers subagent-driven-dev | Two-stage review (spec + quality) |
| XL | Claude-flow/ruflo | Swarm/hive-mind coordination |

Exception: Specialized diagnostic agents may cross grade boundaries for their
specific purpose. These are NOT general coding/review agents:
- Everything-CC build-error-resolver: May be used at L grade for build failures
- Everything-CC security-reviewer: May be used at any grade for security audits

Violation example (DO NOT DO):
- Spawning ruflo agents AND using Superpowers subagent-driven-dev simultaneously
- Using Everything-CC code-reviewer AND ruflo agent cluster review on same code
- Using Everything-CC tdd-guide for L grade tasks (use Superpowers subagent system)

## Rule 2: Memory System Division

Each memory system has a specific role. Do not cross boundaries.

| Memory System | Scope | Use For |
|--------------|-------|---------|
| episodic-memory | Cross-session, long-term | Searching past conversations, finding historical decisions |
| ruflo memory_store | Current project, session-level | Storing current task state, intermediate results |
| Everything-CC instincts | Behavioral patterns | Learning coding preferences, auto-applying patterns |
| Serena MCP write_memory | Project knowledge | Storing project-specific architectural decisions |

## Rule 3: Hook Coexistence Strategy

All hooks from all plugins run. VCO does not disable any hooks.
Instead, VCO controls which MCP tools are actively invoked.

| Plugin | Hook Types | VCO Strategy |
|--------|-----------|--------------|
| Superpowers | SessionStart | Always runs. VCO respects skill-checking mandate. |
| Everything-CC | PreToolUse, PostToolUse, SessionStart, Stop | Always runs. VCO leverages its code quality guards. |
| Claude-flow | PreToolUse, PostToolUse, PreCompact, Stop | Hooks run passively. VCO only actively calls ruflo MCP tools for XL tasks. |
| Ralph-loop | Stop | Only activates when user explicitly starts /ralph-loop. VCO never auto-starts it. |

## Rule 4: Command Priority

When VCO routes to a specific protocol, follow VCO instructions
rather than the tool default behavior.

Priority order:
1. VCO protocol instructions (highest)
2. SuperClaude sc:* commands (if explicitly invoked by user)
3. Individual plugin default behaviors (lowest)

Exception: If user explicitly invokes a specific tool command
(e.g., /sc:design, /ralph-loop), bypass VCO routing and use that tool directly.

## Rule 5: Brainstorming Deconfliction

Both Superpowers and SuperClaude have brainstorming capabilities.

VCO resolution:
- For requirements discovery: Use Superpowers brainstorming (has HARD-GATE enforcement)
- For architecture design: Use SuperClaude sc:design (has persona system)
- For implementation planning: Use Superpowers writing-plans (has plan document generation)

Never invoke both brainstorming systems simultaneously.

## Rule 6: Review System Deconfliction

Multiple tools provide code review capabilities.

VCO resolution:
- Quick review (S/M grade): Everything-CC code-reviewer (lightweight, auto-triggered)
- Thorough review (L grade): Superpowers two-stage review (spec compliance + code quality)
- Cluster review (XL grade): ruflo agent cluster (parallel multi-perspective review)
- Security review: Everything-CC security-reviewer (always, regardless of grade)

## Adding New Rules

When a new conflict is discovered:
1. Document the conflict scenario
2. Define the resolution strategy
3. Add to the appropriate rule section
4. Update the SKILL.md Quick Reference if the rule is frequently needed
