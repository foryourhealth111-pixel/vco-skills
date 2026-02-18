# vibe-review Protocol

Protocol for code review, security audit, and quality assurance tasks.

## Scope
Activated when the task requires evaluating existing code:
- Code review (style, correctness, maintainability)
- Security audit (OWASP Top 10, secrets, injection)
- Quality assurance (test coverage, performance)
- Pre-merge validation (comprehensive check before merge)

## Tool Orchestration by Grade

### S/M Grade (Quick Review)
Tool: Everything-CC code-reviewer agent
1. Invoke via Task tool with subagent_type `everything-claude-code:code-reviewer`
2. Lightweight review: bugs, style, correctness
3. Auto-triggered after code changes via PostToolUse hooks

### L Grade (Thorough Review)
Tool: Superpowers two-stage review
1. Stage 1 — Spec reviewer: Does code match the approved design?
2. Stage 2 — Quality reviewer: Is code clean, tested, secure?
3. Invoke via `superpowers:requesting-code-review`

### XL Grade (Cluster Review)
Tool: ruflo agent cluster
1. Spawn multiple reviewer agents via `hive-mind_spawn` (types: Reviewer)
2. Parallel perspectives: security, performance, architecture, style
3. Aggregate findings via `hive-mind_consensus`
4. Use `coordination_orchestrate` for final report

## Security Review (Any Grade)
Always available as an independent check:
1. Invoke Everything-CC security-reviewer agent
2. Checks: OWASP Top 10, hardcoded secrets, injection, XSS, CSRF
3. Can run alongside any grade-specific review without conflict

## Review Checklist
Before approving code:
1. Code is readable and well-named
2. Functions are small (<50 lines)
3. Proper error handling at system boundaries
4. No hardcoded values (use constants or config)
5. Tests exist and pass (80%+ coverage for M+ grade)
6. No security vulnerabilities
7. No console.log / debug statements in production code
8. Immutable patterns used (no mutation)

## Conflict Avoidance
- S/M review: Everything-CC code-reviewer ONLY (do not invoke Superpowers review)
- L review: Superpowers two-stage review ONLY (do not invoke Everything-CC code-reviewer for the same scope)
- XL review: ruflo cluster ONLY
- Security review: Everything-CC security-reviewer at ANY grade (exception to mutual exclusion — it is a specialized diagnostic tool, not a general reviewer)
- See conflict-rules.md Rule 6 for full deconfliction spec

## Output Format
Review findings should be categorized by severity:
- CRITICAL: Must fix before merge (security vulnerabilities, data loss risks)
- HIGH: Should fix before merge (bugs, logic errors)
- MEDIUM: Fix when possible (code smells, minor style issues)
- LOW: Optional improvement (naming suggestions, minor refactors)

## Transition After Review
- If CRITICAL/HIGH issues found: Route to vibe-code protocol for fixes
- If all clean: Proceed to commit/merge
- If architectural issues found: Route to vibe-think protocol for redesign
