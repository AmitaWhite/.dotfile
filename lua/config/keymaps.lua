-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- LazyVim 기본 키맵과 겹치지 않는 개인 키맵만 둔다 (REFACTOR.md Phase 0 규칙)
-- 창 분할 <leader>- <leader>| / 탭 <leader><tab>* / 검색 하이라이트 해제 <Esc> 는 LazyVim 기본 사용

local keymap = vim.keymap

-- jk 로 insert 모드 탈출
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- 오른쪽 세로 터미널
keymap.set("n", "<leader>fh", function()
  Snacks.terminal(nil, {
    count = 5,
    win = {
      position = "right",
      width = 0.4,
    },
  })
end, { desc = "Terminal (Right Vertical)" })
