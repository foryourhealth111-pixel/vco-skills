# vibe-retrospective Protocol

Protocol for conducting structured retrospective meetings -- collaborative analysis
of recent projects, workflow optimization, error pattern detection, and future
improvement planning.

## Scope

Activated when the user wants to:
- Review and reflect on recent project work
- Identify workflow optimization opportunities
- Detect recurring error patterns and design preventive hooks
- Discover reusable patterns for future projects
- Decide whether to create new skills, agents, MCPs, or hooks
- Conduct a collaborative improvement discussion with AI

## 5-Phase Architecture

Phase 1: GATHER --> Phase 2: ANALYZE --> Phase 3: DISCUSS --> Phase 4: DECIDE --> Phase 5: ACT

Each phase uses existing tools from the 6 integrated plugins.
No new capabilities are created -- only composition of existing ones.

---

## Phase 1: GATHER (Data Collection)

Collect raw data from all available memory and observation systems.

### 1.1 Conversation History Retrieval

Tool: episodic-memory:search
- Search for recent conversations related to the target project/topic
- Mode: semantic (for topic-based) or text (for specific errors/files)
- Scope: last N sessions or specific date range
- Output: List of relevant past conversations with summaries

### 1.2 Session Activity Review

Tool: Read ~/.claude/sessions/ files
- Read recent session files (YYYY-MM-DD-<project>-session.tmp)
- Extract: tasks performed, files modified, tools used, message counts
- Output: Timeline of recent session activity

### 1.3 Instinct Status Check

Tool: everything-claude-code:instinct-status
- Show all learned instincts grouped by domain
- Check confidence scores and recent updates
- Identify low-confidence or stale instincts
- Fallback: If instinct system not active, skip this step

### 1.4 Project Memory Retrieval

Tool: Serena MCP list_memories + read_memory
- List all project-related memories
- Read key decisions, architecture notes, conventions
- Fallback: If Serena not available, skip this step

### 1.5 Error Log Collection

Tool: git log + episodic-memory search
- git log --oneline -20 (recent commits, especially fix/revert)
- Search episodic-memory for error, fix, bug, revert
- Read observations.jsonl if available
- Output: Recent error patterns and fix history

### Gather Summary

Present a structured data collection report to the user before proceeding.

---

## Phase 2: ANALYZE (Structured Analysis)

Run analysis on the gathered data.

### 2.1 Session Reflection

Tool: claude-code-settings:reflection-harder (or deep-reflector agent)
- Analyze recent sessions for problems solved, patterns established,
  user preferences discovered, knowledge gaps identified
- Output: Structured session analysis report

### 2.2 Problem Pattern Detection

Tool: hookify:conversation-analyzer agent
- Scan recent conversations for user frustration signals, repeated errors,
  tool misuse patterns
- Severity categorization (high/medium/low)
- Output: Problem patterns with severity and frequency

### 2.3 Workflow Frequency Analysis

Tool: Analyze session files + episodic-memory search
- Identify most frequently used tool combinations
- Repeated multi-step workflows (potential automation candidates)
- Tasks that always follow the same pattern
- Manual steps that could be automated
- Output: Workflow frequency report with automation candidates

### 2.4 Cross-Session Trend Analysis

Tool: claude-code-settings:think-ultra (7-phase analysis)
- Synthesize data from phases 2.1-2.3
- Are errors increasing or decreasing?
- Which domains have the most activity?
- What patterns are emerging across sessions?
- Where are the biggest time sinks?
- Output: Trend analysis with actionable insights

---

## Phase 3: DISCUSS (Interactive Discussion)

Interactive Socratic dialogue with the user to explore findings.

### Discussion Framework

Tool: superpowers:brainstorming methodology (adapted for retro)

#### 3.1 Workflow Review
- This workflow appeared N times. Is it worth automating?
- You spent significant time on X. Could a different approach help?
- Pattern Y from project A could apply to project B. Thoughts?

#### 3.2 Error Prevention
- Error X happened N times. Should we add a hook to catch it early?
- These errors share a common root cause. Address systemically?
- Would a pre-commit check prevent this class of errors?

#### 3.3 Tool Effectiveness
- Tool X was used for Y, but tool Z might be more effective. Try?
- The routing chose M-grade for this task, but it needed L-grade. Adjust?
- This fallback triggered often. Should we change the primary tool?

#### 3.4 Future Planning
- For the next similar project, what would you do differently?
- Should we create a reusable template/skill for this workflow?
- Are there any new tools or MCPs that could help?

### Interaction Style: Pedagogical Advisory (教学建议型)

AI adopts a proactive mentor role throughout the discussion:

**Proactive Engagement:**
- Actively identify improvement opportunities and present them to the user
- Use guiding questions: "你有没有注意到...", "我建议考虑...", "这里有个模式值得关注..."
- Don't wait for the user to ask — surface insights and propose directions
- For each finding, provide a concrete improvement path (not just the problem)

**Teaching Through Patterns:**
- Use analogies and real examples from the user's own history to explain patterns
- Connect current findings to past sessions: "上次在X项目中你也遇到了类似的情况..."
- Explain WHY a pattern matters, not just WHAT the pattern is
- Help the user build mental models for recognizing patterns independently

