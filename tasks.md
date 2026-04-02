# Tasks
_Eddy가 처리 중이거나 대기 중인 작업 목록_

## 대기 중
- [ ] **리뷰봇 가격대별 깊이 적용** — `reviewbot_prompt.md` 작성 완료 (2026-04-03). 실제 리뷰봇 코드/레포 확인 후 해당 프롬프트 연동 필요. 리뷰봇 레포 위치 확인 요망.
- [ ] **앤트로픽 API 키 설정** — Sanghun이 "팀들에 설정한 앤트로픽 키 사용하라"고 지시 (2026-04-02). 현재 Eddy 환경에 해당 키가 없음. 키 값을 직접 공유하거나 환경변수로 설정 필요.
- [ ] **데브게이트랜/라이브결제 팀 스캐쥴 설정** — 30분마다 실행 요청 (2026-04-02). 문제: (1) Remote trigger API 인증 오류, (2) Claude Code scheduled trigger 최소 간격은 1시간. 대안 논의 필요.
- [ ] **라이브오더 Admin DB 계정 생성** — `scripts/create-admin.js` 스크립트 작성 완료. DATABASE_URL 환경변수 필요. `DATABASE_URL=<neon_url> node scripts/create-admin.js` 실행하면 kimeleven@gmail.com / qwer1234 계정 생성됨. Vercel 대시보드에서 DATABASE_URL 확인 가능.

## 완료
- [x] **텔레그램 봇 토큰 갱신** — 신규 토큰(8745206278:AAEm...) 사용으로 정상 작동 확인 (2026-04-02)
- [x] **라이브오더 Admin 로그인 버그 수정** — 미들웨어 HKDF salt 오류 수정 (2026-04-02). production에서 `__Secure-authjs.session-token` 쿠키를 `authjs.session-token` salt로 복호화하던 버그. kimeleven/liveorder master에 push 완료 (876bb02).

