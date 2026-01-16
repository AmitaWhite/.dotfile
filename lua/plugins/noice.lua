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
  },
}
