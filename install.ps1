# VCO Ecosystem Installer (PowerShell)
# Usage: .\install.ps1 [-SkipPlugins] [-SkipSuperClaude] [-SkipClaudeFlow]

param(
    [switch]$SkipPlugins,
    [switch]$SkipSuperClaude,
    [switch]$SkipClaudeFlow
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"

Write-Host "=== VCO Ecosystem Installer ===" -ForegroundColor Cyan
Write-Host "Target: $ClaudeDir"
Write-Host ""

# 1. Create directories
Write-Host "[1/7] Creating directories..."
@("rules\common", "rules\typescript", "skills\vibe", "hooks", "commands") | ForEach-Object {
    New-Item -ItemType Directory -Path (Join-Path $ClaudeDir $_) -Force | Out-Null
}

# 2. Copy rules
Write-Host "[2/7] Installing rules..."
Copy-Item "$ScriptDir\rules\common\*" (Join-Path $ClaudeDir "rules\common\") -Force
Copy-Item "$ScriptDir\rules\typescript\*" (Join-Path $ClaudeDir "rules\typescript\") -Force

# 3. Copy VCO skill
Write-Host "[3/7] Installing VCO skill..."
Copy-Item "$ScriptDir\skills\vibe" (Join-Path $ClaudeDir "skills\vibe") -Recurse -Force

# 4. Copy hooks
Write-Host "[4/7] Installing hooks..."
Copy-Item "$ScriptDir\hooks\write-guard.js" (Join-Path $ClaudeDir "hooks\") -Force
Copy-Item "$ScriptDir\hooks\hookify-configs\auto-plugin-discovery.local.md" (Join-Path $ClaudeDir "hookify.auto-plugin-discovery.local.md") -Force
Copy-Item "$ScriptDir\hooks\hookify-configs\prevent-large-file-write.local.md" (Join-Path $ClaudeDir "hookify.prevent-large-file-write.local.md") -Force

# 5. Settings
Write-Host "[5/7] Checking settings..."
$settingsPath = Join-Path $ClaudeDir "settings.json"
if (Test-Path $settingsPath) {
    Write-Host "  settings.json exists - skipping (see config\settings.template.json)"
} else {
    Copy-Item "$ScriptDir\config\settings.template.json" $settingsPath
    Write-Host "  Created settings.json - EDIT IT to add your API key" -ForegroundColor Yellow
}

# 6. SuperClaude
if (-not $SkipSuperClaude) {
    Write-Host "[6/7] Installing SuperClaude commands..."
    $scDir = Join-Path $ClaudeDir "commands\sc"
    if (Test-Path $scDir) { Remove-Item $scDir -Recurse -Force }
    $tempDir = Join-Path $env:TEMP "superclaude-$(Get-Random)"
    git clone --depth 1 https://github.com/SuperClaude-Org/SuperClaude_Framework.git $tempDir 2>$null
    if (Test-Path "$tempDir\commands\sc") {
        Copy-Item "$tempDir\commands\sc" $scDir -Recurse
    } elseif (Test-Path "$tempDir\sc") {
        Copy-Item "$tempDir\sc" $scDir -Recurse
    }
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "[6/7] Skipping SuperClaude"
}

# 7. Plugins
if (-not $SkipPlugins) {
    Write-Host "[7/7] Installing plugins..."
    $plugins = @(
        "hookify@claude-plugins-official",
        "claude-code-settings@claude-code-settings",
        "everything-claude-code@everything-claude-code",
        "ralph-loop@claude-plugins-official",
        "superpowers@superpowers-marketplace",
        "episodic-memory@superpowers-marketplace",
        "context7@claude-plugins-official",
        "serena@claude-plugins-official",
        "github@claude-plugins-official",
        "elements-of-style@superpowers-marketplace"
    )
    foreach ($p in $plugins) {
        Write-Host "  Installing $p..."
        try { claude plugins install $p 2>$null } catch { Write-Host "  Warning: failed to install $p" -ForegroundColor Yellow }
    }
} else {
    Write-Host "[7/7] Skipping plugins"
}

# claude-flow
if (-not $SkipClaudeFlow) {
    Write-Host "  Installing claude-flow..."
    try { npm install -g claude-flow 2>$null } catch { Write-Host "  npm not found - install claude-flow manually" -ForegroundColor Yellow }
}

Write-Host ""
Write-Host "=== Installation Complete ===" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Edit ~/.claude/settings.json - add your ANTHROPIC_AUTH_TOKEN"
Write-Host "  2. Start a new Claude Code session"
Write-Host "  3. Type: /vibe Hello, verify VCO is working"
