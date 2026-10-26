---
name: project-mail-wiring
description: Gmail connector works (verified 2026-10-16); the soshin.ai mailbox is Dudu's REAL account (confirmed 2026-10-19), mostly newsletters
metadata:
  type: project
---

Verified 2026-10-16: the mail specialist has the `mcp__claude_ai_Gmail__*` tools, and they work. The connected mailbox is the soshin.ai Google account. **Dudu confirmed on 2026-10-19 that it is his real account, not a test one** (see [[principal]]). It held ~200 unread threads, almost all newsletters and automated notifications.

His Palo Alto Networks work mailbox is **not** connected.

**Why:** Mail on this account is live. Anything sent from it reaches real people under his name.

**How to apply:** Triage it as real mail. Every triage names the account (soshin.ai) so it isn't confused with Palo Alto mail. Sends still need his explicit yes ([[project-guard-hook-gap]]: the hook doesn't block them).
