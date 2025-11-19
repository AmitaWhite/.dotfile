return {
  "nvim-telescope/telescope.nvim",
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, "folke/todo-comments.nvim" },

  defaults = { path_display = { "smart" } },
  opts = {
    default = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblent = 0,
    },
  },

  config = function()
    require("telescope").load_extension("fzf")
  end,
}
