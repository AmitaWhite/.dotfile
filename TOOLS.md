# CLI / TUI 도구 카탈로그

새 머신 세팅용 개인 메모. Neovim 자체 의존성은 [README](README.md) 쪽.

## DB / SQL

- **harlequin** — 터미널 SQL IDE (기본 SQLite, 어댑터로 Postgres 등 지원)
  ```sh
  uv tool install harlequin
  ```
- **squall-sql** — 또 다른 SQL TUI 뷰어/에디터
  ```sh
  uv tool install squall-sql
  ```

## 문서 / 발표 / 이미지

- **presenterm** — 터미널에서 마크다운 프레젠테이션
- **slides** — 더 가벼운 마크다운 프레젠테이션
- **silicon** — 코드를 이미지로 만들어줌 (한글 미지원)

## 미디어

- **shellbeats** — 유튜브 음악 검색 + 다운로더.
  `git clone` 후 임시 디렉토리에서 `make && make install`
- **celluloid** — GNOME MPV 프론트엔드 (Linux 용)

## 시스템 / 디스크

- **duf** — 디스크 사용량 예쁘게
- **mole** — 디스크 분석 · 정리 (CleanMyMac 류)
- **orbstack** — 맥 컨테이너 / VM (colima 보다 나음, Docker 대체)
- **taproom** — Homebrew TUI 관리자 (검색 · 설치 여부 확인)
- **tokei** — 코드 라인 수 카운트
- **hyperfine** — 커맨드 벤치마크

## 셸 / 탐색

- **nushell** — 데이터 지향 셸 (env, ls, json/html 등 구조화 출력)
- **zoxide** — 스마트 `cd`

## 연습

- **tukai** — 타이핑 연습

## 안 씀

- **paneru** — macOS 용 niri 스타일 타일링 WM.
  niri 만큼 부드럽지 않아 보류. 설정은 `~/.paneru.toml` 에 남겨둠.
