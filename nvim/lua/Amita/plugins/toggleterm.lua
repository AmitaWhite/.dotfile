return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-/>]],
			-- direction = 'float',
			direction = "horizontal",
			-- add size option
			size = 11,
			-- nvimTree 와 충돌 방지
			shade_terminals = false,
			-- Terminal 진입시 insert mode
			start_in_insert = true,
		})
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { noremap = true, silent = true }) -- 왼쪽으로 이동
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { noremap = true, silent = true }) -- 아래로 이동
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { noremap = true, silent = true }) -- 위로 이동
		vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { noremap = true, silent = true }) -- 오른쪽으로 이동
	end,
}
