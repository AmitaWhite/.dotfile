# dotfiles

Neovim 설정(LazyVim starter 기반)이 메인이고, 다른 머신에서 쓰던 config 백업
(`caelestia-backup.bak/`, `*.bak`)이 같이 들어있는 개인 저장소.

- 개인 CLI/TUI 도구 목록 → [TOOLS.md](TOOLS.md)
- 설정 리팩터링 기록 · 작성 규칙 · 결정 사항 → [REFACTOR.md](REFACTOR.md)

---

## Neovim

### 설정 파일 맵

```txt
init.lua                  부트스트랩 → lua/config/lazy.lua
lazyvim.json              활성 extras 목록 (:LazyExtras 가 관리, 직접 편집도 가능)
lua/config/
  lazy.lua                lazy.nvim 셋업, 성능/UI 옵션 (extras 는 여기 안 적음)
  options.lua             vim 옵션 (wrap, winborder …)
  keymaps.lua             개인 키맵 — LazyVim 과 겹치지 않는 것만
  autocmds.lua            (현재 비어있음)
lua/plugins/*.lua         플러그인별 오버라이드 (파일 1개 = 플러그인 1개)
  lsp.lua                 LSP 서버 설정 — extras 가 안 다루는 서버 · extras 기본값 변경만
lua/lsp/                  옛 설정 백업(.bak)만 있음. 새 파일 넣지 말 것
```

옵션/키맵/오토커맨드는 LazyVim 이 `VeryLazy` 에서 자동 로드한다.
**플러그인이 이미 잡은 키맵을 바꾸려면 `lua/config/keymaps.lua` 에서 재정의**해야 override 된다.

### 작성 규칙 (요약, 자세한 건 REFACTOR.md)

- 뭔가 추가하기 전에 **LazyVim 이 이미 해주는지** 확인 (`:LazyExtras`, LazyVim 소스 grep)
- 키맵은 LazyVim 그룹 prefix(`<leader>s` `t` `d` `n` `w` `<tab>`) 를 침범하지 않는다
- 플러그인 스펙은 `opts` 로. `config = function()` 은 LazyVim 기본 설정을 통째로 버리므로 금지
- extras 는 `lazyvim.json` 에만. `lazy.lua` 에 `import = "lazyvim.plugins.extras.*"` 를 직접 쓰지 않는다

### 개인 키맵

| 키           | 모드 | 동작                                  |
| ------------ | ---- | ------------------------------------- |
| `jk`         | i    | ESC                                   |
| `<leader>fh` | n    | 오른쪽 세로 터미널 (snacks.terminal)  |
| `<C-\>`      | n, t | 플로팅 터미널 토글 (터미널 안에서도)  |

그 외는 전부 LazyVim 기본. 자주 쓰는 것:

| 키                       | 동작                                      |
| ------------------------ | ----------------------------------------- |
| `<leader>qq`             | 전체 종료 (`:q` 는 창 하나만 닫는다)      |
| `<C-/>` / `<leader>ft`   | 아래 터미널 토글                          |
| `<leader>-` / `<leader>\|` | 창 가로 / 세로 분할, `<leader>wd` 닫기  |
| `<leader><tab><tab>`     | 새 탭 (`<leader><tab>` 그룹)              |
| `<leader>e`              | 파일 탐색기 (snacks.explorer)             |
| `<leader><space>` / `<leader>/` | 파일 찾기 / grep (snacks.picker)   |
| `<leader>sh`             | 도움말 검색                               |
| `<leader>tt` / `tr` / `ts` | 테스트 파일 실행 / 가장 가까운 것 / 요약 |
| `<leader>cD`             | docstring 생성 (vim-doge)                 |
| `]t` / `[t`              | 다음 / 이전 TODO 주석                     |

### 활성 extras / 언어 도구

전부 `lazyvim.json` 에 있고 `:LazyExtras` 로 켜고 끈다.

- **언어**: clangd, docker, java, json, markdown, python, rust, sql, tailwind, toml, typescript(+biome), yaml
- **코딩**: mini-surround
- **포맷/린트**: prettier, eslint
- **디버그/테스트**: dap.core, test.core (neotest + neotest-java)

`lua/plugins/lsp.lua` 에서 직접 손댄 것:

| 언어   | 서버           | 비고                                                             |
| ------ | -------------- | ---------------------------------------------------------------- |
| Python | pyright + ruff | **진단은 ruff 만**, pyright 는 완성·정의 이동·hover 담당 (타입 에러는 안 보임) |
| SQL    | postgres_lsp   | sql extra 가 LSP 를 안 넣어서 직접 추가                          |

TS(vtsls) · Java(jdtls, lombok 포함) 는 extras 기본값 그대로.
mason 자동설치: `stylua`, `shellcheck`, `shfmt`, `lemminx`. **rust-analyzer 는 rustup 컴포넌트**로.

### 알아둘 점

- **Picker 는 `snacks.picker`**, 입력창은 `snacks.input` (telescope · dressing 제거함)
- **창 테두리는 `vim.opt.winborder`** 한 곳에서 제어 (`options.lua`). noice / lazy 는 미지원이라 각자 설정
- **다크/라이트**: nvim 이 터미널 배경색을 자동 감지해 `background` 를 세팅하고, tokyonight 가
  dark=`moon` / light=`day` 를 고른다. 셸 호출 없음. **터미널도 OS 를 따라가야** 실제로 전환됨
  → ghostty: `theme = light:TokyoNight Day,dark:TokyoNight Moon`
- colorscheme 는 tokyonight, `transparent = true`

---

## 새 머신 세팅

### 필수 (없으면 `:checkhealth` 빨간불)

- `git`, `curl`
- `rg` (ripgrep), `fd` — grep / 파일 검색
- **C 컴파일러** (`cc` / `gcc` / clang) — treesitter 파서 컴파일
- **`tree-sitter` CLI** — 파서 설치/업데이트. mason 이 설치한 것을 쓰고, `options.lua` 가 nvim 시작 시
  mason bin 을 PATH 앞에 넣어준다 (mason 이 lazy-load 라 그 전엔 못 찾음).
  ⚠️ `brew install tree-sitter` 는 CLI 가 아니라 **라이브러리**라 nvim 의 링크를 깨뜨릴 수 있고,
  `tree-sitter-cli` 는 Intel 맥에서 llvm + rust 툴체인을 통째로 끌어온다 → 둘 다 쓰지 말 것
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
- **rustup** → `rustup component add rust-analyzer` (mason 으로 깔지 않는다)
- **uv** → Python
- **node** (fnm / volta 등) → TS/JS

---

## 셸 / 터미널 환경

- **fish** + **fisher** (플러그인 매니저)
- **ghostty** — 터미널 에뮬레이터 (테마는 위 "다크/라이트" 참고)
- **starship** — 프롬프트
- **yazi** — 파일 매니저 · **zoxide** — 스마트 `cd`
- **bat**, **tldr** — cat / man 대체
- 에디터: **helix** (`hx`), **zed** (Linux 는 `zeditor`)
