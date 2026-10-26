---
name: project-remote-access
description: Phone access to Ambrosio — Remote Control chosen first (2026-10-17), iMessage channel next; WhatsApp only via official Cloud API if ever
metadata:
  type: project
---

Decided 2026-10-17: the principal reaches Ambrosio from a phone through **Claude Code Remote Control** first. The official iMessage channel is the planned second step.

WhatsApp is not an official Claude Code channel. If it is ever insisted on, use only the Meta Cloud API with a dedicated number and a hard sender allowlist. Never use the unofficial bridges (Baileys and similar) on a personal number: they break the ToS, risk a number ban and expose every chat.

**Why:** Remote Control and iMessage are official, need no public webhook, and carry low risk. Meta also restricts general-purpose AI bots on the Business API.

**How to apply:**
- Still to verify: that guard-irreversible.sh blocks and asks when the session is driven from the phone.
- Remote and channel sessions need the Mac awake, so use tmux and caffeinate.
- Never use --dangerously-skip-permissions for remote use.
- Decision was taken by Eduardo as builder; re-confirm with the friend's constraints once their profile exists ([[project-build-for-friend]]).
