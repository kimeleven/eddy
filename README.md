# Eddy - Personal AI Agent

Eddy는 **Sanghun Kim의 개인 AI 에이전트**입니다.
매시간 자동 실행되며 텔레그램으로 소통하고, 서브에이전트들을 조율합니다.

## 구조
```
[Sanghun] ←→ [텔레그램] ←→ [Eddy (매시간 실행)]
                                    ↓
                            [서브에이전트들]
                                    ↓
                            [GitHub 레포 업데이트]
```

## 파일 구조
| 파일 | 설명 |
|------|------|
| `study.md` | Sanghun의 성향, 의사결정 방식, 선호도 학습 기록 |
| `setup.md` | 이 환경을 재현하기 위한 단계별 가이드 |
| `state.json` | 텔레그램 메시지 처리 위치 추적 |
| `tasks.md` | 대기 중인 작업 목록 |
| `README.md` | 이 파일 |

## 동작 방식
1. 매시간 정각 자동 실행
2. 텔레그램 개인 채팅 + 그룹 채팅 전체 읽기
3. 맥락 파악 후 자율 실행
4. study.md 업데이트 (성향 학습)
5. GitHub 커밋 & 푸시
6. 결과만 텔레그램으로 보고

## 관리
- Trigger: https://claude.ai/code/scheduled/trig_01TXCMQCVdDgW7ncr3vuREBA
- Repo: https://github.com/kimeleven/eddy
