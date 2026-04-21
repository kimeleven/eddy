#!/bin/bash
# Eddy 주간 보고서 — 매주 일요일 23:59 실행
# 팀별 개별 PDF 생성 → 텔레그램 전송

if [ -f "$HOME/.eddy_env" ]; then
  source "$HOME/.eddy_env"
fi


EDDY_DIR="$HOME/eddy-agent/eddy"
LOG_FILE="$EDDY_DIR/weekly-report.log"
CLAUDE="/usr/local/bin/claude"
TELEGRAM_BOT_TOKEN="${EDDY_TELEGRAM_BOT_TOKEN}"
TELEGRAM_CHAT_ID="${EDDY_TELEGRAM_CHAT_ID:-5799051013}"
REPORT_DATE=$(date '+%Y-%m-%d')
REPORT_DIR="$EDDY_DIR/reports"

# 중복 실행 방지
LOCKFILE="/tmp/eddy-weekly.lock"
if [ -f "$LOCKFILE" ]; then
  LOCK_PID=$(cat "$LOCKFILE")
  if kill -0 "$LOCK_PID" 2>/dev/null; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 주간보고 스킵 — 이전 실행 중" >> "$LOG_FILE"
    exit 0
  fi
  rm -f "$LOCKFILE"
fi
echo $$ > "$LOCKFILE"
trap "rm -f $LOCKFILE" EXIT

mkdir -p "$REPORT_DIR"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] 주간보고 생성 시작" >> "$LOG_FILE"

$CLAUDE --model sonnet --dangerously-skip-permissions -p "
You are Eddy. 매주 일요일 주간 보고서를 **팀별 개별 PDF**로 생성하여 텔레그램 전송.

## 목적
Sanghun에게 각 프로젝트의 **변경 이력**을 상세히 정리. 변경 이력 확인이 주 목적이므로 커밋 내역을 상세히.

## 대상 팀 (전체 — activity 있는 팀만 PDF 생성)
| 팀 | 프로젝트 디렉토리 | 팀 파일 | 상태 |
|----|-------------------|---------|------|
| ELDO | ~/eddy-agent/eldo | ~/eddy-agent/eldo-team/ | Active |
| ReviewBot | ~/eddy-agent/reviewbot | ~/eddy-agent/reviewbot-team/ | Active |
| DevGate | ~/eddy-agent/devgate | ~/eddy-agent/devgate-team/ | Active |
| XBot | ~/eddy-agent/xbot | ~/eddy-agent/xbot-team/ | Paused |
| IRI-Safety | ~/eddy-agent/iri-safety | ~/eddy-agent/iri-safety-team/ | Active |
| LiveOrder | ~/eddy-agent/liveorder | ~/eddy-agent/liveorder-team/ | 종료 |
| Eddy | ~/eddy-agent/eddy | — | PM |

**규칙: 운영 중이든 종료됐든 상관없이, 지난 1주간 git 커밋이 1건이라도 있으면 해당 팀 PDF 생성하여 전송. 커밋 0건이면 스킵 (PDF 안 만듦).**

## 각 팀별 작업 순서

