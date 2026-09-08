-- 다크/라이트 전환은 nvim 이 터미널 배경색을 자동 감지해 'background' 를 세팅하고(:h 'background'),
-- tokyonight 가 background=light 일 때 light_style 을 쓰는 방식으로 처리한다. (셸 호출 없음)
-- 터미널(ghostty) 쪽도 OS 테마를 따라가도록 theme = light:...,dark:... 로 둬야 실제로 전환된다.

-- 테마가 배경을 칠하지 않게 할 하이라이트 그룹 (transparent 와 맞추기 위해)
local transparent_groups = {
  "^DiagnosticVirtualText",
  "^LspInlayHint",
  "^TSDefinition",
  "^TSDefinitionUsage",
}

return {
  "folke/tokyonight.nvim",
  opts = {
    style = "moon", -- background=dark 일 때
    light_style = "day", -- background=light 일 때
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl)
      for group, opts in pairs(hl) do
        for _, pattern in ipairs(transparent_groups) do
          if group:match(pattern) then
            opts.bg = "none"
          end
        end
      end
    end,
  },
  -- colorscheme 적용은 LazyVim 이 한다 (기본값 tokyonight). 여기서 init 으로 또 부르면 이중 적용.
}
