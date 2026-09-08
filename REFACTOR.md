# nvim 설정 리팩터링 계획

진단 기준: 2026-09-08, LazyVim `83d90f3`, nvim 0.12.4.
근거는 LazyVim 소스와 런타임 실측(VeryLazy 후 `nvim_get_keymap`, which-key health, `vim.ui.*` 소유자).

한 줄 원인: 서로 다른 시대의 LazyVim 문서를 복붙한 설정이 재정렬 없이 쌓였고,
"LazyVim 이 이미 해주는가"를 확인하는 단계가 없었다.

각 Phase = 커밋 1개. 끝난 항목은 `[x]`.

---

## Phase 0 — 규칙 (코드 변경 없음)

- [x] **키맵**: LazyVim 그룹 prefix(`<leader>s` 검색 · `t` 테스트 · `d` 디버그 · `n` 알림 · `<tab>` 탭 · `w` 창) 침범 금지. 개인 키맵은 빈 prefix 에만
- [x] **추가 전 확인**: `:LazyExtras` → LazyVim 소스 grep → 없을 때만 추가
- [x] **스타일**: `opts` 우선, `config = function()` 금지(예외는 주석으로 이유 명시). 플랫 `return { ... }`. 주석 한국어. LazyVim 문서 복붙 금지
- [x] **레이아웃**: 플러그인 오버라이드는 전부 `lua/plugins/`. LSP 서버는 `lua/plugins/lsp.lua` 한 파일

## Phase 1 — 삭제 (리스크 0, 동작 변화 없음)

- [x] `lua/plugins/ts-comment.lua` 삭제 — LazyVim 기본 포함
- [x] `lua/plugins/dressing.lua` 삭제 — archived, `snacks.input` 을 가로채고 있음
- [x] `lua/lsp/vtsls.lua` 삭제 — `updateImportsOnFileMove` LazyVim 동일, `autoImports` vtsls 기본 true
- [x] `lua/lsp/jdtls.lua` 삭제 — java extra 가 lombok 을 이미 주입 (이중 javaagent)
- [x] `lua/plugins/bufferline.lua` 삭제 — opts 전부 주석, `version="*"` 잠재 핀, devicons dep 불필요
- [x] `lua/plugins/trouble.lua` 삭제 — 유일한 opt `use_diagnostic_signs` 가 v3 에 없음 → 파일 전체 no-op
- [x] `lua/plugins/todo-comment.lua` 삭제 — `config = setup()` 이 LazyVim opts 를 덮어쓰던 것 외엔 전부 LazyVim 과 동일
- [x] `lua/plugins/nvim-treesitter.lua` 삭제 — 나열한 파서 18개 전부 LazyVim 기본 + python extra 에 이미 포함, highlight/indent/folds 도 기본값
- [x] `lua/plugins/snacks.lua` — `image.enable` → `enabled`
- [x] `lua/plugins/nvim-lspconfig.lua` — `diagnostics.float.border`(winborder 대체) · 구주석 · 빈 `ruff` 블록 · pyright `autoImportCompletion` 오타(정식 키 `autoImportCompletions`, 기본 true) 제거. D1 반영
- [x] `lua/plugins/docstrings.lua` — `ft=` 가 있어 무의미한 `cmd` 트리거 제거 (`keys` 는 `<leader>cD` 정의라 유지)
- [x] `lua/config/keymaps.lua` — LazyVim 중복 제거: `mapleader`, `]t`/`[t`, `<leader>sv/sh/se/sx`, 탭 5개, `<leader>nh`. 남긴 것: `jk`, `<leader>fh`
- [x] `lua/config/lazy.lua` — `{ import = "lsp" }` 제거 (Phase 3 에서 앞당김: `lua/lsp/` 에 `.bak` 만 남아 빈 모듈이 됨)

## Phase 2 — 충돌 해소 (LazyVim 기능 회복)

