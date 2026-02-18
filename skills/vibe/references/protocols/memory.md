# vibe-memory Protocol

Protocol for cross-session knowledge persistence and retrieval.

## Scope
Activated automatically as part of other protocols:
- Session start: retrieve relevant history
- Task completion: persist key decisions
- Session end: extract learning patterns

## Memory Layers

### Layer 1: Conversation Context (Immediate)
- Scope: Current conversation
- Provider: Claude Code native
- No action needed

### Layer 2: Session State (Short-term)
- Scope: Current session, current project
- Provider: ruflo memory_store / memory_search
- Use for: Task state, intermediate results, current decisions

### Layer 3: Project Knowledge (Medium-term)
- Scope: Current project, cross-session
- Provider: Serena MCP write_memory / read_memory
- Use for: Architecture decisions, project conventions

### Layer 4: Conversation History (Long-term)
- Scope: All projects, all sessions
- Provider: episodic-memory search / read
- Use for: Finding past solutions, recalling decisions

### Layer 5: Behavioral Patterns (Learning)
- Scope: User preferences, coding style
- Provider: Everything-CC instinct system
- Use for: Auto-applying learned patterns

## Automatic Triggers

### On Session Start (M+ grade tasks)
1. Search episodic-memory for relevant past conversations
2. Load Serena project memories if available
3. Check Everything-CC instincts for applicable patterns

### On Task Completion (L+ grade tasks)
1. Store key decisions in ruflo memory with "decision" tag
2. Update Serena project memory if architectural decisions were made
3. Run feedback loop (see below)

### On Session End
1. Everything-CC session evaluator runs (if enabled)
2. Instinct system updates confidence scores
3. If significant session: invoke `claude-code-settings:reflection` for session analysis

## Feedback & Learning Loop

Post-execution learning that uses existing tools to improve future routing decisions.
This protocol creates NO new capabilities — it wires existing learning systems into VCO.

### Step 1: Routing Decision Evaluation (M+ grade)
After task execution, briefly assess:
- Was the grade classification correct? (S/M/L/XL)
- Was the tool selection optimal? (right tool for the job?)
- Did any fallback trigger? (indicates routing could improve)

### Step 2: Pattern Extraction
Tool: `everything-claude-code:continuous-learning-v2` (instinct system)
- Observations are auto-logged to ~/.claude/homunculus/observations.jsonl
- Patterns with confidence > 0.7 become auto-applied instincts
- Example instinct: "When user says 'refactor X', classify as L grade not M"

### Step 3: Session Reflection (L+ grade, end of significant sessions)
Tool: `claude-code-settings:reflection` or `claude-code-settings:reflection-harder`
- Analyzes session patterns and extracts improvements
- Stores insights for future CLAUDE.md optimization

### Step 4: Cross-Session Recall (next session)
Tool: `episodic-memory:search-conversations`
- On session start, search for relevant past routing decisions
- Apply learned patterns to improve classification accuracy

### Feedback Tool Map

| Feedback Type | Existing Tool | Source Plugin |
|--------------|--------------|---------------|
| Pattern extraction | `continuous-learning-v2` | Everything-CC |
| Session analysis | `reflection` / `reflection-harder` | Claude-code-settings |
| Cross-session recall | `episodic-memory:search` | Superpowers/episodic-memory |
| Decision persistence | ruflo `memory_store` | Claude-flow |
| Instinct status check | `everything-claude-code:instinct-status` | Everything-CC |

## Conflict Avoidance
- episodic-memory and ruflo memory use different storage paths
- Serena memory and ruflo memory serve different purposes
- Everything-CC instincts are behavioral, not data storage
- Never store the same information in multiple memory systems
