---
name: vibe
description: "Unified vibe code orchestrator: intelligent routing across 6 integrated tools (Superpowers, SuperClaude, Everything-CC, Claude-code-settings, Claude-flow/ruflo, Ralph-loop). Use when starting any development task, or when unsure which tool to use."
---

# VCO — Vibe Code Orchestrator

Unified entry point that classifies tasks, selects optimal tool combinations, and coordinates 6 integrated plugins without modifying any of them.

## When to Use This Skill

Trigger when any of these applies:
- User starts a development task and you need to decide which tools to use
- User types `/vibe` followed by a task description
- A task spans multiple tools or requires coordination between plugins
- You need to classify task complexity before choosing an approach
- User is unsure which tool/command to use for their task

## Not For / Boundaries

This skill will NOT:
- Replace individual tool skills (it routes TO them, not replaces them)
- Modify any existing plugin's source code or hooks
- Override user's explicit tool choice (if user says `/sc:design`, use that directly)
- Handle tool installation or configuration issues

Required context:
- If the task description is ambiguous, ask: "What is the expected outcome?"
- If complexity is unclear, ask: "Is this a single-file change or does it span multiple modules?"

## Quick Reference

### 1. Task Complexity Classification

| Grade | Signal | Execution Mode |
|-------|--------|----------------|
| S (Simple) | Single file, clear fix, quick Q&A | Full auto |
| M (Medium) | Multi-file, needs context understanding | Auto + checkpoints |
| L (Large) | Architecture change, multi-module, needs design | Staged confirmation |
| XL (Extra-Large) | Multi-agent collaboration, cross-project, long-cycle | Orchestration mode |

### 2. Routing Decision Tree

```
User task arrives
  |
  +- Is it a question/explanation? -> Answer directly (no tool needed)
  |
  +- Classify complexity -> S/M/L/XL
  |
  +- Classify type:
  |   +- Planning/Design    -> vibe-think protocol
  |   +- Coding/Debugging   -> vibe-code protocol
  |   +- Review/Quality     -> vibe-review protocol
  |   +- Complex orchestration -> vibe-orchestrate protocol
  |   +- Research/Analysis  -> vibe-think protocol (research mode)
  |
  +- Apply conflict rules -> See "Conflict Avoidance" below
```

### 3. Tool Selection Matrix

| Task Type | S Grade | M Grade | L Grade | XL Grade |
|-----------|---------|---------|---------|----------|
| Planning | Direct answer | SuperClaude sc:design | Superpowers brainstorming + writing-plans | ruflo workflow_create |
| Coding | Direct edit | Everything-CC tdd-guide | Superpowers subagent-driven-dev | ruflo hive-mind_spawn |
| Review | Everything-CC code-reviewer | Parallel: code + security reviewer | Superpowers two-stage review | ruflo agent cluster review |
| Debug | Direct fix | Superpowers systematic-debugging | Superpowers systematic-debugging + parallel investigation | ruflo swarm debug |
| Research | Direct search | SuperClaude sc:research | Claude-code-settings deep-research | ruflo embeddings + memory |

*build-error-resolver is a specialized diagnostic agent for build errors, available at any grade (exempt from Rule 1, see conflict-rules.md)

### 4. Conflict Avoidance Rules (Critical)

**Rule 1 — Agent System Mutual Exclusion:**
Use only ONE agent system per task:
- S/M -> Everything-CC agents (lightweight)
- L -> Superpowers subagent-driven-dev (two-stage review)
- XL -> Claude-flow/ruflo (swarm/hive-mind)

**Rule 2 — Memory System Division:**
- Cross-session long-term -> episodic-memory (search past conversations)
- Current task state -> ruflo memory_store (HNSW vector search)
- Pattern learning -> Everything-CC instinct system
- Project knowledge -> Serena MCP write_memory

**Rule 3 — Hook Coexistence:**
All existing hooks remain active. Avoid conflicts through behavior:
- Everything-CC PreToolUse/PostToolUse -> Always run (code quality guard)
- Claude-flow hooks -> Only actively invoke MCP tools for XL tasks
- Ralph-loop Stop hook -> Only activates on explicit /ralph-loop
- Superpowers SessionStart -> Always run (skill checking)

**Rule 4 — Command Priority:**
VCO routing > SuperClaude sc:* > Individual plugin commands.
When VCO routes to a tool, follow VCO protocol, not the tool's default behavior.

### 5. Protocol Activation

After classification, activate the corresponding protocol by reading its reference doc:

| Protocol | Reference | Primary Tools |
|----------|-----------|---------------|
| vibe-analysis | references/protocols/analysis.md | Claude-code-settings think-harder/ultra, Superpowers |
| vibe-think | references/protocols/think.md | Superpowers, SuperClaude |
| vibe-code | references/protocols/code.md | Everything-CC, Claude-code-settings |
| vibe-review | references/protocols/review.md | Everything-CC, Superpowers, ruflo |
| vibe-quality-injection | references/protocols/quality-injection.md | Cross-plugin quality patterns (13 patterns) |
| vibe-orchestrate | references/protocols/orchestrate.md | Claude-flow/ruflo, Ralph-loop |
| vibe-memory | references/protocols/memory.md | episodic-memory, ruflo memory, instincts |

