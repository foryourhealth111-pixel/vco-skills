# VCO References Index

Navigation guide for all VCO (Vibe Code Orchestrator) documentation.

## Core Documents

| Document | Purpose |
|----------|---------|
| [tool-registry.md](tool-registry.md) | Capabilities, APIs, and state paths of all 6 integrated tools |
| [routing-table.md](routing-table.md) | Detailed task classification criteria and routing decision rules |
| [conflict-rules.md](conflict-rules.md) | Full conflict avoidance specification between tools |
| [fallback-chains.md](fallback-chains.md) | Error recovery degradation paths and context budget management |
| [extending-vco.md](extending-vco.md) | Guide for adding new tools or adapting to tool updates |

## Protocol Specifications

| Protocol | Document | Primary Tools |
|----------|----------|---------------|
| vibe-analysis | [protocols/analysis.md](protocols/analysis.md) | Claude-code-settings think-harder/ultra, Superpowers |
| vibe-think | [protocols/think.md](protocols/think.md) | Superpowers, SuperClaude |
| vibe-code | [protocols/code.md](protocols/code.md) | Everything-CC, Claude-code-settings |
| vibe-review | [protocols/review.md](protocols/review.md) | Everything-CC, Superpowers, ruflo |
| vibe-quality-injection | [protocols/quality-injection.md](protocols/quality-injection.md) | Cross-plugin: 6 Pre + 7 Post patterns |
| vibe-orchestrate | [protocols/orchestrate.md](protocols/orchestrate.md) | Claude-flow/ruflo, Ralph-loop |
| vibe-memory | [protocols/memory.md](protocols/memory.md) | episodic-memory, ruflo memory, instincts, feedback loop |
| vibe-retrospective | [protocols/retrospective.md](protocols/retrospective.md) | episodic-memory, reflection-harder, hookify, think-ultra |

## Reading Order

1. Start with `tool-registry.md` to understand what each tool provides
2. Read `routing-table.md` to understand how tasks are classified and routed
3. Read `conflict-rules.md` to understand how tools coexist safely
4. Read `fallback-chains.md` to understand error recovery and context management
5. Read `protocols/quality-injection.md` to understand how quality patterns are injected into multi-agent workflows
6. Read the relevant protocol doc for your current task type
7. Consult `extending-vco.md` when adding new tools or handling updates
