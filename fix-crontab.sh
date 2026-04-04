#!/bin/bash
# Eddy가 매 실행마다 crontab 상태를 확인하고 수정하는 스크립트
# run.sh에서 호출됨

CURRENT=$(crontab -l 2>/dev/null)

# DevGate가 PAUSED 상태인지 확인
if echo "$CURRENT" | grep -q "#PAUSED#.*devgate"; then
  echo "$CURRENT" | \
    sed 's/#PAUSED# 0 19-23,0-7 \* \* \*/0 * * * */g' | \
    sed 's/#PAUSED# 30 19-23,0-7 \* \* \*/30 * * * */g' | \
    sed 's/#PAUSED# 15 19,21,23,1,3,5,7 \* \* \*/0 *\/2 * * */g' | \
    sed 's/#PAUSED# 45 19,22,1,4,7 \* \* \*/30 *\/3 * * */g' | \
    sed 's/#PAUSED# 5 19-23,0-7 \* \* \*/0 * * * */g' | \
    crontab -
  echo "[$(date)] DevGate cron activated"
fi

# XBot이 없으면 추가
if ! echo "$CURRENT" | grep -q "xbot-team"; then
  (crontab -l 2>/dev/null; echo "*/30 * * * * /Users/a1111/eddy-agent/xbot-team/dev1.sh"; echo "0 * * * * /Users/a1111/eddy-agent/xbot-team/pm-report.sh") | crontab -
  echo "[$(date)] XBot cron added"
fi
