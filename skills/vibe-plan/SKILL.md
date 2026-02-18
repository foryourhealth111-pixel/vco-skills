---
name: vibe-plan
description: "VCO planning shortcut: requirements discovery, architecture design, and plan documentation. Use when user types /vibe:plan or needs design-before-code workflow."
---

# vibe-plan — Planning & Design Entry

Shortcut into VCO's vibe-think protocol. Skips task classification and goes directly to planning mode.

## When to Use This Skill

Trigger when any of these applies:
- User types /vibe:plan followed by a task description
- User explicitly asks for design, planning, or architecture work
- A feature needs requirements discovery before implementation
- User wants to evaluate multiple approaches before choosing

## Not For / Boundaries

This skill will NOT:
- Write implementation code (use /vibe:build after plan is approved)
- Handle simple bug fixes (use /vibe or /vibe:build)
- Manage multi-agent orchestration (use /vibe:flow)

Required context:
- If the project domain is unclear, ask: "What is this project about?"
- If scope is ambiguous, ask: "What are the key constraints?"

## Quick Reference

### Planning Workflow

1. **Requirements Discovery**: Invoke `superpowers:brainstorming`
   - Socratic dialogue to clarify requirements
   - HARD-GATE: No code until design approved

2. **Architecture Design** (if needed): Invoke `sc:design`
   - Uses cognitive personas for multi-perspective analysis
   - Produces architecture diagrams and component design

3. **Plan Documentation**: Invoke `superpowers:writing-plans`
   - Generates docs/plans/YYYY-MM-DD-<topic>.md
   - Includes phases, tasks, acceptance criteria

4. **Deep Research** (if needed): Invoke `claude-code-settings:deep-research`
   - Multi-agent parallel research
   - Technology evaluation and comparison

### Conflict Rules
- Use Superpowers brainstorming for requirements (not SuperClaude brainstorm)
- Use SuperClaude sc:design for architecture (not Superpowers)
- Never invoke both brainstorming systems simultaneously

## Examples

### Example 1: New Feature Planning
- Input: "/vibe:plan Add real-time notifications to the app"
- Steps:
  1. Invoke superpowers:brainstorming for requirements
  2. Clarify: push vs pull, WebSocket vs SSE, notification types
  3. Invoke sc:design for architecture
  4. Invoke superpowers:writing-plans for plan doc
- Acceptance: Plan document at docs/plans/ with clear phases

### Example 2: Technology Evaluation
- Input: "/vibe:plan Evaluate database options for our analytics pipeline"
- Steps:
  1. Invoke claude-code-settings:deep-research
  2. Compare options (PostgreSQL, ClickHouse, TimescaleDB, etc.)
  3. Document findings with pros/cons
- Acceptance: Research report with recommendation

### Example 3: Architecture Redesign
- Input: "/vibe:plan Redesign the authentication system"
- Steps:
  1. Invoke superpowers:brainstorming for requirements
  2. Invoke sc:design with security persona
  3. Invoke superpowers:writing-plans
  4. Present to user for approval
- Acceptance: Architecture doc + implementation plan approved by user

## References

- See vibe/references/protocols/think.md for full protocol specification
- See vibe/references/tool-registry.md for tool capabilities
- See vibe/references/conflict-rules.md for conflict avoidance details

## Maintenance

- Sources: VCO system design (2026-02-18)
- Last updated: 2026-02-18
- Known limits: Depends on Superpowers and SuperClaude being installed
