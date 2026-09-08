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

-- mason 이 설치한 도구(tree-sitter-cli 등)를 mason 이 로드되기 전에도 찾을 수 있게 PATH 앞에 둔다.
-- mason 은 lazy-load 라, 대시보드에서 바로 :TSUpdate 하거나 :Lazy sync 의 build 단계에서는
-- 아직 PATH 에 없어 tree-sitter CLI 를 못 찾는다. (D3 — brew 의 tree-sitter-cli 는 Intel 맥에서 llvm+rust 를 끌어옴)
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
