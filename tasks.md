# Tasks
_Eddy가 처리 중이거나 대기 중인 작업 목록_

## 대기 중
- [ ] **ELDO 베타 개발 — Phase 3~5: 프론트 개발 (진행중)** — Sprint 2~5 완료 (2026-04-03): /vcr 신규 페이지(VCR-C/S/T 탭, 프롬프트 복사), 뉴스레터 구독 폼, EMTEC 태그+필터링, Yahoo Finance 외부링크 교체. 남은 작업: /sectors EMTEC 필터, VCR DB 연동, 다국어/GA/SEO. GitLab push는 자격증명 필요.
- [ ] **ELDO 베타 30분 스케줄** — "이 팀도 30분에 한번씩 할일을 처리하자" (2026-04-03). 현재 기술적 제약(최소 1시간, remote trigger 인증 오류) 동일. 해결 방안 논의 필요.
- [ ] **리뷰봇 가격대별 깊이 적용** — `reviewbot_prompt.md` 작성 완료 (2026-04-03). 실제 리뷰봇 코드/레포 확인 후 해당 프롬프트 연동 필요. 리뷰봇 레포 위치 확인 요망.
- [ ] **데브게이트랜/라이브결제 팀 스캐쥴 설정** — 30분마다 실행 요청 (2026-04-02). 문제: (1) Remote trigger API 인증 오류, (2) Claude Code scheduled trigger 최소 간격은 1시간. 대안 논의 필요.

## 완료
- [x] **로컬 PostgreSQL DB 설정** — PostgreSQL@16 로컬 이미 설치됨 확인. `eldo`, `liveorder` DB 생성 완료 (2026-04-03). `prisma db push` + `db:seed` 성공: 기업 20개, 재무제표 100건, 주가 10460건, VCR 보고서 23건 적재.
- [x] **라이브오더 Admin DB 계정 생성** — `scripts/create-admin.js` 실행 완료 (2026-04-03). kimeleven@gmail.com / qwer1234 계정 생성됨. 로컬 liveorder DB 사용.
- [x] **앤트로픽 API 키 확인** — reviewbot/.env 및 eldo-team/dev1.sh에 `CLAUDE_CODE_OAUTH_TOKEN` 이미 설정되어 있음 (2026-04-03). 모든 팀 에이전트 스크립트에 포함됨.
- [x] **텔레그램 봇 토큰 갱신** — 신규 토큰(8745206278:AAEm...) 사용으로 정상 작동 확인 (2026-04-02)
- [x] **라이브오더 Admin 로그인 버그 수정** — 미들웨어 HKDF salt 오류 수정 (2026-04-02). production에서 `__Secure-authjs.session-token` 쿠키를 `authjs.session-token` salt로 복호화하던 버그. kimeleven/liveorder master에 push 완료 (876bb02).

