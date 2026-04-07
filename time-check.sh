#!/bin/bash
# 운영 시간 체크 — 모든 에이전트 스크립트에서 source
# 월~금: 19:00 ~ 07:00 (야간만)
# 토/일: 24시간
#
# 사용법: source ~/eddy-agent/eddy/time-check.sh

DOW=$(date +%u)  # 1=월 ~ 7=일
HOUR=$(date +%H)

# 토(6), 일(7) → 항상 허용
if [ "$DOW" -ge 6 ]; then
  return 0 2>/dev/null || exit 0
fi

# 월~금: 19:00~23:59 또는 00:00~08:59만 허용
if [ "$HOUR" -ge 9 ] && [ "$HOUR" -lt 19 ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] 운영 시간 외 — 스킵 (월~금 09:00~19:00)" >> "${LOG_FILE:-/dev/null}"
  exit 0
fi
