return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				on_highlights = function(hl, c) end,
				on_colors = function(colors) end,
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
			-- 주석 색상 변경 (밝고 진한 보라색)
			vim.api.nvim_set_hl(0, "Comment", { fg = "#B48EAD", italic = true })
		end,
	},
}
