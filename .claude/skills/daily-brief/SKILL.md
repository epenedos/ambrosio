---
name: daily-brief
description: Morning brief — today's calendar, overnight inbox triage and news on standing interests. Run with /daily-brief, or let the chief of staff run it each morning.
argument-hint: [date, default today]
---

Produce the daily brief for $ARGUMENTS (default: today, Europe/Lisbon).

Delegate these three briefs in parallel, then synthesize:

- **calendar** — today's events in order, conflicts, anything that needs prep (docs to read, people to look up).
- **mail** — overnight triage across Gmail (soshin.ai) and Outlook (netcabo): urgent and needs-reply only, one line each with sender and ask. Skip FYI and noise.
- **researcher** — ask for Radar mode: up to three identity-security items relevant to Dudu's Idira sales (human, machine and agentic-AI identity; competitors; target accounts; regulation), plus anything on the standing interests listed in MEMORY.md. Headline, one line of why it matters to Idira sales, link.

Output format, European Portuguese, one phone screen:

```
# Brief — <data>

## Prioridades de hoje
1. …  (máx. 3; o que o Dudu tem mesmo de fazer hoje)

## Agenda
HH:MM  Título — quem / onde

## Email — precisa de resposta
- Remetente: pedido

## Radar
- …
```

End with one line of open decisions, if any. Nothing else.
