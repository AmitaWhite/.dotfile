# 새 환경 세팅

이 저장소를 받아 **macOS · Arch/CachyOS · WSL(Arch)** 어디서든 같은 nvim 을 쓰기 위한 절차.
"무엇을 왜 깔아야 하는지"까지 적는다. 개인 취향 도구는 [TOOLS.md](TOOLS.md), 키 사용법은 [docs/guide.html](docs/guide.html).

## 0. 한눈에

```txt
1. 저장소 clone → ~/.config/nvim
2. 심링크 걸기 (§1)
3. 필수 도구 설치 (§2)  ← 이것만 있으면 nvim 은 뜬다
4. 언어 툴체인 (§3)      ← 쓰는 언어만
5. 선택 기능 (§4)        ← 이미지·PDF·DB 등
6. nvim 첫 실행 → :Lazy sync → :checkhealth (§6)
```

## 1. 저장소 → 실제 경로 매핑

이 저장소는 nvim 외 설정도 담고 있고, 일부는 **저장소 안 파일로 심링크**해서 쓴다.
새 머신에서는 아래를 다시 걸어야 한다.

| 실제 경로 | 저장소 안 파일 | 비고 |
| --- | --- | --- |
| `~/.config/nvim` | (저장소 루트) | clone 위치 |
| `~/.config/ghostty/config` | `caelestia-backup.bak/ghostty/mac-config.bak` | mac. Linux 는 `arch-config.bak` |
| `~/.config/helix/config.toml` | `caelestia-backup.bak/helix/config.toml` | |
| `~/.config/helix/languages.toml` | `caelestia-backup.bak/helix/language.toml` | 파일명 다름 주의 |
| `~/.config/helix/themes/tokyonight.toml` | `caelestia-backup.bak/helix/theme/tokyonight.toml` | |
| `~/.config/fastfetch/config.jsonc.bak` | `caelestia-backup.bak/fastfetch/config.jsonc` | |

```bash
# 예: ghostty (mac)
mkdir -p ~/.config/ghostty && ln -sf ~/.config/nvim/caelestia-backup.bak/ghostty/mac-config.bak ~/.config/ghostty/config
```

저장소에 **없는** 것 (머신마다 따로): `~/.config/fish/config.fish`(mac 용 — 저장소의 `caelestia-backup.bak/fish/` 는 Linux 용 백업),
hyprland/niri/foot 은 Linux 전용 백업이며 Wayland 세션에서만 의미 있다.

## 2. 필수 — 없으면 `:checkhealth` 가 빨갛다

| 도구 | 왜 필요한가 | mac (brew) | Arch (pacman) |
| --- | --- | --- | --- |
| **neovim ≥ 0.11** (현재 0.12.5) | `winborder`, 배경 자동 감지, `vim.lsp.config` 사용 | `neovim` | `neovim` |
| **git, curl, wget, unzip, gzip, tar** | lazy.nvim 플러그인 clone, mason 이 LSP/포매터 다운로드·압축 해제 | 기본 + `wget` | `base` + `wget unzip` |
| **C 컴파일러** | treesitter 파서 컴파일 | `xcode-select --install` | `base-devel` |
| **ripgrep (`rg`), fd** | 파일·문자열 검색 (snacks.picker, grep) | `ripgrep fd` | `ripgrep fd` |
| **fzf** | 퍼지 검색 백엔드 | `fzf` | `fzf` |
| **lazygit** | Git UI (`<leader>gg`) | `lazygit` | `lazygit` |
| **Nerd Font** | 아이콘 (mini.icons, lualine, 탐색기) | `--cask font-jetbrains-mono-nerd-font` | `ttf-jetbrainsmono-nerd` |
| **node + npm** | mason 이 설치하는 LSP 대부분이 node 로 실행됨 (아래 §5) | `node` 또는 fnm | `nodejs npm` |
| **python3 + pip/venv** | ruff·debugpy·sqlfluff 실행, venv 선택 | `uv` 권장 | `python uv` |

