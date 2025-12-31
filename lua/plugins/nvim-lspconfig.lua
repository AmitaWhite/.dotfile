-- nvim-lspconfig 는 nvim과 lsp가 소통할 수 있게 해주는 관리자
return {
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {},
      diagnostics = {
        float = {
          border = "rounded",
          source = "always",
        },
      },
    },
  },
}
