return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup()
  end,
}

-- TODO: lua-line 설정
-- TODO: ToggleTerm 설정
-- TODO: tree 백그라운드 색 제거
