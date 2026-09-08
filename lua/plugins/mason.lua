-- mason 으로 설치할 도구들
return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "rust-analyzer",
      "lemminx", -- XML LSP
    },
    -- ui.border 는 vim.o.winborder ("rounded") 를 따라감 (config/options.lua)
  },
}
