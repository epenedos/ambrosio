#!/bin/bash
# PreToolUse hook: guards irreversible MCP tool calls. Two tiers.
#
# Tier 1, DENY (exit 2): names containing send/delete/remove/purge/pay/purchase/transfer.
#   Blocked unless Dudu has approved. Approval is one-shot: either AMBROSIO_APPROVED=1
#   in the environment, or a `.ambrosio-approve` file in the project root (created by
#   `touch .ambrosio-approve`, consumed on first use).
#
# Tier 2, ASK (exit 0 + permissionDecision "ask"): the session shows Dudu a permission
#   prompt and he approves or refuses inline. No approval file needed.
#   - reply / forward (these send immediately).
#   - calendar respond / accept / decline / cancel (notifies the organizer or attendees).
#   - calendar create / update / patch / move ONLY when the call carries attendees or
#     sends updates; edits to Dudu's own attendee-less events pass untouched.
#   Anything with "draft" in its name is never asked about (drafting is the safe path).
#   Note: in headless runs (claude -p, e.g. the daily brief) an ask cannot be answered,
#   so it behaves as a refusal.

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')
[ -z "$TOOL" ] && exit 0

# Tier 1: hard block.
if echo "$TOOL" | grep -iqE 'send|delete|remove|purge|pay|purchase|transfer'; then
  APPROVE_FILE="${CLAUDE_PROJECT_DIR:-.}/.ambrosio-approve"
  if [ "${AMBROSIO_APPROVED:-0}" = "1" ]; then
    exit 0
  fi
  if [ -f "$APPROVE_FILE" ]; then
    rm -f "$APPROVE_FILE"
    exit 0
  fi
  echo "Blocked: '$TOOL' is irreversible. Describe exactly what would happen and ask Dudu for approval. Once he approves, the call can be retried." >&2
  exit 2
fi

ask() {
  jq -n --arg reason "$1" '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "ask", permissionDecisionReason: $reason}}'
  exit 0
}

# Drafting is always allowed.
echo "$TOOL" | grep -iq 'draft' && exit 0

# Tier 2a: reply / forward go out immediately.
if echo "$TOOL" | grep -iqE 'reply|forward'; then
  ask "'$TOOL' sends a message immediately and cannot be recalled. Confirm with Dudu: recipients and text."
fi

# Tier 2b: calendar actions that notify other people.
if echo "$TOOL" | grep -iqE 'event|calendar'; then
  if echo "$TOOL" | grep -iqE 'respond|accept|decline|tentative|cancel|rsvp'; then
    ask "'$TOOL' notifies the organizer or attendees. Confirm with Dudu."
  fi
  if echo "$TOOL" | grep -iqE 'create|insert|update|patch|move|quick|add'; then
    NOTIFIES=$(echo "$INPUT" | jq -r '
      (.tool_input // {}) as $i
      | if (([$i.attendees, $i.guests, $i.attendeeEmails, $i.attendee_emails, $i.body.attendees]
             | map(select(. != null and . != [] and . != "")) | length) > 0)
           or (($i.sendUpdates // $i.send_updates // $i.sendNotifications // "") | tostring | test("all|externalOnly|true"; "i"))
        then "yes" else "no" end' 2>/dev/null)
    if [ "$NOTIFIES" = "yes" ]; then
      ask "'$TOOL' touches an event with attendees or sends updates, so other people get notified. Confirm with Dudu."
    fi
  fi
fi

exit 0
