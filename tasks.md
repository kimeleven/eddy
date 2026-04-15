# Tasks
_Eddy가 처리 중이거나 대기 중인 작업 목록_

## 대기 중
- [x] **BizTool 팀 재가동 + 명함 제작 기능 착수** — Sanghun 승인 (2026-04-15 19:01). 보류 해제, 4시간 스케줄 적용, launchd 로드 완료. TASKS.md에 ✅승인됨 상태로 배정. Dev1/Planner 다음 실행 시 착수.
- [x] **ReviewBot 하루 1회 크론 설정** — 오전 10시 `node pipeline.mjs --manual` 자동 실행. 정상 등록 완료. 클립팬 링크(elCVBf) pending-links.json 대기 중. 목걸이선풍기 Sanghun 지시로 대기 삭제 완료 (2026-04-10). ⚠️ 네이버 세션 만료 시 수동 재로그인 필요.
- [ ] **신규 프로젝트 검토: Tesla/AI 뉴스 YouTube 채널 (TeslaAI 채널)** — Sanghun 기획 제안 (2026-04-05). 미녀 AI 앵커로 Tesla/Musk/AI 뉴스 전달. 중국 AI 솔루션 활용 최저 비용 구성. Sanghun 승인 후 개발 시작. 월 $6~15 예상.
- [ ] **ReviewBot: 봄 아이템 쿠팡 링크 제공** — 봄 신발/가방/아우터/니트/운동화/스니커즈/코디/자켓/원피스 등 10+건 waiting 상태. 링크 직접 제공 방식으로 하루 1건씩 발행 예정.
- [ ] **XBot: 최초 로그인 테스트 (Sanghun 직접)** — `cd ~/eddy-agent/xbot && node pipeline.mjs --once` 터미널 직접 실행. X.com 로그인 성공 확인 후 크론 등록.
- [x] **ELDO 크론탭 24시간 30분 주기 변경** — 백그라운드에서 정상 적용 완료. dev1: `*/30`, dev2: `15,45`, planner: `0 */2`, qa: `30 */3`, pm-report: `0 *` (2026-04-04)
- [x] **ReviewBot pipeline 1시간 주기 크론 활성화** — `0 * * * * cd .../reviewbot && node pipeline.mjs >>` 정상 등록 완료 (2026-04-04)
- [x] **LiveOrder 기획서 정리/업데이트** — Requirements/LIVEORDER_기획서_ClaudeCode용.md 내용을 최신 상태로 정리. 현재 구현된 기능, 미구현 기능, DB 스키마 변경사항 반영. 변경 이력 추가. (Sanghun 지시 2026-04-04)
- [x] **ELDO 베타 GitHub 푸시** — "베타는 깃허브" 지시 수신 (2026-04-04). GitHub kimeleven/eldo `beta` 브랜치 생성 및 푸시 완료. GitLab MR 불필요.
- [ ] **ELDO Vercel 배포 (토큰 필요)** — next build 성공, vercel.json 생성, kimeleven/eldo GitHub 푸시 완료. Vercel 토큰만 있으면 즉시 배포 가능. vercel.com/account/tokens 에서 발급 후 알려주면 처리. DATABASE_URL은 Neon PostgreSQL 설정 필요.
- [ ] **ELDO Google Analytics** — `NEXT_PUBLIC_GA_ID` 발급 필요. GA4 콘솔에서 새 속성 생성 후 `.env`에 설정하면 자동 활성화.
- [ ] **ELDO 다국어 (P2)** — next-intl 도입 후 한/영 UI 텍스트 번역. 현재 일부 페이지만 한국어 hardcoded.
- [ ] **ELDO 베타 30분 스케줄** — "이 팀도 30분에 한번씩 할일을 처리하자" (2026-04-03). 현재 기술적 제약(최소 1시간, remote trigger 인증 오류) 동일. 해결 방안 논의 필요.
- [ ] **데브게이트랜/라이브결제 팀 스캐쥴 설정** — 30분마다 실행 요청 (2026-04-02). 문제: (1) Remote trigger API 인증 오류, (2) Claude Code scheduled trigger 최소 간격은 1시간. 대안 논의 필요.

## 완료
- [x] **Liveorder 개발 종료** — "여기까지하고 정리" 지시 수신 (2026-04-03). 크론탭 Liveorder 팀 제거, 관련 대기 작업 정리 완료.
- [x] **트위드자켓 블로그 재포스팅** — (사진 첨부) 마커 및 쿠팡 링크 블록 제거 후 재발행 (2026-04-03). URL: https://blog.naver.com/kimeleve/224239885006
- [x] **ELDO GitHub 레포 + 배포 준비** — next build 성공, Prisma Decimal 타입 오류 수정, vercel.json 추가, kimeleven/eldo main 푸시 (2026-04-03). Vercel 토큰만 있으면 즉시 배포 가능.
- [x] **리뷰봇 가격대별 깊이 적용** — `review-writer.mjs` + `image-generator.mjs` 수정 완료 (2026-04-03). 10만/10~50만/50~100만/100만+ 원 기준으로 글자수(2000~8000자) + 사진수(3~10장+) 자동 조정. kimeleven/reviewbot main 푸시 완료.
- [x] **ELDO QA 버그 수정** — 뉴스레터 중복→409, VCR-S/T 상세로딩 id 기반 수정, Suspense 타이틀 오류, await 오류 수정 + JSON-LD SEO 추가 (2026-04-03). kimeleven/eldo main 푸시, GitLab beta 브랜치 푸시 완료.
- [x] **ELDO GitLab push** — SSH 키(`id_ed25519_mintech`) 발견. git@git.mintech.kr 인증 성공. `git.mintech.kr/greta/eldo-web` beta 브랜치 push 완료 (2026-04-03).
- [x] **로컬 PostgreSQL DB 설정** — PostgreSQL@16 로컬 이미 설치됨 확인. `eldo`, `liveorder` DB 생성 완료 (2026-04-03). `prisma db push` + `db:seed` 성공: 기업 20개, 재무제표 100건, 주가 10460건, VCR 보고서 23건 적재.
- [x] **라이브오더 Admin DB 계정 생성** — `scripts/create-admin.js` 실행 완료 (2026-04-03). kimeleven@gmail.com / qwer1234 계정 생성됨. 로컬 liveorder DB 사용.
- [x] **앤트로픽 API 키 확인** — reviewbot/.env 및 eldo-team/dev1.sh에 `CLAUDE_CODE_OAUTH_TOKEN` 이미 설정되어 있음 (2026-04-03). 모든 팀 에이전트 스크립트에 포함됨.
- [x] **텔레그램 봇 토큰 갱신** — 신규 토큰(8745206278:AAEm...) 사용으로 정상 작동 확인 (2026-04-02)
- [x] **라이브오더 Admin 로그인 버그 수정** — 미들웨어 HKDF salt 오류 수정 (2026-04-02). production에서 `__Secure-authjs.session-token` 쿠키를 `authjs.session-token` salt로 복호화하던 버그. kimeleven/liveorder master에 push 완료 (876bb02).
