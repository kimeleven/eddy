# Sanghun Kim - Study
_Eddy의 Sanghun 관찰 기록 | 대화할 때마다 업데이트됨_

_Last updated: 2026-04-03 (2차)_

## 의사결정 방식
- 빠르게 결정하고 실행하는 스타일
- 과정보다 결과를 중시함
- 직접 해보면서 배우는 방식 선호 (테스트 먼저 해보자는 태도)

## 일하는 방식
- 맥북을 24시간 켜두고 자동화 시스템 구축
- 에이전트 기반 워크플로우 설계 중
- 큰 그림을 먼저 잡고 세부사항은 나중에 채워나감
- 반복적이고 점진적으로 시스템을 발전시키는 스타일

## 커뮤니케이션 스타일
- 한국어로 소통
- 짧고 간결하게 말함 (설명 최소화)
- 결과만 원하고 과정 설명은 불필요하다고 명시
- 직접적이고 솔직한 피드백 선호
- **불만을 직접 표현함** — 무시당하는 느낌이면 바로 언급
- **명시적 보고를 강조** — 처리한 내용은 반드시 텔레그램으로 보고해야 함

## 에디에 대한 기대
- 단독 채널(개인 채팅)에서는 "@에디" 호출 없이도 모든 메시지를 지시로 처리
- 텔레그램 메시지 누락 없이 반드시 처리
- 이행한 내용은 명시적으로 보고

## 현재 프로젝트/관심사
- Eddy 에이전트 시스템 구축 중
  - 마스터 에이전트(Eddy)가 서브에이전트들을 조율
  - 텔레그램으로 개인 채팅 + 그룹 채팅 모니터링
  - GitHub 레포(kimeleven/eddy)에 학습 내용 누적
  - 매시간 자동 실행
- 앤트로픽 팀 계정의 API 키를 Eddy에 연동하려는 계획

## 가치관 & 원칙
- 자율성 중시: 에이전트가 알아서 판단하고 실행하길 원함
- 확장성: 다른 환경에서도 재현 가능한 시스템 선호 (setup.md)
- 효율성: 불필요한 과정 생략, 핵심만 전달

## 서브에이전트 운영 방침
- Eddy가 study.md를 참고해 서브에이전트들에게 Sanghun의 성향 전달
- 서브에이전트는 자율적으로 실행하고 결과만 보고

## 리뷰봇 프로젝트
- 제품 리뷰 자동화 봇
- **가격대별 리뷰 깊이 정책** (2026-04-03 지시, 최소 2000자 상향 수정):
  - 10만원 미만: 기본 (사진 3~4장, 2,000~3,000자)
  - 10~50만원: 중간 (사진 5~7장, 3,000~5,000자)
  - 50~100만원: 심층 (사진 8~10장, 5,000~7,000자)
  - 100만원 이상: 프리미엄 (사진 10장+, 8,000자+)
  - **핵심: 최소 2000자부터 시작** (Sanghun 직접 수정 지시)
- 레포 위치 미확인 — 별도 확인 필요

## LiveOrder 프로젝트
- **개발 완전 종료 (2026-04-03)** — "Liveorder 개발은 여기까지하고 정리" (Sanghun 지시). 더 이상 개발 진행 없음.
- e-커머스 플랫폼 (셀러/구매자/관리자 3자 구조)
- GitHub: kimeleven/liveorder
- 스택: Next.js 16, Prisma, Neon PostgreSQL, Vercel, PortOne 결제
- 최종 단계: Phase 1 MVP QA 완료, Admin 로그인 버그 수정 완료 상태로 종료
- 관리자 이메일: kimeleven@gmail.com

## ELDO 프로젝트
- 투자 데이터 플랫폼 (한미일 상장사 재무/산업정보)
- **소스코드**: ELDO.zip으로 직접 전달받음
- **실제 레포**: https://git.mintech.kr/greta/eldo-web (GitLab 프라이빗)
- 알파버전 배포 중: https://eldo.mintdev.uk/
- **기술 스택**: Next.js 16, Prisma, Neon PostgreSQL, Recharts, Tailwind v4, Radix UI, Jotai, TanStack
- **베타버전 개발 방향** (2026-04-03 지시):
  - 실제 데이터 스크래핑 제외, 더미DB로 프론트 개발
  - 순서: 계획수립 → 더미DB → 프론트 디자인 → 프론트 개발 → 0403 추가사항
  - 30분 단위로 개발
  - 테스트 후 Vercel + Neon 배포
- **베타버전 주요 요구사항** (요구사항 PDF 기반):
  - 재무정보 조회 (기업별/필터), 주가 히트맵 (100 기준, 월별, 산업/주제별)
  - VCR 산업정보 보고서 (VCR-C/S/T, LLM 생성, 교차검증)
  - EMTEC 주제별 태그 필터링, 뉴스레터 구독
  - 다국어 (한/영/일), Google Analytics, SEO
  - 주가정보는 Yahoo Finance 외부링크로 대체 (저작권)
- **개발 계획 문서**: eldo/ELDO_DEV_PLAN.md

## Devgate 프로젝트
- ODDSystem (On-Demand Development System) — AI 에이전틱 코딩 시대 투명한 외주 개발 플랫폼
- GitHub: 별도 GitLab (git.mintech.kr), 배포: Coolify (devgate.mintdev.uk)
- 현재: Phase 15/16 진행 중 (개발팀 자동 실행 중, 밤 시간대)
- **Phase 6-C "실환경 검증"이 14회 연속 지연** — PortOne 결제, Kakao 로그인 등 실제 운영 서버에서 인간이 직접 테스트 필요
- "실환경접근가능한 인원" = Sanghun 본인 (Coolify 서버 직접 접근 가능한 유일한 사람)
- Sanghun이 직접 devgate.mintdev.uk 접속 및 기능 테스트 해야 Phase 6-C 완료 가능

## 로컬 개발 환경
- PostgreSQL@16 로컬 설치됨 (/usr/local/Cellar/postgresql@16/16.13/)
- 로컬 DB: `eldo`, `liveorder`, `devgate_test` (localhost:5432, 사용자: a1111, 패스워드 없음)
- Node.js v25.8.2 (/usr/local/bin/node)
- GitHub CLI (/usr/local/bin/gh, kimeleven 계정)
- CLAUDE_CODE_OAUTH_TOKEN: reviewbot/.env 및 팀 에이전트 스크립트에 저장됨
- **GitLab SSH**: `~/.ssh/id_ed25519_mintech` 키로 `git.mintech.kr` 인증 성공 (Eddy 계정). `git@git.mintech.kr:greta/eldo-web.git` push 가능 (2026-04-03 확인)
- Eddy의 철학: "그것도 니가 할 수 있잖아" → 외부 크리덴셜 요청 전 로컬 환경 활용 먼저

## 텔레그램 채팅 현황
- 개인 채팅: Sanghun ↔ Eddy (주요 지시 채널, "@에디" 없어도 처리)
- 그룹 채팅: 봇 추가 시 자동 감지 및 맥락 파악 예정
