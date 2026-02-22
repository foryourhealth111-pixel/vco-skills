#!/usr/bin/env bash
set -euo pipefail

# VCO Codex Exec — Delegate tasks to OpenAI Codex from Claude Code
# Usage: bash codex-exec.sh [OPTIONS] "task description"
#
# Options:
#   --model MODEL       Override Codex model (default: from config.toml)
#   --sandbox MODE      Sandbox mode: read-only|workspace-write|danger-full-access
#   --dir DIR           Working directory for Codex
#   --output FILE       Write Codex's final message to file (default: stdout)
#   --schema FILE       JSON Schema for structured output
#   --timeout SECONDS   Max execution time (default: 300)
#   --review            Run code review instead of exec

MODE="exec"
MODEL=""
SANDBOX="workspace-write"
DIR="."
OUTPUT=""
SCHEMA=""
TIMEOUT=300
PROMPT=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --model) MODEL="$2"; shift 2 ;;
    --sandbox) SANDBOX="$2"; shift 2 ;;
    --dir) DIR="$2"; shift 2 ;;
    --output) OUTPUT="$2"; shift 2 ;;
    --schema) SCHEMA="$2"; shift 2 ;;
    --timeout) TIMEOUT="$2"; shift 2 ;;
    --review) MODE="review"; shift ;;
    --help) echo "Usage: bash codex-exec.sh [OPTIONS] \"task\""; exit 0 ;;
    *) PROMPT="$1"; shift ;;
  esac
done

if [ -z "$PROMPT" ] && [ "$MODE" != "review" ]; then
  echo "Error: No prompt provided" >&2
  exit 1
fi

# Build command
CMD=(codex)

if [ "$MODE" = "review" ]; then
  CMD+=(review --uncommitted)
  [ -n "$PROMPT" ] && CMD+=("$PROMPT")
else
  CMD+=(exec)
  CMD+=(--full-auto)
  CMD+=(-s "$SANDBOX")
  CMD+=(-C "$DIR")
  [ -n "$MODEL" ] && CMD+=(-m "$MODEL")
  [ -n "$SCHEMA" ] && CMD+=(--output-schema "$SCHEMA")

  RESULT_FILE="${OUTPUT:-$(mktemp /tmp/codex-result-XXXXXX.txt)}"
  CMD+=(-o "$RESULT_FILE")
  CMD+=("$PROMPT")
fi

# Execute with timeout
echo "[VCO-Codex] Running: ${CMD[*]}" >&2
if timeout "$TIMEOUT" "${CMD[@]}" 2>&1; then
  EXIT_CODE=0
else
  EXIT_CODE=$?
  echo "[VCO-Codex] Codex exited with code $EXIT_CODE" >&2
fi

# Output result
if [ "$MODE" != "review" ] && [ -f "$RESULT_FILE" ]; then
  echo "--- Codex Result ---"
  cat "$RESULT_FILE"
  [ -z "$OUTPUT" ] && rm -f "$RESULT_FILE"
fi

exit ${EXIT_CODE:-0}
