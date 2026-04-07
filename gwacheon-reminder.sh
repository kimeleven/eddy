#!/bin/bash
# 과천사무실 지원 마감 리마인더 (오후 11시까지)

TOKEN="$EDDY_TELEGRAM_BOT_TOKEN"
CHAT_ID="${EDDY_TELEGRAM_CHAT_ID:-5799051013}"

# KST 기준 현재 날짜/시간
NOW_DATE=$(TZ=Asia/Seoul date +%Y-%m-%d)
NOW_HOUR=$(TZ=Asia/Seoul date +%H | sed 's/^0//')
TARGET_DATE="2026-04-08"

# 오늘(04-08)이 아니면 스킵
if [ "$NOW_DATE" != "$TARGET_DATE" ]; then
  exit 0
fi

# 오후 11시(23시) 이후면 스킵
if [ "$NOW_HOUR" -ge 23 ]; then
  exit 0
fi

# 남은 시간 계산
REMAINING=$((23 - NOW_HOUR))

MSG="⏰ *리마인더*: 과천사무실 지원 마감까지 약 ${REMAINING}시간 남았습니다! (오늘 오후 11시까지)"

curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
  -H "Content-Type: application/json" \
  -d "{\"chat_id\": \"${CHAT_ID}\", \"text\": \"${MSG}\", \"parse_mode\": \"Markdown\"}" > /dev/null