### 6. Execution Flow Template

```
1. CLASSIFY: Determine grade (S/M/L/XL) and type (plan/code/review/debug/research)
2. ANALYZE (M+ grade): Pre-routing structured analysis (see protocols/analysis.md)
   - M: invoke claude-code-settings:think-harder
   - L: invoke claude-code-settings:think-ultra
   - XL: invoke superpowers:brainstorming
3. DECOMPOSE (if compound task): Split into ordered phases
   - M: everything-claude-code:planner agent
   - L: superpowers:writing-plans
   - XL: ruflo workflow_create
4. SELECT: Pick tools from the matrix above
5. CHECK: Apply conflict avoidance rules + verify fallback availability
6. CONTEXT (L+ grade): Estimate context budget, plan compaction points
   - Use everything-claude-code:strategic-compact when context > 60%
   - Store state in ruflo memory_store before compaction
7. MEMORY: Query episodic-memory for relevant history (if M+ grade)
7.5 QUALITY-INJECT (L/XL grade, multi-agent target only):
    - Look up Injection Matrix in protocols/quality-injection.md
    - Inject Pre-Injection patterns (P1-P6) as quality context
    - Define Post-Validation checklist (V1-V7) for step 8.5
8. EXECUTE: Follow the selected protocol (with quality context + fallback chain)
8.5 QUALITY-VERIFY (L/XL grade, when injection was applied):
    - Run applicable Post-Validation patterns (V1-V7)
    - Block completion if V2/V3 fail; request re-analysis if V4/V5 fail
    - Always capture learning via V7
9. REVIEW: Auto-trigger code-reviewer for any code changes (M+ grade)
10. FEEDBACK: Post-execution learning (M+ grade)
    - everything-claude-code:continuous-learning-v2 (instinct extraction)
    - Store routing decision outcome in episodic-memory
```

Note: Steps 2-3 reuse existing tools from the 6 plugins. See references/protocols/analysis.md
for the full analysis protocol. Steps 7.5/8.5 inject single-agent quality patterns into
multi-agent workflows — see references/protocols/quality-injection.md for the full protocol
and references/fallback-chains.md for degradation paths.

## Examples

### Example 1: Simple Bug Fix (S Grade)

- Input: "Fix a button click not responding"
- Steps:
  1. Classify: S grade, Coding/Debug type
  2. Select: Direct fix (no agent system needed)
  3. Locate the bug, fix it directly
  4. Auto-trigger Everything-CC code-reviewer (lightweight check)
- Acceptance: Bug fixed, code reviewed, no unnecessary orchestration overhead

### Example 2: New Feature Design (L Grade)

- Input: "Design a new user authentication system"
- Steps:
  1. Classify: L grade, Planning type
  2. Select: vibe-think protocol
  3. Invoke Superpowers brainstorming -> requirements discovery
  4. Invoke SuperClaude sc:design -> architecture design
  5. Invoke Superpowers writing-plans -> generate plan document
  6. Wait for user confirmation
  7. Switch to vibe-code protocol -> implement with TDD
- Acceptance: Design doc produced, user approved, implementation follows TDD

### Example 3: Large-Scale Refactoring (XL Grade)

- Input: "/vibe:flow Refactor the entire data layer"
- Steps:
  1. Classify: XL grade, Orchestration type
  2. Select: vibe-orchestrate protocol
  3. Query episodic-memory for related past decisions
  4. Create ruflo workflow with phases
  5. Spawn ruflo hive-mind workers (architect, coder, tester)
  6. Coordinate execution with staged confirmations
  7. Store decisions in ruflo memory for future reference
- Acceptance: Data layer refactored, all tests pass, decisions persisted

## References

- references/index.md — Navigation index for all VCO documentation
- references/tool-registry.md — Complete capabilities of all 6 integrated tools
- references/routing-table.md — Detailed routing rules and decision criteria
- references/conflict-rules.md — Full conflict avoidance specification
- references/fallback-chains.md — Error recovery and context budget using existing tools
- references/extending-vco.md — Guide for adding new tools or adapting to updates
- references/protocols/analysis.md — Pre-routing analysis and compound task decomposition
- references/protocols/quality-injection.md — Quality injection for multi-agent workflows (13 patterns)
- references/protocols/think.md — vibe-think protocol specification
- references/protocols/code.md — vibe-code protocol specification
- references/protocols/review.md — vibe-review protocol specification
- references/protocols/orchestrate.md — vibe-orchestrate protocol specification
- references/protocols/memory.md — vibe-memory protocol specification (includes feedback loop)

## Maintenance

- Sources: Source code analysis of 6 plugins (2026-02-18)
- Last updated: 2026-02-18
- Known limits:
  - Hook execution order between plugins is not controllable by VCO
  - Conflict avoidance is behavioral (instruction-based), not technical enforcement
  - Tool availability depends on plugin installation status
  - ruflo MCP tools require the MCP server to be running
