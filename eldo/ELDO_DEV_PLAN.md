# ELDO 개발 계획 (베타버전)
_작성: Eddy | 2026-04-03 | 30분 단위 스프린트_

## 전제 조건

- **데이터 스크래핑 제외** (이번 단계 skip)
- **더미 DB 우선 구축** → 프론트 개발 환경 확보
- **배포**: Vercel (프론트) + Neon (DB)
- 개발 단위: 30분 스프린트

---

## Phase 0: 현황 분석 및 ToDo 정리 ✅

베타버전 요구사항 PDF + VCR 예시 PDF + 기존 코드 분석 완료.

### 베타버전 핵심 기능

| 기능 | 우선순위 |
|------|----------|
| 재무정보 조회 (기업/필터) | HIGH |
| 주가 → 외부링크(Yahoo Finance) 대체 + 가공 차트만 내부 | HIGH |
| VCR-C 보고서 (단기/장기, 프롬프트 복사 버튼) | HIGH |
| VCR-S/T 보고서 (섹터/테마) | MEDIUM |
| EMTEC 태그 필터링 추가 | MEDIUM |
| 뉴스레터 구독 이메일 입력 | LOW |
| 데이터 스크래핑/뉴스 수집 | SKIP |

---

## Sprint 계획

### Sprint 1 (30분): 더미 DB 구성
- prisma/seed.ts: 한국/미국/일본 각 10개 기업, 더미 재무/주가/VCR/EMTEC 데이터
- EMTEC 테이블 스키마 추가
- npm run db:seed 등록

### Sprint 2~3 (60분): 프론트 디자인
- 공통: 네비, EMSEC+EMTEC 통합 필터, 기업 카드
- 페이지: /company, /sectors, /vcr(신규), 홈(뉴스레터 CTA)

### Sprint 4~8 (150분): 프론트 개발
- Sprint 4: 더미 DB 연동 + 레이아웃
- Sprint 5: /company — 재무연동, 외부 주가링크, EMTEC 태그
- Sprint 6: /sectors — EMTEC 필터, 주가 추이 차트(100 정규화)
- Sprint 7: /vcr — VCR-C/S/T 뷰어, 프롬프트 복사, 오늘 업데이트 리스트
- Sprint 8: /valuation, /peer, /compare(더미), 뉴스레터 구독폼

### Sprint 9~10 (60분): 0403 추가 개발
- Sprint 9: EMTEC 필터 메뉴 고도화, 태그별 주가추이
- Sprint 10: 다국어 구조(한/영/일), Google Analytics, SEO 메타태그

### Sprint 11 (30분): 테스트 및 Vercel 배포
- next build 확인 → Vercel 배포 → Neon DB seed → 검증 → 보고

**총 11 스프린트 | 330분**

---

## ToDo 리스트 (PDF 기반)

### 즉시 착수
1. [ ] 더미 DB seed 스크립트 (prisma/seed.ts)
2. [ ] EMTEC 태그 테이블 (prisma schema 추가)
3. [ ] /vcr 신규 라우트 생성
4. [ ] 기업 페이지 주가 → 외부 링크 교체
5. [ ] 뉴스레터 이메일 구독 폼

### 더미 데이터 연동 후
6. [ ] 재무정보 필터링 (국가/시장/산업)
7. [ ] 주가 추이 차트 (EMTEC/EMSEC, 100 정규화, 초록/빨강)
8. [ ] VCR-C 뷰어 + 섹션별 프롬프트 복사 버튼
9. [ ] "오늘 업데이트 기업" 리스트 노출

### 후순위
10. [ ] 다국어 (한/영/일) DB 컬럼 설계
11. [ ] Google Analytics 삽입
12. [ ] SEO 메타태그
