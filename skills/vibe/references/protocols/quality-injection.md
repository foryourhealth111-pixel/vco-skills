# vibe-quality-injection Protocol

Protocol for injecting single-agent quality patterns into multi-agent workflows.
Activates when VCO routes to L/XL grade multi-agent tools.

## Principle

Multi-agent tools excel at parallel coverage but lack the fine-grained quality
discipline of single-agent tools. This protocol bridges that gap by injecting
quality patterns as pre/post wrappers -- without modifying any tool.

## When to Activate

| Condition | Inject? |
|-----------|---------|
| S grade (any tool) | No -- direct execution, no overhead |
| M grade (single-agent tool) | No -- single-agent already has quality built in |
| M grade (multi-agent tool) | Light -- post-validation only |
| L grade (any multi-agent tool) | Yes -- full pre-injection + post-validation |
| XL grade (ruflo orchestration) | Yes -- full injection + checkpoint gates |
## Quality Pattern Registry

Patterns extracted from 6 integrated tools, organized by injection phase.

### Pre-Injection Patterns (establish before multi-agent execution)

#### P1: Root Cause Discipline (from Superpowers systematic-debugging)

INJECT WHEN: Task type = Debug (L/XL grade)

Iron Law: NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.
You must complete Phase 1 (root cause investigation) before proposing fixes.
If 3+ fix attempts fail, STOP and question the architecture.

#### P2: Effort Allocation (from SuperClaude sc:research)

INJECT WHEN: Task type = Research (L/XL grade)

Allocate effort: Understand 5-10%, Plan 10-15%, Execute 50-60%, Validate 10-15%.
Set hop limit: L grade = 3-4 hops max, XL grade = 5 hops max.
Track confidence scores for each finding.

#### P3: Structured Analysis Framework (from Claude-code-settings think-ultra)

INJECT WHEN: Any L/XL grade task requiring analysis

Apply 7-phase analysis: Decompose, Contextualize, Analyze,
Synthesize, Evaluate, Challenge, Integrate.
Each phase must produce explicit output before proceeding.

#### P4: Scientific Method (from Superpowers systematic-debugging)

INJECT WHEN: Task type = Debug or Research (L/XL grade)

Form SINGLE hypothesis. State clearly: I think X because Y.
Make SMALLEST possible change to test. One variable at a time.
Verify before continuing. If wrong, form NEW hypothesis.

#### P5: Evidence-Based Communication (from Superpowers verification-before-completion)

INJECT WHEN: All L/XL grade tasks

NEVER use: should work, probably, seems to, looks good.
ALWAYS use: [Command] [Output] [Claim] format.
Every claim must have verification evidence.

#### P6: PDCA Cycle (from SuperClaude sc:pm)

INJECT WHEN: XL grade tasks

Follow PDCA: Plan (hypothesis) -> Do (experiment) -> Check (evaluate) -> Act (improve).
Document each phase. Never retry same approach without understanding WHY it failed.
### Post-Validation Patterns (verify after multi-agent returns)

#### V1: Evidence Chain Verification (from sc:research)

APPLY WHEN: Task type = Research (L/XL grade)

CHECK:
- Every conclusion has cited source(s)
- No single-source claims for critical findings
- Confidence scores assigned to each finding
- Contradictions explicitly noted and resolved
- Hop depth within limits (L: 3-4, XL: 5)

#### V2: Completion Gate (from Superpowers verification-before-completion)

APPLY WHEN: All L/XL grade tasks

CHECK (5-step gate):
1. IDENTIFY: What command proves this is done?
2. RUN: Execute the FULL verification command (fresh)
3. READ: Full output, check exit code, count failures
4. VERIFY: Does output confirm the claim?
5. ONLY THEN: Mark as complete

#### V3: 6-Phase Quality Pipeline (from Everything-CC verification-loop)

APPLY WHEN: Task type = Coding (L/XL grade)

PIPELINE:
- Build:    [PASS/FAIL]
- Types:    [PASS/FAIL] (X errors)
- Lint:     [PASS/FAIL] (X warnings)
- Tests:    [PASS/FAIL] (X/Y passed, Z% coverage)
- Security: [PASS/FAIL] (X issues)
- Diff:     [X files changed]
- Overall:  [READY/NOT READY]

RULE: Build failure blocks all subsequent phases.

