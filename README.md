# VCO — Vibe Code Orchestrator

> Unified orchestration layer for Claude Code that intelligently routes tasks across integrated plugins, eliminating tool selection confusion and preventing plugin conflicts.

VCO acts as a **meta-skill** — it doesn't replace any existing tool, but sits above them as a routing and coordination layer. When you type `/vibe`, VCO classifies your task by complexity and type, selects the optimal tool combination, applies conflict avoidance rules, and executes with quality gates.

## Why VCO?

When you install multiple Claude Code plugins, you face:
- **Tool overlap**: 3+ plugins can do code review, 2+ can do brainstorming, 2+ can do research
- **Conflict risk**: Running multiple agent systems simultaneously causes unpredictable behavior
- **Decision fatigue**: Choosing between 100+ MCP tools, 30+ skills, and 20+ agents per task

VCO solves this by providing a single entry point (`/vibe`) that makes all routing decisions automatically.

## Architecture

```
                         /vibe (user input)
                              |
                    ┌─────────┴─────────┐
                    │   Quick Probe     │
                    │  (Glob/Grep ×2)   │
                    └─────────┬─────────┘
                              |
                    ┌─────────┴─────────┐
                    │  Grade Decision   │
                    │  M / L / XL       │
                    └─────────┬─────────┘
                              |
              ┌───────────────┼───────────────┐
              |               |               |
        ┌─────┴─────┐  ┌─────┴─────┐  ┌─────┴─────┐
        │ M Grade    │  │ L Grade   │  │ XL Grade  │
        │ Single     │  │ Design →  │  │ TeamCreate│
        │ Agent      │  │ Subagent  │  │ Swarm     │
        └────────────┘  └───────────┘  └───────────┘
```

### Grade-Based Routing

| Grade | When Appropriate | Key Signal | Execution Mode |
|-------|-----------------|------------|----------------|
| M | Clear implementation path, no design decisions | ≤5 files + no design keywords + single module | Single agent: analyze + execute + review |
| L | Design decisions or cross-module coordination | Design keywords OR >5 files OR multi-module | Design first → plan → subagent → two-stage review |
| XL | Parallelizable independent workflows | User requests multi-agent OR structurally parallel | TeamCreate team coordination |

Not invoking `/vibe` = implicit simple task, zero overhead.

### Tool Selection Matrix

| Task Type | M Grade | L Grade | XL Grade |
|-----------|---------|---------|----------|
| Planning | sc:design | brainstorming + writing-plans | dialectic-design / TeamCreate |
| Coding | tdd-guide + code-reviewer | subagent-driven-dev | TeamCreate team |
| Review | code-reviewer + security-reviewer | two-stage review (spec + quality) | TeamCreate multi-reviewer |
| Debug | systematic-debugging | systematic-debugging + parallel | TeamCreate debug team |
| Research | sc:research or deep-research | deep-research | TeamCreate research team |

### Protocol System

| Protocol | File | When |
|----------|------|------|
| vibe-think | protocols/think.md | Planning, design, research (L grade) |
| vibe-do | protocols/do.md | Coding, debugging (L grade) |
| vibe-review | protocols/review.md | Code review, security audit (M/L/XL) |
| vibe-team | protocols/team.md | XL multi-agent coordination |
| vibe-retro | protocols/retro.md | Workflow review and improvement |

### Conflict Avoidance (3 Rules)

| Rule | What It Prevents |
|------|-----------------|
| Rule 1: Agent Boundary | M=single-agent tools, L=subagent, XL=TeamCreate. One system per task. |
| Rule 2: Memory Division | TodoWrite=state, ruflo=vectors, Serena=project, instincts=behavior. |
| Rule 3: Command Priority | User explicit command > VCO routing > plugin defaults. |

### Core Quality Gates

- **P5**: Evidence-Based Communication — NEVER say "should work". Use [Command] [Output] [Claim] format.
- **V2**: Completion Gate — IDENTIFY → RUN → READ → VERIFY → MARK COMPLETE.
- **V3**: Quality Pipeline — Build → Types → Lint → Tests → Security → Diff → [READY/NOT READY].

## Installation

### Step 1: Clone this repository

```bash
git clone https://github.com/foryourhealth111-pixel/vco-skills.git
```

### Step 2: Copy skill to Claude Code skills directory

```bash
cp -r vco-skills/skills/vibe ~/.claude/skills/vibe
```

### Step 3: Verify installation

Start a new Claude Code session and type:
```
/vibe Hello, verify VCO is working
```

## File Structure

```
skills/
└── vibe/                          # VCO entry point
    ├── SKILL.md                   # Core routing logic, matrix, execution flow
    ├── protocols/
    │   ├── do.md                  # Implementation/debug protocol
    │   ├── retro.md               # Retrospective meeting protocol
    │   ├── review.md              # Code review/security protocol
    │   ├── team.md                # Multi-agent coordination protocol
    │   └── think.md               # Planning/design/research protocol
    └── references/
        ├── changelog.md           # Version history
        ├── conflict-rules.md      # 3 conflict avoidance rules
        ├── extending-vco.md       # Guide for adding new tools
        ├── fallback-chains.md     # Degradation paths per task type
        ├── index.md               # Navigation index
        ├── team-templates.md      # 6 predefined team compositions
        └── tool-registry.md       # Tool capabilities + verification status
```

## Extending VCO

See `references/extending-vco.md` for the full guide.

## Limitations

- **Behavioral enforcement only**: VCO uses instructions, not technical enforcement. Claude may occasionally deviate.
- **Hook execution order**: VCO cannot control the order hooks from different plugins execute.
- **Plugin availability**: VCO degrades gracefully but works best with all plugins installed.
- **Context window**: Complex L/XL tasks may consume significant context.
- **Quick probe accuracy**: Depends on task description quality.

## License

MIT
