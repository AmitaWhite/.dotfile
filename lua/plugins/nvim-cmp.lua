--nvim-cmp 는 complementaion(자동완성) 기능
--settings for complementaion
return {
  -- override nvim-cmp and add cmp-emoji

  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, { name = "emoji" })
  end,
}
