---
name: guard-hook-gap
description: guard-irreversible hook did NOT block a Gmail MCP send on 2026-10-17 — approval discipline is the only safeguard for MCP sends
metadata:
  type: project
---

On 2026-10-17, the mail specialist sent a reply through the claude.ai Gmail connector (`reply` tool), and `guard-irreversible.sh` did not intercept it. The send was approved, so nothing went wrong. But it shows the hook doesn't cover claude.ai connector tools (or at least not this one).

On 2026-10-19, the hook **did** block a Google Calendar MCP event delete from the calendar specialist, even though Dudu had approved it. A specialist won't retry on approval relayed through me. So coverage is inconsistent: calendar delete is covered, Gmail reply wasn't.

Root cause (maintainer, 2026-10-19): the hook matches every `mcp__.*` tool but only blocks names containing `send|delete|remove|purge|pay|purchase|transfer`. The Gmail `reply` tool doesn't match. Outlook has the same gap: `reply-mail-message`, `forward-mail-message`, `create-draft-email`, `move-*`, `update-*` and `create-calendar-event` aren't covered. Right now ms365's `--read-only` flag is the real barrier. The approval token file was renamed to `.ambrosio-approve`.

**Update 2026-10-19 (maintainer):** gap closed. The hook now has an ask tier for reply/forward and for calendar respond/cancel and attendee-notifying create/update/move; drafts stay unguarded. Tested by piping payloads. Needs a session restart to load.

**Why (original):** CLAUDE.md claims the hook enforces approval "regardless of prompt". For MCP sends that claim is false today.

**How to apply:** never brief a specialist to send without the principal's explicit yes. Recommend the builder extend the hook matcher to `mcp__claude_ai_Gmail__*` send/reply and to any future ms365 write tools. Related: [[remote-access]] (hook test pending).