**Data-Grounded Suggestions:**
- Every suggestion must reference specific evidence from Phase 2
- Present data first, then interpretation, then recommendation
- Format: "数据显示[X]。这意味着[Y]。我建议[Z]，因为[理由]"
- When uncertain, say so: "这个趋势还不够明确，但值得关注"

**Respectful Autonomy:**
- User makes all final decisions — AI suggests, user decides
- When user disagrees with a suggestion, explore their reasoning rather than insisting
- Discussion can loop back to any topic at user's request
- Explicitly ask for confirmation before moving to Phase 4

---

## Phase 4: DECIDE (Decisions)

Consolidate discussion outcomes into actionable decisions.

### Decision Categories

| Category | Action Type | Tool Used to Implement |
|----------|------------|----------------------|
| Recurring workflow | Create new skill | superpowers:writing-skills |
| Recurring workflow | Create new command | claude-code-settings:command-creator |
| Error prevention | Create hook | hookify:hookify |
| Behavioral pattern | Create/update instinct | continuous-learning-v2 |
| Routing improvement | Update VCO config | Edit SKILL.md / routing-table.md |
| Knowledge capture | Persist memory | Serena write_memory / episodic-memory |
| Complex automation | Create agent | Manual design + writing-skills |
| External integration | Create MCP tool | Manual implementation |

### User Confirmation Gate

Present all decisions as a prioritized list. User approves, modifies, or rejects
each one before Phase 5 begins. Nothing is implemented without explicit approval.

---

## Phase 5: ACT (Execute Improvements)

Implement approved decisions using existing tools.

### 5.1 Create Hooks (Error Prevention)
Tool: hookify:hookify
1. Define trigger condition (PreToolUse/PostToolUse/Stop)
2. Define matcher pattern and action (block/warn/transform)
3. Create .local.md rule file and verify

### 5.2 Create Skills/Commands
Tool: superpowers:writing-skills or claude-code-settings:command-creator
1. Define skill name, description, trigger conditions
2. Write SKILL.md with proper frontmatter
3. Place in ~/.claude/skills/ or ~/.claude/commands/ and test

### 5.3 Create/Update Instincts
Tool: everything-claude-code:continuous-learning-v2
1. Create .md in ~/.claude/homunculus/instincts/personal/
2. Set confidence score (start at 0.5 for new)
3. Define trigger, action, domain, evidence

### 5.4 Update VCO Configuration
Tool: Direct file edits to routing-table.md, SKILL.md, fallback-chains.md, conflict-rules.md

### 5.5 Persist Knowledge
Tool: Serena write_memory + CLAUDE.md updates if globally applicable

### 5.6 Generate Retro Report
Store retrospective summary via Serena write_memory(retro/YYYY-MM-DD, report).
Report includes: scope, key findings, decisions made, improvements implemented, follow-ups.

---

## Tool Composition Map

| Phase | Primary Tool | Source Plugin | Fallback |
|-------|-------------|--------------|----------|
| 1.1 History | episodic-memory:search | Superpowers | Read session files |
| 1.2 Activity | Read ~/.claude/sessions/ | Everything-CC | git log |
| 1.3 Instincts | instinct-status | Everything-CC | Skip |
| 1.4 Memory | Serena list/read_memory | Serena MCP | Skip |
| 1.5 Errors | git log + episodic search | Git + Superpowers | Manual review |
| 2.1 Reflection | reflection-harder | Claude-code-settings | deep-reflector agent |
| 2.2 Problems | conversation-analyzer | Hookify | Manual scan |
| 2.3 Workflows | Session file analysis | Everything-CC | episodic search |
| 2.4 Trends | think-ultra | Claude-code-settings | think-harder |
| 3.x Discussion | brainstorming methodology | Superpowers | Direct dialogue |
| 4.x Decisions | AskUserQuestion | Claude Code native | Direct dialogue |
| 5.1 Hooks | hookify | Hookify | Manual creation |
| 5.2 Skills | writing-skills | Superpowers | Manual creation |
| 5.3 Instincts | continuous-learning-v2 | Everything-CC | Manual creation |
| 5.4 Config | Direct edit | VCO | Manual edit |
| 5.5 Knowledge | Serena write_memory | Serena MCP | episodic-memory |

---

## Grade Adaptation

| Grade | Scope | Phases Used | Depth |
|-------|-------|-------------|-------|
| S | Quick check on one topic | 1 + 3 (partial) | Brief discussion |
| M | Single project retro | 1 + 2 + 3 + 4 | Full analysis, selective action |
| L | Multi-project retro | All 5 phases | Full analysis + implementation |
| XL | System-wide retro | All 5 + parallel agents | Deep analysis + major changes |

---

## Conflict Avoidance

- Phase 2 analysis agents run sequentially to avoid agent mutual exclusion
- Exception: If grade is XL, use ruflo hive-mind for parallel analysis
- hookify conversation-analyzer is an analysis tool -- safe at any grade
- deep-reflector is a diagnostic agent -- exempt from Rule 1
- Phase 5 actions are sequential: hooks first, then skills, then config updates