### 0단계: activity 확인
각 프로젝트 디렉토리에서 지난 7일간 커밋 수 확인:
\`\`\`bash
cd ~/eddy-agent/{project} && git log --since='7 days ago' --oneline --no-merges | wc -l
\`\`\`
**0건이면 해당 팀 스킵.** 1건 이상이면 아래 1~4단계 진행.

### 1단계: 데이터 수집
\`\`\`bash
cd ~/eddy-agent/{project}
# 전체 커밋 이력 (프로젝트 시작~현재)
git log --oneline --no-merges --reverse
# 이번 주 상세 커밋
git log --since='7 days ago' --no-merges --format='%h|%ad|%s' --date=short
# 총 커밋 수
git log --oneline --no-merges | wc -l
# 첫 커밋 날짜
git log --reverse --format='%ad' --date=short | head -1
\`\`\`
- TASKS.md 읽기
- PLAN.md 읽기 (있으면)
- QA_REPORT.md 읽기 (있으면)

### 2단계: HTML 생성
파일: ${REPORT_DIR}/{team}-${REPORT_DATE}.html

\`\`\`html
<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='UTF-8'>
<title>{팀명} 주간 보고서 — ${REPORT_DATE}</title>
<style>
  body { font-family: 'Apple SD Gothic Neo', -apple-system, sans-serif; max-width: 800px; margin: 0 auto; padding: 40px 20px; color: #1a1a1a; line-height: 1.6; }
  h1 { border-bottom: 3px solid #2563eb; padding-bottom: 10px; font-size: 24px; }
  h2 { color: #2563eb; margin-top: 36px; border-left: 4px solid #2563eb; padding-left: 12px; font-size: 18px; }
  h3 { color: #374151; margin-top: 20px; font-size: 15px; }
  .meta { color: #6b7280; font-size: 13px; margin-bottom: 24px; }
  .summary { background: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; padding: 16px; margin: 16px 0; }
  .summary td { font-size: 14px; }
  table { width: 100%; border-collapse: collapse; margin: 12px 0; font-size: 13px; }
  th, td { border: 1px solid #e5e7eb; padding: 6px 10px; text-align: left; }
  th { background: #f3f4f6; font-weight: 600; }
  .commit-hash { font-family: monospace; color: #6b7280; font-size: 12px; }
  .date-group { background: #f9fafb; font-weight: 600; color: #374151; }
  .done { color: #16a34a; }
  .progress { color: #2563eb; }
  .todo { color: #9ca3af; }
  hr { border: none; border-top: 1px solid #e5e7eb; margin: 30px 0; }
  @media print { body { padding: 15px; } h1 { font-size: 20px; } }
</style>
</head>
<body>
<h1>📊 {팀명} 주간 보고서</h1>
<p class='meta'>보고일: ${REPORT_DATE} | 작성: Eddy PM</p>

<div class='summary'>
<table>
<tr><td><b>프로젝트</b></td><td>{프로젝트 한 줄 설명}</td></tr>
<tr><td><b>시작일</b></td><td>{첫 커밋 날짜}</td></tr>
<tr><td><b>전체 커밋</b></td><td>{총 커밋 수}건</td></tr>
<tr><td><b>이번 주 커밋</b></td><td>{이번 주 커밋 수}건</td></tr>
<tr><td><b>현재 상태</b></td><td>{한 줄 요약}</td></tr>
</table>
</div>

<h2>1. 프로젝트 시작~현재 전체 변경 이력</h2>
<p>주요 마일스톤/Phase별로 그룹핑하여 정리:</p>
<!-- Phase별 또는 월별로 그룹핑하여 주요 변경사항 테이블 -->
<table>
<tr><th>시기</th><th>주요 변경</th><th>커밋 수</th></tr>
<!-- 행 반복 -->
</table>

<h2>2. 이번 주 변경 이력 (상세)</h2>
<!-- 날짜별로 그룹핑 -->
<table>
<tr><th width='90'>날짜</th><th width='70'>커밋</th><th>변경 내용</th></tr>
<!-- 각 커밋 행. 변경 내용은 한국어로 기능 수준 요약 -->
</table>

<h2>3. 현재 상태</h2>
<ul>
<!-- 완료된 것, 진행 중인 것 -->
</ul>

<h2>4. 남은 작업</h2>
<table>
<tr><th>작업</th><th>담당</th><th>우선순위</th></tr>
<!-- TASKS.md/PLAN.md 기반 -->
</table>

</body>
</html>
\`\`\`

### 3단계: PDF 변환
각 HTML → PDF (Playwright 사용):
\`\`\`bash
cd ~/eddy-agent/eldo  # playwright 설치된 디렉토리
node -e \"
const { chromium } = require('playwright');
(async () => {
  const b = await chromium.launch();
  const p = await b.newPage();
  await p.goto('file://${REPORT_DIR}/{team}-${REPORT_DATE}.html');
  await p.pdf({
    path: '${REPORT_DIR}/{team}-${REPORT_DATE}.pdf',
    format: 'A4',
    margin: { top: '15mm', bottom: '15mm', left: '12mm', right: '12mm' },
    printBackground: true
  });
  await b.close();
})();
\"
\`\`\`

### 4단계: 텔레그램 전송 (팀별 개별)
각 팀 PDF를 하나씩 전송:
\`\`\`bash
curl -s -X POST \"https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendDocument\" \\
  -F \"chat_id=${TELEGRAM_CHAT_ID}\" \\
  -F \"document=@${REPORT_DIR}/{team}-${REPORT_DATE}.pdf\" \\
  -F \"caption=📊 {팀명} 주간 보고서 (${REPORT_DATE})\"
\`\`\`

모든 팀 전송 후, 마지막에 텍스트 요약:
\`\`\`bash
curl -s -X POST \"https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage\" \\
  -H \"Content-Type: application/json\" \\
  -d '{\"chat_id\": ${TELEGRAM_CHAT_ID}, \"text\": \"[Eddy 주간 보고 완료 — ${REPORT_DATE}]\n\n📊 PDF 전송: N개 팀 (activity 있는 팀만)\n• {팀}: X건 커밋\n...\n\n⏸ 변동 없음: {스킵된 팀 목록}\", \"parse_mode\": \"Markdown\"}'
\`\`\`

## 규칙
- 한국어로 작성
- 커밋은 코드 수준이 아닌 **기능/변경 수준**으로 요약 (예: 'fix: 로그인 버그 수정' → '로그인 시 세션 토큰 만료 처리 버그 수정')
- 커밋 없는 팀은 PDF 생성 안 함 (스킵) — 텍스트 요약에만 '변동 없음' 표기
- PDF 생성 실패 시 HTML 첨부 또는 텍스트로 대체
- 전체 이력은 Phase/월 단위로 요약, 이번 주는 커밋별 상세
" >> "$LOG_FILE" 2>&1

echo "[$(date '+%Y-%m-%d %H:%M:%S')] 주간보고 완료" >> "$LOG_FILE"
