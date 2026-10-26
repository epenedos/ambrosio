---
name: pending-maintainer-brief
description: Maintainer runs 2026-10-19 done (rename, ms365, hook ask-tier, audit); open: chmod CLAUDE.md, jarvis cleanup, connector allow-list, agent setup notes
metadata:
  type: project
---

**Done 2026-10-19**
- Renamed Jarvis → Ambrosio and replaced Master/Egidio with Dudu. Removed real estate.
- Wired ms365 read-only into `mail` and `calendar`.
- Rewrote CLAUDE.md.
- Second run (evening):
  - Hook now has an "ask" tier, covering reply/forward and calendar actions that notify attendees. See [[guard-hook-gap]].
  - Config audit is done. It fixed README, mail.md and chief-of-staff.md (maintainer routing).

**Still open (Dudu's call)**
1. Re-protect CLAUDE.md. Dudu has to run `chmod a-w CLAUDE.md` himself.
2. Clean up the stale jarvis refs outside the folder. These are by hand: trash `~/.claude/projects/-Users-eduardopenedos-Downloads-jarvis` and pop the `projects` entry from `~/.claude.json` with Claude closed. Dudu had NOT run them as of 2026-10-19 evening; I re-sent the commands.
3. Decide whether to add `mcp__claude_ai_Gmail` and `mcp__claude_ai_Google_Calendar` to the settings allow list. Unverified whether they prompt on every call.
4. The calendar.md and mail.md "Setup note" paragraphs are outdated: they assume local `calendar`/`mail` servers, but the claude.ai connectors are what actually work.
5. The hook's attendee field names were guessed. Re-test on the first real calendar edit that has guests.
6. An ask prompt cannot be answered in headless runs (`claude -p`, the scheduled brief), so there it acts as a refusal.

**Why:** the maintainer can't chmod or touch paths outside the folder. Items 3–4 are judgement calls.

**How to apply:** follow up on 1–2 once. Bring up 3–4 when Dudu next asks for maintenance. Delete this note when everything is settled.
