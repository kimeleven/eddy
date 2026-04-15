# OAuth 토큰 관리

## Claude OAuth 토큰 4개

| 이름 | 토큰 |
|------|------|
| 바둑이 | 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 |
| 영희 | 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 |
| **철수** ✅ | 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 |
| 상훈 | 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 |

## 현재 적용: 철수 (2026-04-14, Sanghun 지시)

## 저장 위치
- `~/.eddy_env` — CLAUDE_CODE_OAUTH_TOKEN
- `~/eddy-agent/*/팀/*.sh` — 팀 에이전트 스크립트
- `~/eddy-agent/reviewbot/.env`

## 토큰 교체 명령어
```bash
OLD="현재토큰"
NEW="새토큰"
sed -i '' "s|$OLD|$NEW|g" ~/.eddy_env
find ~/eddy-agent -name "*.sh" -o -name ".env" 2>/dev/null | xargs grep -l "$OLD" 2>/dev/null | xargs sed -i '' "s|$OLD|$NEW|g"
```