#### V4: Red Flags Self-Check (from Superpowers systematic-debugging)

APPLY WHEN: Task type = Debug (L/XL grade)

CHECK for these red flags in the result:
- Quick fix for now, investigate later -> REJECT
- Just try changing X and see -> REJECT
- Multiple changes, run tests -> REJECT
- I do not fully understand but this might work -> REJECT
- Proposed solutions without data flow tracing -> REJECT

#### V5: Rationalization Blocker (from Superpowers verification-before-completion)

APPLY WHEN: All L/XL grade tasks

SCAN result for rationalizations:
- Should work now -> Demand: run verification
- I am confident -> Demand: confidence != evidence
- Partial check enough -> Demand: full verification
- Agent said success -> Demand: verify independently

#### V6: Agent Trust-But-Verify (from Superpowers verification-before-completion)

APPLY WHEN: XL grade (ruflo multi-agent)

AFTER agent cluster returns:
1. Check VCS diff independently
2. Run verification commands (not agent report)
3. Compare agent claim vs. actual evidence
4. Report actual state, not agent claim

#### V7: Learning Capture (from Everything-CC continuous-learning-v2)

APPLY WHEN: All L/XL grade tasks (post-completion)

CAPTURE:
- What routing decision was made and why
- Did the quality injection help? Which patterns triggered?
- What would improve next time?
- Store via: everything-claude-code:continuous-learning-v2
## Injection Matrix

Which patterns to inject for each task type x grade combination:

| Task Type | L Grade Pre | L Grade Post | XL Grade Pre | XL Grade Post |
|-----------|-------------|--------------|--------------|---------------|
| Planning | P3, P5 | V2, V5 | P3, P5, P6 | V2, V5, V6 |
| Coding | P5 | V2, V3, V5 | P5, P6 | V2, V3, V5, V6 |
| Review | P3, P5 | V2, V5 | P3, P5 | V2, V5, V6 |
| Debug | P1, P4, P5 | V2, V4, V5 | P1, P4, P5, P6 | V2, V4, V5, V6 |
| Research | P2, P3, P5 | V1, V2, V5 | P2, P3, P5, P6 | V1, V2, V5, V6 |

Note: V7 (Learning Capture) always applies post-completion for all L/XL tasks.

## Execution Flow Integration

The quality injection integrates into VCO execution flow as steps 7.5 and 8.5:



## Injection Mechanism

Quality injection works through context enrichment, not tool modification:

1. Pre-injection adds quality criteria to the conversation context BEFORE
   invoking the multi-agent tool. The tool sees these criteria as part of its
   task description.

2. Post-validation runs AFTER the multi-agent tool returns, using VCO own
   judgment (or single-agent tools) to verify the result against the
   quality patterns.

3. No tool is modified. The injection is purely behavioral -- VCO adds
   context before and checks results after.

Example pre-injection for L-grade Debug task:



## Fallback Behavior

If quality injection overhead is too high for context budget:

| Context Usage | Injection Level |
|---------------|----------------|
| < 40% | Full injection (all applicable patterns) |
| 40-60% | Essential only (P5 + V2 + V5 + V7) |
| 60-80% | Minimal (V2 + V7 only) |
| > 80% | Skip injection, note in feedback |

## Source Attribution

| Pattern | Source Tool | Source Plugin |
|---------|-----------|---------------|
| P1: Root Cause Discipline | systematic-debugging | Superpowers |
| P2: Effort Allocation | sc:research | SuperClaude |
| P3: Structured Analysis | think-ultra | Claude-code-settings |
| P4: Scientific Method | systematic-debugging | Superpowers |
| P5: Evidence-Based Communication | verification-before-completion | Superpowers |
| P6: PDCA Cycle | sc:pm | SuperClaude |
| V1: Evidence Chain Verification | sc:research | SuperClaude |
| V2: Completion Gate | verification-before-completion | Superpowers |
| V3: 6-Phase Quality Pipeline | verification-loop | Everything-CC |
| V4: Red Flags Self-Check | systematic-debugging | Superpowers |
| V5: Rationalization Blocker | verification-before-completion | Superpowers |
| V6: Agent Trust-But-Verify | verification-before-completion | Superpowers |
| V7: Learning Capture | continuous-learning-v2 | Everything-CC |