- [x] `<leader>tt` / `<leader>to` 를 neotest 에 반환 — `toggleterm.lua` 삭제, 플로팅 터미널은 `<C-\>` 로 snacks.terminal (D2)
- [x] `<leader>sh` 를 snacks Help Pages 에 반환 (Phase 1 keymaps 삭제로 해결)
- [x] `<leader>n` 알림 히스토리 지연 해소 (Phase 1 `<leader>nh` 삭제로 해결)
- [x] `docstrings.lua` — `vim.g.doge_*` 설정을 `config` → `init` 으로. `<leader>d` DAP 그룹 overlap 해소 (실측: `<leader>d` doge 매핑 소멸)
- [x] which-key health — 내 키맵 기인 overlap 0. 남은 1건(`<leader>dP` ↔ `dPc`/`dPt`)은 LazyVim python·dap extra 자체 것

## Phase 3 — 구조 재편

- [x] `lua/config/lazy.lua` 하드코딩 extras(typescript · json · toml · python · clangd) → `lazyvim.json` 으로 이동. 실측: 플러그인 55 · extras 22 · LSP 서버 25 로 전후 동일, `LazyVim.has_extra()` 5개 모두 true
- [x] `lua/plugins/nvim-lspconfig.lua` → `lua/plugins/lsp.lua` 로 rename
- [x] `lazy.lua` 의 `{ import = "lsp" }` 제거 (Phase 1 에서 처리)
- [ ] `lua/lsp/` 디렉토리 — `typescript.lua.bak` 만 남음. 백업 보존 정책상 유지, 단 새 파일 넣지 말 것

## Phase 4 — 성능 · 관용구

- [x] `lua/utils/system-color.lua` 삭제 — nvim TUI 의 터미널 배경 자동 감지(`:h 'background'`) + tokyonight `light_style = "day"` 로 대체. 셸 호출 0. 실측: background light/dark 전환 시 `tokyonight-day` ↔ `tokyonight-moon` 자동 재로드 (D 결정 (a))
- [x] `lua/plugins/colorscheme.lua` — `init = colorscheme("tokyonight")` 제거, LazyVim 기본 로더에 위임 (이중 적용 해소)
- [x] `nvim --startuptime` — 136ms(리팩터 전, 단일 측정) → **67ms**(Phase 4 후, 3회 중 최소). Phase 1 플러그인 삭제 + popen 제거 효과
- [ ] ghostty `~/.config/ghostty/config` 를 `theme = light:TokyoNight Day,dark:TokyoNight Moon` 으로 (저장소 밖, 수동 적용)

## Phase 5 — 설계 결정 반영

- [x] D1 pyright/ruff 역할 확정 → `nvim-lspconfig.lua` 반영 (Phase 1 에서 처리)
- [x] D2 터미널 단일화 → snacks.terminal 3 레이아웃 (`<C-/>` bottom · `<leader>fh` right · `<C-\>` float), Phase 2 에서 처리
- [ ] D3 tree-sitter CLI — `brew install tree-sitter` 또는 감수 (mason 것은 mason 로드 후에만 PATH)
- [ ] D4 mason `rust-analyzer` — rustup 것으로 통일할지
- [ ] README 키맵 표 · 알아둘 점 갱신

---

## 결정 기록 (D)

| # | 주제 | 결정 | 날짜 |
|---|---|---|---|
| D1 | pyright 진단 끄고 ruff 만 진단 / 완성·이동은 pyright | **(a) 채택.** `analysis.ignore = {"*"}` 유지, `typeCheckingMode` 삭제. 타입 에러는 안 보임을 인지 | 2026-09-08 |
| D2 | toggleterm 제거, snacks.terminal 로 float·bottom·right | **`<C-\>` 채택.** `<leader>tt`/`to` 는 neotest 에 반환. float 인스턴스는 `count = 9` 로 분리 | 2026-09-08 |
| D3 | tree-sitter CLI | | |
| D4 | rust-analyzer 출처 | | |
