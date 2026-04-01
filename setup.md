# Eddy Environment Setup Guide
_재현 가능한 환경 구성 가이드_

## 개요
Eddy는 Sanghun Kim의 개인 AI 에이전트입니다.
매시간 자동 실행되며 텔레그램(개인 + 그룹)으로 소통합니다.

## 구성 요소
- Claude Code Remote Agent (CCR) - Anthropic 클라우드
- GitHub 레포: github.com/kimeleven/eddy
- Telegram Bot: 개인 채팅 및 그룹 채팅 모니터링

## 초기 설정 과정
1. GitHub 레포 생성: github.com/kimeleven/eddy
2. Telegram Bot 생성: @BotFather → /newbot
3. GitHub PAT 발급 (public_repo 권한)
4. Claude Code scheduled trigger 생성 (매시간)
5. 그룹 채팅 모니터링: 봇을 그룹에 추가하면 자동 감지

## 파일 구조
- study.md: Sanghun 성향 학습 기록
- setup.md: 환경 설정 가이드 (이 파일)
- state.json: Telegram 메시지 추적용
- tasks.md: 미완료 작업 목록

## Claude Code Trigger
- Trigger ID: trig_01TXCMQCVdDgW7ncr3vuREBA
- 스케줄: 매시간 정각 (0 * * * *)
- 모델: claude-sonnet-4-6
- 관리: https://claude.ai/code/scheduled

