-- 현재 시스템 스타일에 따라 동적으로 스타일 결정
local util = require("utils.system-color")
local current_style = util.get_system_colorscheme_style()

-- transparent group 지정 (inline 힌트나, diagnostic 추가 텍스트 같은거)
local transparent_groups = {
  "^DiagnosticVirtualText",
  "^LspInlayHint",
  "^TSDefinition",
  "^TSDefinitionUsage",
}

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
        -- commet 에 대한거
        hl.Comment = { fg = "#B48EAD", italic = true }

        -- theme 에서 지원하지 않는 그룹들
        for group, opts in pairs(hl) do
          for _, pattern in ipairs(transparent_groups) do
            if group:match(pattern) then
              opts.bg = "none"
            end
          end
        end
      end,
    },
    init = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
