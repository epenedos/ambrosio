---
name: project-outlook-wiring
description: Dudu wants his PERSONAL Outlook (outlook.com) connected (2026-10-19); claude.ai M365 connector can't do personal accounts; plan: Softeria ms-365-mcp-server read-only
metadata:
  type: project
---

On 2026-10-19 Dudu asked to add his **personal** Outlook account (not Palo Alto).

Research findings (researcher, 2026-10-19):
- The claude.ai Microsoft 365 connector does **not** support personal Microsoft accounts (Entra work/school only).
- IMAP/SMTP with an app password is effectively dead for outlook.com (basic auth off since ~Sept 2024; OAuth only).
- Recommended: local MCP server `@softeria/ms-365-mcp-server`, tenant `consumers`, device-code login, started with `--read-only`. Pin the version. Alternative: `mpalermiti/outlook-mcp` (personal-only, smaller project).
- `--read-only` is a guardrail, not a scope guarantee. For a hard limit, register his own Entra app with Mail.Read and Calendars.Read only.

**Status (2026-10-19, later):** the `ms365` server is installed and connected, read-only (its own instructions confirm "write operations are disabled"). **Wired 2026-10-19** by the maintainer: `mcp__ms365` is now in the `mail` and `calendar` tools, read-only, effective after restart. The server is configured in `~/.claude.json` (ambrosio project), not in `.mcp.json`.

**Account identity (2026-10-19):** Dudu confirmed his netcabo email is accessed through the ms365 server. The netcabo mail does not appear in the soshin.ai Gmail (0 from/to hits). So netcabo questions go to ms365, not Gmail.

**2026-10-19:** the account is **epenedos@netcabo.pt** (netcabo = the Outlook account). Its token expired, so all ms365 calls fail with "Failed to acquire token… re-login with --login". Dudu will re-login on his Mac: `MS365_MCP_TENANT_ID=consumers npx -y @softeria/ms-365-mcp-server --login`. **Resolved the same day:** the mail specialist ran `mcp__ms365__login` (device code at microsoft.com/link), Dudu entered the code on his phone, and `verify-login` succeeded. If the token expires again, use that remote flow: login → Dudu enters the code → verify-login. No Mac needed. The inbox is huge (≈36.7k messages, ≈4.4k unread, mostly notifications), so triage the latest messages, never the whole inbox.

**Decision 2026-10-19: drafts only (option A), never send.** Plan:
- Drop `--read-only` and add an `--enabled-tools` allow-list with reads, the 4 `create-*-draft` tools and the login utilities. Add `--allowed-scopes 'Mail.Read Mail.ReadWrite Calendars.Read'` so Mail.Send is never granted. Pin version 0.170.2.
- The config is **local scope in ~/.claude.json** (ambrosio project), so Dudu runs the commands himself. Then re-consent, then the maintainer updates `mail.md` line 14.
- Reply, forward and reply-all send instantly and pass the hook, so they must stay out of the allow-list.
- Status: commands handed to Dudu; waiting for him to run them.

**How to apply:** After it's connected, the maintainer adds the ms365 tools to the `mail` and `calendar` specialists and extends the guard hook to Outlook send/delete *before* write mode is enabled. See [[guard-hook-gap]], [[project-mail-wiring]].
