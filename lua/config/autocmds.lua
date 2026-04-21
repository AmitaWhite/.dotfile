-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- DBUI 결과창(dbout)에 ANSI 색상 입히기
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost" }, {
  pattern = { "*.dbout", "dbout" },
  callback = function()
    if vim.g.baleia then
      -- 버퍼를 수정 가능한 상태로 잠시 변경
      vim.bo.modifiable = true
      vim.g.baleia.once(vim.api.nvim_get_current_buf())
      -- 변환 후 수정됨(modified) 표시 해제
      vim.bo.modified = false
    end
  end,
})
