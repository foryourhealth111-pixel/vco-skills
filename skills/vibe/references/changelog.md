# VCO Changelog


## v2.2.0 (2026-02-23)

### Added
- `codex exec resume` multi-turn collaboration mode: Claude Code can now have stateful multi-turn conversations with Codex via `codex exec resume <thread_id> "prompt"`
- New Codex routing table entry: Multi-turn tasks → `codex exec` + `codex exec resume`
- Example 6: Multi-turn Codex collaboration workflow
- `exec resume` key flags table in tool-registry.md
- Codex verification log with test results (exec ✅, exec resume ✅, review ✅, mcp-server ⚠️)
- MCP service verification timestamps: episodic-memory ✅, ruflo ✅, context7 ✅, GitHub ✅

### Changed
- Codex exec/review verification status upgraded from ⚠️ to ✅ (tested 2026-02-23)
- tool-registry.md header: "6 integrated tools" → "7 integrated tools"
- exec `--json` flag description updated: "includes thread_id for resume"

## v2.1.1 (2026-02-23)

### Fixed
- `codex review` documentation: `--uncommitted`/`--base`/`--commit` flags are mutually exclusive with `[PROMPT]` argument. Previously showed `codex review --uncommitted "prompt"` which errors at runtime.
- Cleaned up corrupted changelog entry (sed artifact from v2.1.0 push)

## v2.1.0 (2026-02-23)

### Added
- OpenAI Codex cross-model integration (Tool #7)
- Three interaction modes: MCP server, exec delegation, dual-model review
- codex/ directory: exec wrapper script, MCP config, Codex config template, AGENTS.md template
- Codex routing table in SKILL.md Section 2
- Codex integration section in SKILL.md (MCP, exec, review, cross-tool instructions)
- Tool registry entry for Codex with all CLI flags documented
- Examples 4-5: cross-model review and Codex task delegation
- install.sh: Codex detection and config setup

## v2.0.6 (2026-02-22)

- C1 修复 conflict-rules.md Rule 1 与 Tool Selection 矩阵矛盾——M 级从"Everything-CC agents"改为"single-agent tools（允许 sc:design/systematic-debugging 等 skill commands，禁止 subagent spawning）"
- C2 修复 L 级 Dialectic Mode 使用只读 Plan agent 的问题——改为 general-purpose agent
- C3 在 SKILL.md Section 2 Tool Selection 矩阵下方添加 Excluded tools 说明（sc:implement 禁令）

## v2.0.5 (2026-02-22)

- Quick Probe 补充中文关键词（设计/架构/重构/迁移/前后端/并行/多智能体）
- index.md 模板数量 5→6
- do.md 术语 "Fallback exception" → "Fallback provision" 与 conflict-rules.md 统一
- retro.md Phase 2 各步骤补充显式 fallback 路径

## v2.0.4 (2026-02-22)

- 新增 dialectic-design 到 specialized agents 列表
- M 级补充 Behavioral Tone 引用
- team-templates 更新为 6 模板
- team.md 新增 Dialectic Mode 完整章节

## v2.0.3 (2026-02-22)

- M 级 stage sequence 移至概览行
- scope check 改为定性+定量 OR 条件
- conflict-rules.md 补充 fallback provision
- 补充探测失败默认行为
- low-friction rule 补充分类反馈格式
- Grade Definitions 增加 Key Signal 列和冲突裁决规则

## v2.0.2 (2026-02-22)

- 修复 do.md L 级 fallback exception 与 conflict rule 的矛盾
- P3/V1 补充内联定义
- team.md 补充 ToolSearch 前置步骤
- SKILL.md M 级补充阶段顺序和影响范围超预期暂停规则

## v2.0.1 (2026-02-22)

- S grade removed (implicit), 4→3 grades, 8→5 protocols, 6→3 conflict rules
- Quick probe + user decision gate added
- Team templates added
