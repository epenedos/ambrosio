# Ambrosio

A chief-of-staff agent that runs five specialists (researcher, calendar, mail, finance, maintainer). Built on Claude Code's subagent system, so the same folder works interactively, headless on a schedule, and through the Agent SDK.

## Layout

```
ambrosio/
├── CLAUDE.md                   # operating manual every agent reads
├── .mcp.json                   # MCP servers (empty; add calendar, mail…)
├── .env.example                # secrets .mcp.json expects in the environment
├── .claude/
│   ├── settings.json           # runs as chief-of-staff, permissions, hooks
│   ├── agents/                 # chief-of-staff + researcher, calendar, mail, finance, maintainer
│   ├── skills/                 # /daily-brief, /weekly-review
│   ├── rules/                  # privacy.md, tone.md
│   ├── hooks/                  # guard-irreversible.sh, audit-log.sh
│   └── agent-memory/           # auto-created: one MEMORY.md per agent
├── scripts/                    # daily-brief.sh + launchd plist
├── runs/                       # briefs and audit.log (gitignored)
└── data/finance/               # CSV/XLSX exports for the finance agent (gitignored)
```

## First run

```bash
cd ambrosio
claude remote-control --name Ambrosio
```

`settings.json` sets `"agent": "chief-of-staff"`, so every session here *is* the chief of staff. Before any MCP server is connected only `researcher` and `finance` are fully functional; try:

```
Compara os três melhores padel rackets de 2026 abaixo de 250 €.
```

It delegates to `researcher` and gives you one answer with sources.

## Adding the calendar and mail servers

`.mcp.json` ships empty. Add whatever servers you prefer under the names the agents expect:

```bash
claude mcp add --scope project calendar <command-or-url>
claude mcp add --scope project mail <command-or-url>
```

The agents restrict themselves with `tools: Read, mcp__calendar` / `mcp__mail`, so they pick up the server's tools as soon as the name matches. Until then they only have `Read` and will say so. Secrets go in the environment and are referenced from `.mcp.json` as `${VAR}`; see `.env.example`.

## How approval works

CLAUDE.md tells agents to stop before anything irreversible. `hooks/guard-irreversible.sh` enforces it in two tiers. Any MCP tool whose name contains send / delete / remove / purge / pay / purchase / transfer is blocked with exit code 2 and the agent is told to ask you. Reply, forward, calendar respond/cancel, and calendar create/update/move on events with attendees trigger an inline permission prompt instead. Drafts and reads are never guarded.

To approve one blocked (tier 1) action, either run the session with `AMBROSIO_APPROVED=1`, or `touch .ambrosio-approve` in the project root — the file is consumed on first use, so it approves exactly one call.

`hooks/audit-log.sh` appends one line per specialist run to `runs/audit.log`.

## Scheduling

- **Manual:** `/daily-brief`, `/weekly-review` inside a session.
- **Headless on the Mac Mini:** `scripts/daily-brief.sh` runs `claude -p --agent chief-of-staff` and writes `runs/brief-YYYY-MM-DD.md`. `scripts/com.ambrosio.daily-brief.plist` schedules it at 07:30 with launchd — edit the paths, copy to `~/Library/LaunchAgents/`, `launchctl load`. Any MCP server that needs an OAuth login must be logged in once (`claude mcp login <name>`) as the same macOS user.
- **Cloud:** Claude Code Routines can run the same prompt on a schedule if you'd rather not depend on the Mac being awake.

Headless runs use `--permission-mode dontAsk`, so only tools listed in `permissions.allow` work there. `mcp__mail` is allowed, but sending is still caught by the hook.

## Adding a specialist

1. Create `.claude/agents/<name>.md` with `name`, `description`, the narrowest `tools` list that does the job, `model: sonnet` (or `haiku`), `memory: project`.
2. Add `<name>` to the chief of staff's `tools: Agent(…)` allowlist and to its routing table.
3. If it needs an MCP server, reference it by name in `mcpServers:` and restrict `tools` to `mcp__<server>`.

## Notes

- The chief of staff has no Bash, Write or web tools — only `Agent(…)` and `Read` (plus the memory files). That's what keeps it a manager.
- Subagents nest two levels here (`CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH=2`), so a specialist can spin a helper but not a tree.
- The `finance` agent has Bash for Python; keep its inputs to files you've exported yourself.
- Agent memory lives in `.claude/agent-memory/<name>/MEMORY.md`. Edit it by hand whenever an agent remembers something wrong.
# ambrosio
