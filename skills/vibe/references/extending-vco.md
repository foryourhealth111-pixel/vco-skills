# Extending VCO

Guide for adding new tools or adapting to tool updates.

## Adding a New Tool

### Step 1: Analyze the Tool
Before integration, answer these questions:
1. What hook types does it register?
2. What state does it manage? (file paths, databases)
3. What agent/skill capabilities does it provide?
4. Does it assume exclusive control of any resource?

### Step 2: Register in Tool Registry
Add an entry to references/tool-registry.md with:
- Tool name, version, location
- Hook types registered
- State location
- Key skills/agents/commands

### Step 3: Identify Conflicts
Check against existing tools for:
- Hook type overlaps (same event types)
- State path collisions (same directories)
- Agent name collisions (same agent names)
- Behavioral conflicts (competing mandates)

### Step 4: Add Conflict Rules
Add resolution rules to references/conflict-rules.md:
- Which grade/type should use the new tool
- How it coexists with existing tools
- Any mutual exclusion requirements

### Step 5: Update Routing Table
Add the new tool to references/routing-table.md:
- Which task types/grades route to it
- Where it fits in the tool selection matrix

### Step 6: Update Protocols
If the new tool provides unique capabilities, update the relevant
protocol in references/protocols/:
- Add the tool to the protocol tool list
- Define when and how to invoke it

### Step 7: Update SKILL.md
Update the main vibe/SKILL.md:
- Add to the tool selection matrix
- Update conflict avoidance rules if needed

## Adapting to Tool Updates

### Minor Updates (patch/minor version)
1. Check release notes for new features or changed behavior
2. Verify existing conflict rules still apply
3. Update version numbers in tool-registry.md

### Major Updates (breaking changes)
1. Re-analyze the tool (Step 1 above)
2. Check if hook registrations changed
3. Check if state paths changed
4. Update all affected reference documents

### Tool Removal
1. Remove from tool-registry.md
2. Remove from routing-table.md
3. Remove conflict rules that reference it
4. Update protocols that used it
5. Update SKILL.md tool selection matrix

## Design Principles for Extensibility

1. No source modification: VCO never modifies existing tools.
2. Additive only: New tools are added alongside existing ones.
3. Conflict-first thinking: Always identify conflicts before adding.
4. Grade-based routing: New tools should fit into S/M/L/XL grades.
5. Protocol alignment: New tools should map to analysis/think/code/review/quality-injection/orchestrate/memory/retrospective.

## Iteration Governance (迭代治理)

### Occam's Razor Principle (奥卡姆剃刀)

Every modification to VCO must pass this test:

1. **Necessity proof**: Can the goal be achieved WITHOUT this change? If yes, don't change.
2. **Minimal scope**: Change the fewest files possible. One concern per commit.
3. **Evidence-based**: Every addition must cite a concrete problem it solves or a specific user need.
4. **Removal bias**: When in doubt, remove rather than add. Complexity is the enemy.

Anti-patterns (禁止):
- Adding a protocol "just in case" without a demonstrated use case
- Adding a tool mapping without evidence it outperforms the current fallback
- Creating new files when an edit to an existing file would suffice

### User Confirmation Gate (用户确认门)

Any structural change to VCO requires explicit user approval:

1. **Propose**: Describe what will change, which files, and why
2. **Discuss**: Answer user questions, adjust based on feedback
3. **Confirm**: User explicitly approves before any file is modified
4. **Report**: After implementation, summarize what was done

Structural changes include:
- Adding/removing protocols, skills, or tool mappings
- Modifying routing rules or conflict avoidance rules
- Changing the execution flow or grade classification criteria
- Any change to SKILL.md, routing-table.md, or conflict-rules.md

Non-structural changes (no gate required):
- Fixing typos or formatting
- Updating version numbers
- Adding fallback entries for existing tools

### Change Rationale Recording (变更理由记录)

Every VCO iteration must be recorded in CHANGELOG.md with:
- Version number (semver: major.minor.patch)
- Date
- List of changes with file paths
- Rationale: WHY this change was made (the problem it solves)
- User approval reference (confirmed in session)

Version numbering:
- Patch (0.0.x): Typo fixes, formatting, fallback additions
- Minor (0.x.0): New protocol, new skill, new tool mapping
- Major (x.0.0): Architecture change, routing logic rewrite, breaking changes
