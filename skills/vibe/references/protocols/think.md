# vibe-think Protocol

Protocol for planning, design, research, and analytical tasks.

## Scope
Activated when the task requires thinking before doing:
- Requirements analysis and discovery
- Architecture and system design
- Research and investigation
- Option evaluation and comparison

## Tool Orchestration

### Phase 1: Requirements Discovery
Tool: Superpowers brainstorming
- Invoke via Skill tool: superpowers:brainstorming
- Follows Socratic dialogue pattern
- HARD-GATE: No implementation until design is approved
- Output: Clarified requirements, user stories, acceptance criteria

### Phase 2: Architecture Design (if needed)
Tool: SuperClaude sc:design
- Invoke via Skill tool: sc:design
- Uses cognitive personas (architect, security, frontend, backend)
- Output: Architecture diagrams, component design, data flow

### Phase 3: Plan Documentation
Tool: Superpowers writing-plans
- Invoke via Skill tool: superpowers:writing-plans
- Generates plan document at docs/plans/YYYY-MM-DD-<topic>.md
- Output: Actionable implementation plan with phases

### Phase 4: Deep Research (if needed)
Tool: Claude-code-settings deep-research
- Invoke via Skill tool: claude-code-settings:deep-research
- Multi-agent parallel research workflow
- Output: Research findings with sources

## Research Mode
When the task is purely research (no implementation):
1. Skip Phase 1 unless scope is unclear
2. Go directly to Phase 4 (deep-research)
3. Optionally use SuperClaude sc:research for web research
4. Store findings in ruflo memory for future reference

## Conflict Avoidance
- Do NOT write code during this protocol (respect HARD-GATE)
- Do NOT invoke both brainstorming systems simultaneously
- Use Superpowers brainstorming for requirements, SuperClaude sc:design for architecture

## Transition to Implementation
After design is approved:
1. If L grade: Switch to vibe-code with Superpowers subagent-driven-dev
2. If XL grade: Switch to vibe-orchestrate protocol
3. Always carry the plan document forward as context