터미널: 이미지 렌더(snacks.image)는 **kitty graphics protocol** 지원 터미널(ghostty · kitty · wezterm)에서만 된다. foot/기본 Terminal.app/WSL 콘솔은 안 됨.

## 3. 언어 툴체인 — 쓰는 언어만

LSP 자체는 mason 이 자동 설치하지만, **런타임/툴체인은 시스템에 있어야** 한다.

| 언어 | 필요한 것 | 왜 | 설치 |
| --- | --- | --- | --- |
| **Java** | JDK 21+ (`JAVA_HOME`) | jdtls 가 JDK 21 이상에서만 실행. lombok 은 java extra 가 자동 주입 | **sdkman** `sdk install java 21.0.10-amzn`. fish 는 fisher 의 `reitzig/sdkman-for-fish` 가 `conf.d/sdk.fish` 로 초기화 → **nvim 을 fish 터미널에서 실행**해야 java 가 잡힌다 (GUI 런처 ✘) |
| **Rust** | rustup + `rust-analyzer` 컴포넌트 | mason 것은 툴체인과 버전이 어긋날 수 있어 rustup 으로 통일 (D4) | `rustup component add rust-analyzer`. 디버거 codelldb 는 mason |
| **Python** | python3, uv | pyright(완성·이동) + ruff(진단·포맷). 진단은 ruff 만 (D1) | `uv python install 3.13`. 프로젝트 venv 는 `<leader>cv` 로 선택 |
| **TS/JS** | node | vtsls · eslint · biome · prettier 전부 node. 디버그 실행기는 `tsx` 있으면 사용 | `npm i -g tsx` (선택) |
| **C/C++** | clangd (mason) + 프로젝트의 `compile_commands.json` | 없으면 헤더 못 찾음 | CMake: `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`, 또는 `bear` |
| **SQL** | DB 클라이언트 바이너리 | vim-dadbod 가 `psql`/`mysql`/`sqlite3` 를 **셸로 호출**한다. LSP 는 postgres_lsp(mason) — 단 **프로젝트 루트에 `postgres-language-server.jsonc` 가 있어야 붙는다** (`workspace_required`). 낱개 .sql 파일엔 안 붙음 | `postgresql`(psql), `mysql-client`, `sqlite`. 프로젝트에서 `postgres-language-server init` |
| **Docker** | (없음) | dockerls · hadolint 모두 mason | |
| **Markdown** | (없음) | markdown-preview 는 첫 빌드 때 바이너리 다운로드(인터넷 필요) | |

## 4. 선택 기능

| 기능 | 필요한 것 | 설치 |
| --- | --- | --- |
| 이미지 렌더 (png/jpg/webp…) | `imagemagick` | `brew install imagemagick` / `pacman -S imagemagick` |
| **PDF 렌더** | imagemagick + **ghostscript (`gs`)** — imagemagick 이 PDF 를 gs 에 위임. `magick -list format` 에 PDF 가 있어도 gs 없으면 실패 | `brew install ghostscript` / `pacman -S ghostscript` |
| Mermaid 다이어그램 | `mmdc` | `npm i -g @mermaid-js/mermaid-cli` |
| LaTeX 수식 렌더 | `tectonic` 또는 `pdflatex` | `brew install tectonic` |
| 클립보드 (Linux) | `wl-clipboard`(Wayland) / `xclip`(X11) | WSL 은 `win32yank` |
| 셸 편의 | `bat`(프리뷰 하이라이트) `eza`(ls) | TOOLS.md |

## 5. mason 이 자동 설치하는 것과 그 런타임

`:Mason` 에서 확인. **런타임이 없으면 설치는 돼도 실행이 안 된다.**

| 런타임 | mason 패키지 |
| --- | --- |
| node | vtsls, eslint-lsp, biome, prettier, tailwindcss-language-server, json-lsp, yaml-language-server, dockerfile-language-server, docker-compose-language-service, markdownlint-cli2, markdown-toc, pyright, js-debug-adapter |
| python | ruff, debugpy, sqlfluff |
| JDK | jdtls, java-debug-adapter, java-test, lemminx |
| 없음 (정적 바이너리) | clangd, codelldb, lua-language-server, marksman, shellcheck, shfmt, stylua, taplo, hadolint, postgres-language-server, tree-sitter-cli |

