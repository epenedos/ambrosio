---
name: project-icloud-wiring
description: Dudu wants iCloud mail + contacts connected (2026-10-19); no claude.ai connector; candidate eodozzy/icloud-mcp read-only, immature; pending code review/decision
metadata:
  type: project
---

On 2026-10-19 Dudu asked to connect his iCloud **mail and contacts**.

Researcher findings, 2026-10-19:
- There is no claude.ai iCloud connector.
- iCloud uses IMAP (imap.mail.me.com:993) with an app-specific password, which needs 2FA. Contacts use CardDAV, which isn't confirmed by Apple docs. One report from Sep 2026 shows 401 errors on CardDAV with app passwords.
- An app-specific password has **no read-only scope**: it covers IMAP, SMTP, CalDAV and CardDAV. Read-only is enforced only by the MCP server's code.
- Best candidate: `eodozzy/icloud-mcp`. It's Python (uvx), covers IMAP + CardDAV + CalDAV, is read-only by default (writes need `ICLOUD_ENABLE_WRITES=1`), and keeps the password in the macOS Keychain. It's immature: 1 star, no releases, and has no draft tool.
- Drafts option: `florianbuetow/imap-mini-mcp`. It can't send, but it keeps the password in plaintext env and can move and flag mail.
- Avoid `supermemoryai/apple-mcp`: it's archived, can send, and isn't pinned.

**Status:** options presented. Recommended a code review by the researcher first, then a pinned, read-only install with a dedicated app password. Waiting on Dudu.

**How to apply:** Never store the app password in memory or config files in this folder. After install, wire into `mail` (plus a contacts note) via the maintainer, and make sure the hook/allow-list covers any write tools. See [[project-outlook-wiring]], [[guard-hook-gap]].
