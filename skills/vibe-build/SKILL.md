---
name: vibe-build
description: "VCO coding shortcut: implementation, debugging, testing, and refactoring. Use when user types /vibe:build or needs to write/modify code with appropriate quality gates."
---

# vibe-build — Coding & Implementation Entry

Shortcut into VCO's vibe-code protocol. Skips task classification and goes directly to coding mode.

## When to Use This Skill

Trigger when any of these applies:
- User types /vibe:build followed by a task description
- User explicitly asks to implement, code, fix, or refactor
- A plan exists and user wants to start implementation
- User needs to debug or fix a build error

## Not For / Boundaries

This skill will NOT:
- Do design or planning (use /vibe:plan first)
- Handle XL-grade multi-agent tasks (use /vibe:flow)
- Replace explicit tool invocations (if user says /sc:implement, use that)

Required context:
- If no design exists for L-grade tasks, suggest /vibe:plan first
- If the codebase is unfamiliar, explore before coding

## Quick Reference

### Coding by Grade

**S Grade (single file, clear fix):**
1. Edit directly with Claude Code tools
2. Everything-CC hooks auto-run (format, type-check)

**M Grade (multi-file, needs context):**
1. Invoke Everything-CC tdd-guide (write tests first)
2. Implement to pass tests
3. Everything-CC code-reviewer auto-triggers
4. Security-reviewer if user-facing code

**L Grade (architecture change, 5+ files):**
1. Verify design exists (from /vibe:plan)
2. Invoke superpowers:subagent-driven-development
3. Fresh subagent per task, two-stage review
4. Final: superpowers:verification-before-completion

### Debug Mode
- S bug: Direct fix
- M bug: Invoke superpowers:systematic-debugging (4-phase root cause methodology)
- L bug: Invoke superpowers:systematic-debugging + dispatching-parallel-agents
- Build errors (any grade): Everything-CC build-error-resolver* available as specialized tool

*Specialized diagnostic agent, exempt from agent mutual exclusion Rule 1

### Conflict Rules
- S/M grade: Use Everything-CC agents only
- L grade: Use Superpowers subagent system only
- Never mix agent systems on the same task

## Examples

### Example 1: Quick Bug Fix (S Grade)
- Input: "/vibe:build Fix the null pointer in UserService.getProfile()"
- Steps:
  1. Read the file, locate the bug
  2. Fix directly
  3. Everything-CC auto-formats and type-checks
- Acceptance: Bug fixed, no test regressions

### Example 2: New API Endpoint (M Grade)
- Input: "/vibe:build Add a GET /api/users/:id/settings endpoint"
- Steps:
  1. Invoke Everything-CC tdd-guide
  2. Write test for the endpoint (RED)
  3. Implement the endpoint (GREEN)
  4. Refactor if needed (IMPROVE)
  5. Code review auto-triggers
- Acceptance: Endpoint works, tests pass, 80%+ coverage

### Example 3: Feature Implementation (L Grade)
- Input: "/vibe:build Implement the auth system from the approved plan"
- Steps:
  1. Read plan from docs/plans/
  2. Invoke superpowers:subagent-driven-development
  3. Each task: implement -> spec review -> quality review
  4. Final verification
- Acceptance: All plan tasks complete, tests pass, reviews clean

## References

- See vibe/references/protocols/code.md for full protocol specification
- See vibe/references/tool-registry.md for tool capabilities
- See vibe/references/conflict-rules.md for conflict avoidance details

## Maintenance

- Sources: VCO system design (2026-02-18)
- Last updated: 2026-02-18
- Known limits: Depends on Everything-CC and Superpowers being installed
