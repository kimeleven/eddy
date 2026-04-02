# ELDO TODO

> 현재 상태: 웹 프레임워크/API/UI는 구축됨. 데이터 파이프라인, DB 적재, 분석 파일 생성, CI/CD가 수동이거나 미구현 상태.

---

## 1. 데이터 파이프라인 (가장 중요)

앱이 동작하려면 DB에 실제 데이터가 있어야 함. 현재 모든 테이블이 비어 있음.

- [ ] 데이터 소스 확정
  - 국내: KRX, DART, KIS API 등 중 사용할 소스 결정
  - 해외: 미국 (Yahoo Finance, Alpha Vantage, Polygon.io 등) 소스 결정
  - 업종 분류(EMSEC) 계층 데이터 초기 적재 방법 결정

- [ ] 기업 마스터 데이터 수집 스크립트 작성
  - `corps` 테이블: 종목코드, 종목명, 거래소, 상장일, 기업규모 등
  - `corps_emsec` 테이블: 기업-업종 매핑

- [ ] EMSEC(업종 분류) 초기 데이터 적재
  - 섹터 → 업종 → 세부업종 계층 구조
  - `emsec` 테이블 seed 데이터 작성

- [ ] 재무제표 수집 스크립트 작성
  - `statements` / `us_statements` 테이블
  - 연간/분기 재무제표 (BS, PL, CF)
  - 과거 데이터 일괄 적재 + 신규 공시 시 증분 업데이트

- [ ] 재무지표(indicators) 계산 및 적재
  - `indicators` / `us_indicators` 테이블
  - P/E, P/S, EV/EBITDA, P/B 등 100여 개 지표
  - 재무제표 적재 후 자동 계산되는 파이프라인 구성

- [ ] 주가 데이터 수집 스크립트 작성
  - `stock_trades` 테이블: 일별 OHLCV, 시가총액, EV
  - 과거 이력 일괄 적재
  - 영업일 기준 일별 자동 수집 스케줄링

- [ ] 주요 이벤트 데이터 수집
  - `stock_events` 테이블: 주식 분할, 합병, 배당, 유상증자 등
  - `reports` 테이블: 공시 보고서 메타데이터

---

## 2. 분석 JSON 파일 생성 자동화

`/sectors` 페이지 차트는 미리 생성된 JSON 파일에 의존함.
현재 `public/data/analysis/` 디렉토리 자체가 없음.

- [ ] 분석 JSON 생성 배치 스크립트 작성
  - 경로 구조: `data/analysis/{chartType}/{fy}/{exchange}/{level}/{var1}_{var2}_{var3}.json`
  - 차트 종류: `corpDist`, `ratioHeatmap`, `ratioScatter`, `changeDist`, `growsStackbar`
  - 집계 기준: 섹터/업종별, 거래소별, 회계연도별

- [ ] 분석 파일 생성 스케줄링
  - 재무제표/지표 DB 업데이트 후 자동으로 분석 파일 재생성
  - 회계연도(FY) 마감 후 신규 파일 생성

---

## 3. DB 초기화 및 마이그레이션 자동화

- [ ] `prisma/seed.ts` 작성
  - 기준 데이터(EMSEC, stock_event_types 등) 시드
  - `npm run db:seed` 커맨드로 실행 가능하게 구성

- [ ] `scripts/convert-schema.ts` 작성
  - `package.json`에 `db:convert` 스크립트로 등록되어 있으나 파일 없음
  - DB pull 후 케이스 변환 자동화 (snake_case → camelCase)

- [ ] DB 초기 셋업 원커맨드화
  - `compose.yml` 실행 → 마이그레이션 → 시드까지 한 번에 가능하게
  - 현재는 여러 수동 단계 필요 (readme.md 참고)

- [ ] `.env.example` 파일 작성
  - `DATABASE_URL` 및 필요한 모든 환경변수 문서화
  - 현재 `.env.example` 파일 없음

---

## 4. CI/CD 파이프라인 보강

현재 `.gitlab-ci.yml`은 `deploy` 스테이지(Coolify webhook 호출)만 있음.

- [ ] `build` 스테이지 추가
  - `next build` 성공 여부 검증
  - TypeScript 컴파일 오류 조기 감지

- [ ] `lint` 스테이지 추가
  - Biome 린트/포맷 검사 자동화 (`npm run check`)

- [ ] `migrate` 스테이지 추가
  - 배포 전 Prisma 마이그레이션 자동 실행
  - `npx prisma migrate deploy`

- [ ] 테스트 스테이지 추가 (장기)
  - 유닛 테스트 / API 통합 테스트 작성 및 CI 연동

---

## 5. Docker Compose 완성

현재 `compose.yml`에 PostgreSQL만 있고 앱 컨테이너가 없음.

- [ ] Next.js 앱 컨테이너 서비스 추가
  - `Dockerfile`은 이미 존재함 (`eldo/Dockerfile`)
  - `compose.yml`에 `app` 서비스 추가, DB 의존성 설정

- [ ] 로컬 개발 환경 원커맨드 구성
  - `docker compose up` 으로 DB + 앱 동시 실행
  - `.env` 마운트 처리

---

## 6. 미완성 페이지 구현

- [ ] `/valuation` 페이지
  - 현재 하드코딩된 더미 데이터 사용 중 (종목코드, 재무수치 모두 고정값)
  - 실제 DB 데이터 연동
  - DCF / 유사기업 비교법 등 밸류에이션 로직 구현

- [ ] `/peer` 페이지
  - 현재 텍스트 설명만 있는 placeholder
  - 동종업체 탐색 UI 및 비교 기능 구현

- [ ] `/compare` 페이지
  - 현재 텍스트 설명만 있는 placeholder
  - 멀티 기업 비교 대시보드 구현

---

## 7. 개발 환경 편의성

- [ ] pre-commit hook 설정
  - Biome lint/format을 커밋 전 자동 실행
  - `lefthook` 또는 `husky` 활용

- [ ] 로컬 DB 샘플 데이터 제공
  - 개발/테스트용 소량의 샘플 데이터 seed 스크립트
  - 새 개발자가 바로 UI를 확인할 수 있도록

---

## 우선순위 요약

| 순서 | 항목 | 이유 |
|------|------|------|
| 1 | 데이터 소스 확정 및 기업/주가 수집 | 이게 없으면 아무것도 동작 안 함 |
| 2 | EMSEC + 기준 데이터 시드 | company/sectors 페이지 기본 동작 |
| 3 | 재무제표 + 지표 수집 | company 상세 페이지, sectors 차트 |
| 4 | 분석 JSON 생성 배치 | sectors 차트 동작 |
| 5 | DB 셋업 자동화 (.env.example, seed) | 재현 가능한 환경 구성 |
| 6 | CI/CD 보강 | 배포 안정성 |
| 7 | Docker Compose 앱 추가 | 로컬 환경 일치 |
| 8 | valuation/peer/compare 페이지 | 기능 완성 |
