# vibe-analysis Protocol

Pre-routing structured analysis protocol. Activated BEFORE task classification
to ensure complex problems are properly understood before tool selection.

## When to Activate

- Task description is ambiguous or multi-faceted
- Task could reasonably be classified as multiple types
- User explicitly asks to "analyze", "think through", or "evaluate"
- Grade is estimated at M or above

Skip this protocol for S-grade tasks with clear, unambiguous requirements.

## Tool Reuse Map

This protocol creates NO new capabilities. It routes to existing tools:

| Complexity | Existing Tool | Source Plugin | What It Does |
|------------|--------------|---------------|--------------|
| M grade | `claude-code-settings:think-harder` | Claude-code-settings | 4-phase analysis: understand → analyze → synthesize → conclude |
| L grade | `claude-code-settings:think-ultra` | Claude-code-settings | 7-phase ultra-comprehensive analysis with multi-perspective critique |
| XL grade | `superpowers:brainstorming` | Superpowers | Socratic dialogue with HARD-GATE enforcement |
| Any grade | `sc:analyze` | SuperClaude | Code-focused quality/security/performance analysis |

## Analysis Flow

```
Task arrives (M+ grade or ambiguous)
  |
  +- Step 1: Problem Framing
  |   What exactly is being asked? What are the constraints?
  |   Tool: None (Claude native reasoning)
  |
  +- Step 2: Structured Analysis
  |   M grade -> invoke claude-code-settings:think-harder
  |   L grade -> invoke claude-code-settings:think-ultra
  |   XL grade -> invoke superpowers:brainstorming
  |
  +- Step 3: Classification Decision
  |   Based on analysis output, determine:
  |   - Final grade (may differ from initial estimate)
  |   - Task type (plan/code/review/orchestrate)
  |   - Is this a compound task? (see Compound Task Decomposition)
  |
  +- Step 4: Route to protocol
      Single task -> route to appropriate protocol
      Compound task -> decompose first (see below)
```

## Compound Task Decomposition

When analysis reveals a task spans multiple protocols (e.g., "design and implement"):

| Complexity | Existing Tool | Source Plugin |
|------------|--------------|---------------|
| M grade | `everything-claude-code:planner` agent | Everything-CC |
| L grade | `superpowers:writing-plans` | Superpowers |
| XL grade | ruflo `workflow_create` | Claude-flow |

Decomposition output: ordered list of phases, each with:
- Phase name and goal
- Protocol to use (think/code/review/orchestrate)
- Quality gate before proceeding to next phase
- Handoff context (what the next phase needs from this one)

### Example: "Design and implement user auth"

```
Phase 1: Requirements (vibe-think)
  Tool: superpowers:brainstorming
  Gate: Requirements document approved by user

Phase 2: Architecture (vibe-think)
  Tool: sc:design
  Gate: Architecture diagram approved

Phase 3: Implementation (vibe-code)
  Tool: superpowers:subagent-driven-development
  Gate: All tests pass, code reviewed

Phase 4: Security Review (vibe-review)
  Tool: everything-claude-code:security-reviewer
  Gate: No CRITICAL findings
```

## Conflict Avoidance

- think-harder and think-ultra are analysis tools, NOT brainstorming tools
- Use think-harder/think-ultra for problem analysis, brainstorming for requirements discovery
- Do NOT invoke both think-ultra and brainstorming on the same problem
- Analysis protocol runs BEFORE routing, not in parallel with execution
