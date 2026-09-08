-- LSP 서버 설정 (Phase 3 에서 lua/plugins/lsp.lua 로 통합 예정)
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- D1 결정: 진단은 ruff 만, pyright 는 완성 · 정의 이동 · hover 담당
      -- analysis.ignore = {"*"} 는 pyright 의 "진단 출력"만 억제하고 나머지 기능은 유지한다
      -- (ruff 쪽 hover 비활성은 LazyVim python extra 가 처리)
      pyright = {
        settings = {
          python = {
            analysis = {
              ignore = { "*" },
            },
          },
        },
      },
      postgres_lsp = {},
    },
  },
}
