# VCO Changelog

All notable changes to VCO (Vibe Code Orchestrator) are documented here.

Format: [Semantic Versioning](https://semver.org/) with detailed rationale for each change.

---

## [1.2.0] - 2026-02-18

### Changed
- **retrospective.md Phase 3**: Replaced passive "Discussion Rules" with proactive "Pedagogical Advisory" interaction style
  - Files: `skills/vibe/references/protocols/retrospective.md`
  - Rationale: User requested the retrospective discussion to be more interactive and teaching-oriented. The original style ("AI provides data-backed observations, not opinions") was too passive for a collaborative review session. New style uses guiding questions, analogies from user history, and concrete improvement paths while still respecting user autonomy.

### Added
- **Iteration Governance section** in extending-vco.md
  - Files: `skills/vibe/references/extending-vco.md`
  - Rationale: User identified the need for disciplined VCO evolution. Without governance rules, VCO risks accumulating unnecessary complexity. Three principles added: Occam's Razor (prove necessity before adding), User Confirmation Gate (explicit approval for structural changes), Change Rationale Recording (every change must explain WHY).
- **CHANGELOG.md** (this file)
  - Rationale: No iteration history existed. Without a changelog, the evolution of VCO is invisible, making it hard to understand why decisions were made or to roll back changes.

---

## [1.1.0] - 2026-02-18

### Added
- **vibe-retrospective protocol** (5-phase collaborative review system)
  - Files: `skills/vibe/references/protocols/retrospective.md` (new), `skills/vibe-retro/SKILL.md` (new)
  - Rationale: User wanted a structured way to review recent projects, detect error patterns, optimize workflows, and decide whether to create new hooks/skills/agents/MCPs. Designed as pure tool composition across 6 plugins (GATHER from 5 data sources, ANALYZE with 4 tools, DISCUSS via Socratic dialogue, DECIDE with user confirmation gate, ACT with existing creation tools).
- **Routing and index updates** for retrospective
  - Files: `skills/vibe/SKILL.md`, `skills/vibe/references/index.md`, `skills/vibe/references/extending-vco.md`
  - Rationale: New protocol must be discoverable through VCO routing. Added to routing decision tree, protocol table, index, and protocol alignment list.

---

## [1.0.0] - 2026-02-18

### Added
- **Initial release** of VCO with 7 protocols and 5 sub-skills
  - Core router: `skills/vibe/SKILL.md`
  - Protocols: analysis, think, code, review, quality-injection, orchestrate, memory
  - Sub-skills: vibe-build, vibe-plan, vibe-review, vibe-flow
  - Reference docs: tool-registry, routing-table, conflict-rules, fallback-chains, extending-vco, index
  - Rationale: 6 Claude Code plugins installed simultaneously caused tool overlap, conflict risk, and decision fatigue. VCO provides a single entry point that classifies tasks by complexity (S/M/L/XL), routes to optimal tool combinations, and prevents plugin conflicts through behavioral rules.
- **Quality Injection protocol** (13 patterns)
  - Files: `skills/vibe/references/protocols/quality-injection.md`
  - Rationale: Analysis revealed that single-agent tools (systematic-debugging, verification-before-completion, etc.) contain excellent quality patterns that multi-agent workflows lack. Quality injection bridges this gap by extracting 6 pre-injection and 7 post-validation patterns from single-agent tools and injecting them into multi-agent workflows.
- **README.md** with comprehensive documentation
  - Rationale: GitHub repository needs clear documentation for installation, prerequisites, usage, and architecture understanding.
