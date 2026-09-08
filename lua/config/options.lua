-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 줄바꿈
vim.opt.wrap = true
-- 단어 단위로 줄 바꿈
vim.opt.linebreak = true
-- SQLcl 사용시 , 결과 파싱 오류 방지 설정
-- vim.g.dbext_default_ORA_bin = "sql"
vim.opt.termguicolors = true

-- 전역 창 테두리 (nvim 0.11+). blink.cmp / mason / lspconfig float 등
-- winborder 를 존중하는 플러그인은 이 한 줄로 모두 rounded 처리됨
vim.opt.winborder = "rounded"
