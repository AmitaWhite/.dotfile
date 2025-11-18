return {
  "nvim-telescope/telescope.nvim",
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, "folke/todo-comments.nvim" },
  -- starter preset 의 keymap 설정 충돌이 있어서 해제
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
      },
      opts = {
        default = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
      },
    })
    telescope.load_extension("fzf")
  end,
}
