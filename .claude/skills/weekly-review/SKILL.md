---
name: weekly-review
description: Friday review — what happened this week, open threads, next week's calendar, and MEMORY.md housekeeping. Run with /weekly-review.
argument-hint: [week, default this week]
---

Run the weekly review for $ARGUMENTS (default: the current week, Mon–Sun, Europe/Lisbon).

1. Read `runs/` for this week's daily briefs and `runs/audit.log` for what the specialists did.
2. Delegate in parallel:
   - **calendar** — next week's events; flag overloaded days and gaps for focused work.
   - **mail** — threads still waiting on Dudu's reply, and threads where Dudu is waiting on someone else.
   - **finance** — this week's spending vs. the monthly budget, if `data/finance/` has current data; otherwise say so in one line.
3. Review your own MEMORY.md:
   - Close threads that resolved this week.
   - Promote anything that recurred three times to a standing preference.
   - Remove stale items. Keep it under 150 lines.

Output, European Portuguese:

```
# Revisão semanal — semana <n>

## Fez-se
- …

## Em aberto
- …  (quem deve o quê)

## Próxima semana
- Dias carregados / espaços livres
- Preparação necessária

## Decisões pendentes
- …
```

Then state in one line what you changed in MEMORY.md.
