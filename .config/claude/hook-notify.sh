#!/bin/bash
# Claude Code Hook Notification Script
# Outputs JSON with terminalSequence for terminal notifications and progress indicators

set -euo pipefail

INPUT=$(cat)

EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // ""')

osc777() {
  local title="$1"
  local body="$2"
  printf '\e]777;notify;%s;%s\e\\' "$title" "$body"
}

progress_start() {
  printf '\e]9;4;3\e\\'
}

progress_end() {
  printf '\e]9;4;0\e\\'
}

bell() {
  printf '\a'
}

output_sequence() {
  local seq="$1"
  jq -n --arg s "$seq" '{"terminalSequence": $s}'
}

case "$EVENT" in
  "UserPromptSubmit")
    output_sequence "$(progress_start)"
    ;;
  "SessionEnd")
    output_sequence "$(progress_end)"
    ;;
  "Stop")
    output_sequence "$(progress_end)$(osc777 "Claude Code" "完了")$(bell)"
    ;;
  "Notification")
    TITLE=$(echo "$INPUT" | jq -r '.title // "Claude Code"')
    MESSAGE=$(echo "$INPUT" | jq -r '.message // ""')
    output_sequence "$(progress_end)$(osc777 "$TITLE" "$MESSAGE")$(bell)"
    ;;
esac

exit 0
