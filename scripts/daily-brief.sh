#!/bin/bash
# Headless morning run. Writes the brief to runs/brief-YYYY-MM-DD.md.
# Any secrets your MCP servers need must be in the environment.
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p runs

claude -p \
  --agent chief-of-staff \
  --permission-mode dontAsk \
  "Use the daily-brief skill for today. Return only the brief." \
  > "runs/brief-$(date +%F).md"
