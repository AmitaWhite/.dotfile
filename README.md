# dotfiles

Neovim 설정(LazyVim starter 기반)이 메인이고, 다른 머신에서 쓰던 config 백업
(`caelestia-backup.bak/`, `*.bak`)이 같이 들어있는 개인 저장소.

개인 CLI/TUI 도구 목록은 [TOOLS.md](TOOLS.md) 참고.

---

## Neovim

### 설정 파일 맵

```txt
init.lua                  부트스트랩 → lua/config/lazy.lua
lua/config/
  lazy.lua                lazy.nvim 셋업, extras import, 성능/UI 옵션
  options.lua             vim 옵션 (wrap, winborder …)
  keymaps.lua             직접 추가/변경한 키맵
  autocmds.lua            (현재 비어있음)
lua/plugins/*.lua         플러그인별 오버라이드 (파일 1개 = 플러그인 1개)
lua/lsp/*.lua             언어별 LSP 세부설정 ( lazy.lua 의 { import = "lsp" } 로 로드 )
  jdtls.lua               Java  : lombok javaagent 주입
  vtsls.lua               TS/JS : auto import, 파일 이동 시 import 갱신
lua/utils/
  system-color.lua        OS 다크/라이트 감지 → colorscheme 스타일 결정
```

옵션/키맵/오토커맨드는 LazyVim 이 `VeryLazy` 에서 자동 로드한다.
**which-key 등 플러그인이 이미 잡은 키맵을 바꾸려면 반드시 `lua/config/keymaps.lua` 에서
재정의**해야 override 된다.

### 직접 바꾼 키맵

| 키                               | 모드 | 동작                                             |
| -------------------------------- | ---- | ------------------------------------------------ |
| `jk`                             | i    | ESC                                              |
| `<leader>nh`                     | n    | 검색 하이라이트 끄기                             |
| `<leader>sv` / `sh`              | n    | 세로 / 가로 분할                                 |
| `<leader>se` / `sx`              | n    | 분할 크기 균등 / 현재 분할 닫기                  |
| `<leader>to` `tx` `tn` `tp` `tf` | n    | 탭 열기 / 닫기 / 다음 / 이전 / 현재 버퍼를 새 탭 |
| `]t` / `[t`                      | n    | 다음 / 이전 TODO 주석                            |
| `<leader>fh`                     | n    | 오른쪽 세로 터미널 (Snacks)                      |
| `<leader>tt`                     | n    | 플로팅 터미널 (toggleterm)                       |

> ⚠️ 탭 조작에 `<leader>t*` 를 쓰고 있어서 toggleterm 의 `<leader>tt`,
> LazyVim 기본 `<leader><Tab>` 탭 그룹과 네임스페이스가 겹친다.
> 정리하려면 탭 키맵을 `<leader><Tab>` 쪽으로 옮기는 걸 고려.

- 종료는 `<leader>qq` (= `:qa`). `:q` 는 **창 하나만** 닫으므로 탐색기(`<leader>e`)
  같은 사이드바가 열려 있으면 Neovim 이 안 꺼진다.

### 활성 extras / 언어 도구

`:LazyExtras` 로 관리. 현재 (`lazyvim.json` + `lua/config/lazy.lua` 하드코딩분):

- **언어**: typescript(+biome), json, toml, python, clangd, docker, java,
  markdown, rust, sql, tailwind, yaml
- **코딩**: mini-surround
- **포맷/린트**: prettier, eslint
- **디버그/테스트**: dap.core, test.core (neotest + neotest-java)

직접 설정한 LSP 서버:

| 언어   | 서버           | 비고                                     |
| ------ | -------------- | ---------------------------------------- |
| Python | pyright + ruff | pyright 타입체크 basic, 진단은 ruff 위주 |
| TS/JS  | vtsls          | auto import                              |
| Java   | jdtls          | lombok                                   |
| SQL    | postgres_lsp   |                                          |

mason 자동설치: `stylua`, `shellcheck`, `shfmt`, `rust-analyzer`, `lemminx`

### 알아둘 점

- **Picker 는 `snacks.picker`** (telescope 제거함).
  `<leader><space>` 파일 · `<leader>/` grep · `<leader>e` 탐색기
- **창 테두리는 `vim.opt.winborder`** 한 곳에서 제어 (`options.lua`).
  noice / lazy / toggleterm 은 winborder 미지원이라 각자 설정
- **시스템 다크모드 연동**: macOS `defaults read -g AppleInterfaceStyle`,
  Linux 는 GNOME `gsettings`. (`lua/utils/system-color.lua`)
- colorscheme 는 tokyonight, `transparent = true`

---

## 새 머신 세팅

### 필수 (없으면 `:checkhealth` 빨간불)

- `git`, `curl`
- `rg` (ripgrep), `fd` — grep / 파일 검색
- **C 컴파일러** (`cc` / `gcc` / clang) — treesitter 파서 컴파일
- **Nerd Font** (예: JetBrainsMono Nerd Font) — 아이콘

### 기능별 (있으면 좋음)

| 패키지                   | 용도                                       |
| ------------------------ | ------------------------------------------ |
| `lazygit`                | Git UI (snacks 연동, `<leader>gg`)         |
| `fzf`                    | 퍼지 검색 백엔드                           |
| `imagemagick` (`magick`) | nvim 에서 이미지 · PDF 렌더 (snacks image) |
| `node`                   | 일부 LSP (vtsls 등)                        |
| `eza`                    | `ls` 대체, git 상태 표시 좋음              |
| `bat`                    | 프리뷰 신택스 하이라이트                   |

### 언어 툴체인

- **sdkman** → Java (jdtls, lombok)
- **rustup** → rust-analyzer
- **uv** → Python
- **node** (fnm / volta 등) → TS/JS

---

## 셸 / 터미널 환경

- **fish** + **fisher** (플러그인 매니저)
- **ghostty** — 터미널 에뮬레이터
- **starship** — 프롬프트
- **yazi** — 파일 매니저 · **zoxide** — 스마트 `cd`
- **bat**, **tldr** — cat / man 대체
- 에디터: **helix** (`hx`), **zed** (Linux 는 `zeditor`)
