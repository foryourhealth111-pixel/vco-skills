---
name: vibe-review
description: "VCO review shortcut: code review, security audit, and quality assurance. Use when user types /vibe:review or needs code quality verification."
---

# vibe-review — Review & Quality Entry

Shortcut for code review and quality assurance tasks.

## When to Use This Skill

Trigger when any of these applies:
- User types /vibe:review followed by a description
- User asks for code review, security audit, or quality check
- Code was just written and needs review before commit
- User wants to verify code quality across the project

## Not For / Boundaries

This skill will NOT:
- Write or modify code (it reviews only; fixes go through /vibe:build)
- Handle planning or design tasks (use /vibe:plan)
- Manage multi-agent orchestration (use /vibe:flow)

## Quick Reference

### Review by Grade

**S/M Grade (quick review):**
- Invoke Everything-CC code-reviewer agent
- Lightweight, focuses on bugs and style
- Auto-triggered after code changes

**L Grade (thorough review):**
- Invoke Superpowers two-stage review:
  1. Spec reviewer: Does code match the design?
  2. Quality reviewer: Is code clean, tested, secure?

**XL Grade (cluster review):**
- Use ruflo agent cluster for parallel multi-perspective review
- Multiple reviewers: security, performance, architecture, style

### Security Review
- Always available regardless of grade
- Invoke Everything-CC security-reviewer
- Checks: OWASP Top 10, secrets, injection, XSS, CSRF

### Review Checklist
1. Code is readable and well-named
2. Functions are small (<50 lines)
3. Proper error handling
4. No hardcoded values
5. Tests exist and pass
6. No security vulnerabilities
7. No console.log in production code

## Examples

### Example 1: Quick Code Review
- Input: "/vibe:review Check the changes I just made"
- Steps:
  1. Invoke Everything-CC code-reviewer
  2. Review focuses on bugs, style, and correctness
- Acceptance: Review report with findings categorized by severity

### Example 2: Security Audit
- Input: "/vibe:review Security audit the authentication module"
- Steps:
  1. Invoke Everything-CC security-reviewer
  2. Check for OWASP Top 10 vulnerabilities
  3. Check for hardcoded secrets
  4. Report findings with remediation suggestions
- Acceptance: Security report with no CRITICAL findings

### Example 3: Pre-Merge Review
- Input: "/vibe:review Full review before merging the feature branch"
- Steps:
  1. Invoke Superpowers two-stage review (spec + quality)
  2. Invoke Everything-CC security-reviewer
  3. Compile findings into unified report
- Acceptance: All CRITICAL and HIGH issues resolved

## References

- See vibe/references/protocols/review.md for full review protocol specification
- See vibe/references/conflict-rules.md Rule 6 for review deconfliction

## Maintenance

- Sources: VCO system design (2026-02-18)
- Last updated: 2026-02-18
- Known limits: Review is behavioral guidance, not automated static analysis
