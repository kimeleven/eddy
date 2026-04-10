#!/bin/bash
# Eddy 프로세스 점검 및 정리 (매일 12:00 실행)

LOG="/Users/a1111/eddy-agent/eddy/cleanup.log"
TELEGRAM_TOKEN="${EDDY_TELEGRAM_BOT_TOKEN:-$(grep EDDY_TELEGRAM_BOT_TOKEN ~/.zshenv 2>/dev/null | cut -d= -f2)}"
CHAT_ID="5799051013"
DATE=$(date '+%Y-%m-%d %H:%M')

echo "[$DATE] === 프로세스 점검 시작 ===" >> "$LOG"

report=""
killed=""

# ── 1. 보류 팀 프로세스 감지 (devgate, eldo, biztool, liveorder, xbot, reviewbot-dev) ──
PAUSED_PATTERNS="devgate|eldo|biztool|liveorder|xbot|reviewbot-team"

while IFS= read -r line; do
  pid=$(echo "$line" | awk '{print $2}')
  cmd=$(echo "$line" | awk '{print substr($0, index($0,$11))}' | cut -c1-80)
  echo "[$DATE] 보류팀 프로세스 발견 PID $pid: $cmd" >> "$LOG"
  kill "$pid" 2>/dev/null
  killed="$killed\n• PID $pid: $cmd"
done < <(ps aux | grep -E "$PAUSED_PATTERNS" | grep -E "(claude|\.sh|next dev)" | grep -v grep)

# ── 2. 오래된 좀비 zsh (shell-snapshots, 1시간 이상) ──
while IFS= read -r line; do
  pid=$(echo "$line" | awk '{print $2}')
  elapsed=$(echo "$line" | awk '{print $10}')
  echo "[$DATE] 좀비 zsh 발견 PID $pid ($elapsed)" >> "$LOG"
  kill "$pid" 2>/dev/null
  killed="$killed\n• 좀비 zsh PID $pid"
done < <(ps aux | grep "shell-snapshots" | grep -v grep | awk '$10 !~ /^0:0[0-9]/' )

# ── 3. launchd 상태 확인 (보류팀 plist 혹시 로드됐는지) ──
PAUSED_PLISTS="devgate eldo biztool liveorder reviewbot-dev1"
for name in $PAUSED_PLISTS; do
  if launchctl list 2>/dev/null | grep -q "com.eddy.$name"; then
    echo "[$DATE] 보류팀 launchd 감지: $name — 언로드" >> "$LOG"
    launchctl unload ~/Library/LaunchAgents/com.eddy.${name}*.plist 2>/dev/null
    killed="$killed\n• launchd 언로드: $name"
  fi
done

# ── 4. 정상 프로세스 목록 기록 ──
active=$(ps aux | grep -E "(iri-safety|eddy-agent)" | grep -E "(claude|next dev)" | grep -v grep | awk '{print $2, substr($0, index($0,$11), 60)}')
echo "[$DATE] 정상 프로세스: $active" >> "$LOG"

# ── 5. 텔레그램 보고 ──
if [ -n "$killed" ]; then
  msg="🧹 [Eddy 정오 점검] 이상 프로세스 정리\n$killed"
else
  msg="✅ [Eddy 정오 점검] 이상 없음"
fi

if [ -n "$TELEGRAM_TOKEN" ]; then
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
    -H "Content-Type: application/json" \
    -d "{\"chat_id\":\"$CHAT_ID\",\"text\":\"$msg\"}" > /dev/null
fi

echo "[$DATE] 완료" >> "$LOG"
