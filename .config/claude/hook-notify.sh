#!/bin/bash
# Claude Code Hook Notification Script
# Outputs JSON with terminalSequence for terminal notifications

set -euo pipefail

INPUT=$(cat)

EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // ""')

osc777() {
  local title="$1"
  local body="$2"
  printf '\e]777;notify;%s;%s\e\\' "$title" "$body"
}

bell() {
  printf '\a'
}

output_sequence() {
  local seq="$1"
  jq -n --arg s "$seq" '{"terminalSequence": $s}'
}

case "$EVENT" in
  "Stop")
    output_sequence "$(osc777 "Claude Code" "完了")$(bell)"
    ;;
  "Notification")
    TITLE=$(echo "$INPUT" | jq -r '.title // "Claude Code"')
    MESSAGE=$(echo "$INPUT" | jq -r '.message // ""')
    output_sequence "$(osc777 "$TITLE" "$MESSAGE")$(bell)"
    ;;
esac

exit 0
