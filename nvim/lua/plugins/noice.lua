-- diganostics 설정
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      hover = {
        border = {
          style = "rounded",
        },
        position = { row = 2, col = 2 },
      },
    },
    routes = {
      {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            local client = message.opts and message.opts.client
            return client == "jdtls"
          end,
        },
        opts = { skip = true },
      },
    },
  },
}
