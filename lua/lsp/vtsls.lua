return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            javascript = {
              suggest = {
                autoImports = true,
              },
              updateImportsOnFileMove = { enabled = "always" },
            },
            typescript = {
              suggest = {
                autoImports = true,
              },
              updateImportsOnFileMove = { enabled = "always" },
            },
          },
        },
      },
    },
  },
}
