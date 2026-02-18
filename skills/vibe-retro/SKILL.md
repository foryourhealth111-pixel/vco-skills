---
name: vibe-retro
description: "VCO retrospective meeting: collaborative analysis of recent projects, workflow optimization, error pattern detection, and future improvement planning. Use when user types /vibe:retro or wants to review and improve their development workflow."
---

# vibe-retro -- Retrospective Meeting Entry

Shortcut into VCO retrospective protocol. Conducts a structured 5-phase
retrospective meeting for collaborative learning and improvement.

## When to Use This Skill

Trigger when any of these applies:
- User types /vibe:retro followed by a topic or project path
- User asks to review recent work, analyze patterns, or discuss improvements
- User wants to identify recurring errors and create preventive hooks
- User wants to discover reusable workflows worth automating as skills/agents
- User says: review, retrospective, retro, lessons learned, what went well

## Not For / Boundaries

This skill will NOT:
- Write or modify project code (improvements go through /vibe:build)
- Replace individual tool commands (if user says /hookify, use that directly)
- Make decisions without user approval (Phase 4 requires explicit confirmation)
- Implement changes without going through the full 5-phase process

## Quick Reference

### 5-Phase Workflow

**Phase 1: GATHER (data collection)**
- Search episodic-memory for recent conversations
- Read session files from ~/.claude/sessions/
- Check instinct-status for learned patterns
- Query Serena project memories
- Collect error logs from git and observations

**Phase 2: ANALYZE (structured analysis)**
- Invoke reflection-harder for session analysis
- Invoke conversation-analyzer for problem detection
- Analyze workflow frequency and automation candidates
- Invoke think-ultra for cross-session trend synthesis

**Phase 3: DISCUSS (interactive dialogue)**
- Socratic dialogue exploring findings with user
- Topics: workflow optimization, error prevention, tool effectiveness, future planning
- User leads direction, AI provides data-backed observations

**Phase 4: DECIDE (user-approved decisions)**
- Categorize improvements: skill / command / hook / instinct / config / agent / mcp
- User approves, modifies, or rejects each decision
- Nothing is implemented without explicit approval

**Phase 5: ACT (execute improvements)**
- Create hooks via hookify
- Create skills via writing-skills or command-creator
- Create/update instincts via continuous-learning-v2
- Update VCO configuration if routing changes needed
- Persist knowledge via Serena write_memory
- Generate retro report

### Grade Adaptation

| Grade | Scope | Phases |
|-------|-------|--------|
| S | Quick check on one topic | 1 + 3 (partial) |
| M | Single project retro | 1 + 2 + 3 + 4 |
| L | Multi-project retro | All 5 phases |
| XL | System-wide retro | All 5 + parallel agents |

### Invocation Examples

- /vibe:retro "Review the VCO project work from this week"
- /vibe:retro "Analyze error patterns in the auth module"
- /vibe:retro "What workflows should we automate?"
- /vibe:retro "Full system retrospective"

## Examples

### Example 1: Project Workflow Review (M Grade)
- Input: "/vibe:retro Review the VCO project workflow"
- Steps:
  1. GATHER: Search episodic-memory for VCO-related sessions
  2. ANALYZE: reflection-harder on recent sessions + think-ultra synthesis
  3. DISCUSS: Explore findings with user
  4. DECIDE: User approves creating a reusable skill for similar projects
- Acceptance: Improvement decisions documented, user satisfied with analysis

### Example 2: Error Pattern Detection (M Grade)
- Input: "/vibe:retro Why do I keep hitting the same build errors?"
- Steps:
  1. GATHER: Search for error/fix/revert in episodic-memory + git log
  2. ANALYZE: conversation-analyzer detects repeated error patterns
  3. DISCUSS: Review top 3 error patterns with user
  4. DECIDE: User approves creating 2 preventive hooks
- Acceptance: Hooks created, error patterns documented

### Example 3: Full System Retrospective (L Grade)
- Input: "/vibe:retro Full retrospective on all recent projects"
- Steps:
  1. GATHER: All 5 data sources (episodic, sessions, instincts, Serena, git)
  2. ANALYZE: All 4 analysis tools (reflection, problems, workflows, trends)
  3. DISCUSS: Deep exploration of findings across all projects
  4. DECIDE: Prioritized list of improvements
  5. ACT: Implement approved hooks, skills, instincts, config changes
- Acceptance: Retro report generated, improvements implemented

## References

- See vibe/references/protocols/retrospective.md for full protocol specification
- See vibe/references/protocols/memory.md for memory system details
- See vibe/references/tool-registry.md for tool capabilities

## Maintenance

- Sources: VCO system design (2026-02-18)
- Last updated: 2026-02-18
- Known limits: Quality of retro depends on episodic-memory indexing completeness
