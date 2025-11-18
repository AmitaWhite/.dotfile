-- 현재 시스템 스타일에 따라 동적으로 스타일 결정
local util = require("utils.system-color")
local current_style = util.get_system_colorscheme_style()

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup({
        style = current_style, -- 동적으로 결정된 스타일 적용
        transparent = true,
        on_highlights = function() end,
        on_colors = function() end,
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
      -- 주석 색상 변경 (밝고 진한 보라색)
      vim.api.nvim_set_hl(0, "Comment", { fg = "#B48EAD", italic = true })
    end,
  },
}