Go · luarocks · PHP · julia 는 `:checkhealth mason` 이 경고하지만 **현재 패키지엔 불필요**.

`tree-sitter-cli` 는 mason 것을 쓴다. `options.lua` 가 시작 시 `~/.local/share/nvim/mason/bin` 을 PATH 앞에 넣어
mason 이 로드되기 전(대시보드 `:TSUpdate`, `:Lazy sync` build)에도 찾는다.
⚠️ mac 에서 `brew install tree-sitter` 는 **라이브러리**라 nvim 링크를 깨고, `tree-sitter-cli` 는 Intel 맥에서 llvm+rust 를 끌어온다 — 둘 다 쓰지 말 것.

## 6. 첫 실행 체크리스트

```txt
nvim                      플러그인 자동 설치 (lazy.nvim bootstrap). 끝나면 :q 후 재실행
:Lazy sync                lazy-lock.json 기준으로 플러그인 정렬
:Mason                    ensure_installed 자동 진행 확인 (실패한 게 있으면 런타임 §3/§5 확인)
:TSUpdate                 treesitter 파서
:checkhealth lazyvim      필수 도구
:checkhealth mason        런타임
:checkhealth snacks       이미지/터미널 지원
:checkhealth which-key    키맵 충돌 (내 설정 기인 0 이어야 정상)
```

그 다음 언어별로 파일 하나 열어 확인: `:LspInfo` 에 서버가 붙는지, `<leader>cf` 포맷, `]d` 진단 이동.

## 7. 설정 플래그 (LazyVim `vim.g.*`) — 현재값

바꾸려면 `lua/config/options.lua` 에서 **lazy 로드 전에** 설정해야 한다.

| 플래그 | 현재 | 의미 |
| --- | --- | --- |
| `lazyvim_python_lsp` | `pyright` | `basedpyright` 로 교체 가능 |
| `lazyvim_python_ruff` | `ruff` | |
| `lazyvim_rust_diagnostics` | `rust-analyzer` | `bacon-ls` 로 교체 가능 |
| `lazyvim_ts_lsp` | `vtsls` | `tsgo` 실험 가능 |
| `lazyvim_prettier_needs_config` | `false` | true 면 프로젝트에 prettier 설정 있을 때만 포맷 |
| `lazyvim_eslint_auto_format` | `true` | 저장 시 eslint fix |

## 8. 머신별 상태 (저장소 밖, 백업 대상 아님)

| 경로 | 내용 |
| --- | --- |
| `~/.local/share/nvim/lazy/` | 플러그인 본체 (lazy-lock.json 으로 재현) |
| `~/.local/share/nvim/mason/` | LSP/포매터 바이너리 |
| `~/.local/share/nvim/dadbod_ui/connections.json` | **DB 접속 정보** — `:DBUIAddConnection` 으로 등록. 저장소에 넣지 말 것 |
| `~/.local/state/nvim/` | 세션·undo·shada |

## 9. 환경별 주의

- **macOS (Intel)**: Homebrew 가 x86_64 지원을 종료해 bottle 이 없는 포뮬러는 소스 빌드로 빠진다. nvim 런타임 의존성(tree-sitter, libuv)은 단독 업그레이드 금지 — `brew upgrade` 로 함께.
- **Arch / CachyOS**: 대부분 pacman 에 있음. `ttf-jetbrainsmono-nerd`, `wl-clipboard`.
- **WSL(Arch)**: 클립보드 `win32yank`, 이미지 렌더는 Windows Terminal 이 kitty protocol 을 지원하지 않아 ✘. `:checkhealth snacks` 로 확인.
- 다크/라이트: nvim 이 **터미널 배경색**을 감지한다. 터미널 테마가 OS 를 따라가게 설정해야 nvim 도 따라간다 (ghostty: `theme = light:TokyoNight Day,dark:TokyoNight Moon`).
