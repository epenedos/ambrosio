---
name: guard-hook-design
description: How guard-irreversible.sh is structured (deny tier vs ask tier) and why; reuse when new MCP write tools are added
metadata:
  type: project
---

Hook has two tiers (set 2026-10-19). Tier 1 deny (exit 2, one-shot approval file or AMBROSIO_APPROVED): send/delete/remove/purge/pay/purchase/transfer. Tier 2 ask (exit 0 plus JSON permissionDecision "ask"): reply/forward; calendar respond/accept/decline/cancel; calendar create/update/move only when tool_input has attendees or sendUpdates. Names containing "draft" are never asked about.

**Why:** deny can't be approved inline (specialists don't retry on relayed approval); ask lets Dudu approve in-session. Headless runs (claude -p) cannot answer an ask, so it acts as a refusal.

**How to apply:** when new MCP write tools appear (e.g. ms365 drafts-only allow-list), check their names against both tiers and re-run the sample-payload tests. Attendee field names are guessed (attendees, guests, body.attendees); verify against the real connector schema if a notifying edit slips through.
