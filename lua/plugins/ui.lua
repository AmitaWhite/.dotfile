return {
  {
    "m00qek/baleia.nvim",
    version = "*",
    config = function()
      vim.g.baleia = require("baleia").setup({
        line_starts_at = 1,
        log_level = "error",
      })
    end,
  },
}
