#!/bin/bash
# SubagentStop hook: one line per specialist run, so you can see who did what.

INPUT=$(cat)
ROOT="${CLAUDE_PROJECT_DIR:-.}"
mkdir -p "$ROOT/runs"
printf '%s %s\n' "$(date -u +%FT%TZ)" \
  "$(echo "$INPUT" | jq -c '{agent: .agent_type, session: .session_id}')" \
  >> "$ROOT/runs/audit.log"
exit 0
