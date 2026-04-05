#!/bin/bash
# Claude Code Hook Notification Script
# Reads JSON from stdin and handles notifications/progress based on hook_event_name

set -euo pipefail

INPUT=$(cat)

# Extract event type from hook input
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // ""')

send_osc777() {
  local title="$1"
  local body="$2"
  printf '\e]777;notify;%s;%s\e\\' "$title" "$body" > /dev/tty
}

send_progress() {
  local state="$1"  # "start" or "end"
  if [ "$state" = "start" ]; then
    printf '\e]9;4;3\e\\' > /dev/tty  # Indeterminate progress
  else
    printf '\e]9;4;0\e\\' > /dev/tty  # Clear progress
  fi
}

case "$EVENT" in
  "UserPromptSubmit")
    # permission_modeがaskの場合は進行中表示を開始しない（ユーザー入力待ち）
    send_progress "start"
    ;;
  "SessionEnd")
    send_progress "end"
    ;;
  "Stop")
    send_progress "end"
    send_osc777 "Claude Code" "完了"
    ;;
  "Notification")
    # 通知が来た = ユーザーの注意が必要な状態
    # 進行中表示を終了
    send_progress "end"

    TITLE=$(echo "$INPUT" | jq -r '.title // "Claude Code"')
    MESSAGE=$(echo "$INPUT" | jq -r '.message // ""')
    send_osc777 "$TITLE" "$MESSAGE"
    ;;
  *)
    # Unknown event, ignore silently
    ;;
esac

exit 0
