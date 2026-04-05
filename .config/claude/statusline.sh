#!/bin/bash
# Claude Code StatusLine Script
# Minimal Single-Line Design

# Read JSON input
input=$(cat)

# Extract basic info
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Extract rate limits
r5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
r5h_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
r7d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
r7d_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Get directory and git info via starship modules
dir_info=$(cd "$cwd" 2>/dev/null && starship module directory 2>/dev/null | tr -d '\n' || echo "${cwd/#$HOME/~}")
git_info=$(cd "$cwd" 2>/dev/null && echo "$(starship module git_branch 2>/dev/null)$(starship module git_state 2>/dev/null)$(starship module git_status 2>/dev/null)" | tr -d '\n' || echo '')

# Format reset times
r5h_time=$([ -n "$r5h_at" ] && date -r "$r5h_at" +"%H:%M" 2>/dev/null || echo '')
r7d_date=$([ -n "$r7d_at" ] && date -r "$r7d_at" +"%b %d" 2>/dev/null || echo '')

# Build rate info string
rate_info=''
[ -n "$r5h" ] && rate_info="5h: ${r5h%.*}%${r5h_time:+ ($r5h_time)}"
[ -n "$r7d" ] && rate_info="${rate_info}${rate_info:+ | }7d: ${r7d%.*}%${r7d_date:+ ($r7d_date)}"

# Output formatted statusline
# Format: Model | ~/dir  git_info | Ctx: 45% | 5h: 12% (14:30) | 7d: 5% (Mar 28)
printf '\033[1;35m%s\033[0m | %s %s%s%s' \
  "$model" \
  "$dir_info" \
  "$git_info" \
  "${ctx:+ | Ctx: ${ctx%.*}%}" \
  "${rate_info:+ | $rate_info}"
