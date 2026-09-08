-- mason 으로 설치할 도구들
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "lemminx", -- XML LSP
      -- rust-analyzer 는 mason 이 아니라 rustup component 로 (툴체인과 버전 일치, D4)
    },
    -- ui.border 는 vim.o.winborder ("rounded") 를 따라감 (config/options.lua)
  },
}
