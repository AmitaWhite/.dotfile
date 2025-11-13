local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
	{ { import = "Amita.plugins", cond = not vim.g.vscode } },
	{
		checker = {
			enabled = true,
			notify = false,
		},
		change_detection = {
			notify = false,
		},
	}
)

-- Leaderkey 를 keymaps.lua 외에 추가 설정하는 이유?
-- vscode neovim 사용 할 때에 core는 빼고, vscode에 다른 keymaps 파일을
-- 올리기 위해 한 번 더 설정함
vim.g.mapleader = " "
if vim.g.vscode then
	require("Amita.keymaps.vscode_override")
end

