-- 현재 시스템 스타일에 따라 동적으로 스타일 결정
local util = require("utils.system-color")
local current_style = util.get_system_colorscheme_style()

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins

    opts = {
      style = current_style,
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl.Comment = { fg = "#B48EAD", italic = true }
      end,
    },
    init = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
