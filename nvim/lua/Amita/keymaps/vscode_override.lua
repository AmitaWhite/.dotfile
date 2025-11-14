-- vscode 환경일 때만 로드 됨

local vscode = require('vscode')
local keymap = vim.keymap

-- [창 분할 및 닫기]
-- 수직 분할 - 그룹분할됨
keymap.set("n","<leader>sv",function()
    vscode.action("workbench.action.splitEditorRight")
end, {desc = "VSC: Split window vertically"})

-- 수평분할 - 그룹분할됨
keymap.set("n","<leader>sh",function()
    vscode.action("workbench.action.splitEditorDown")
end, {desc = "VSC: Split window horizontally"})

-- # 탭 이동은 ctrl+tab(다음) , ctrl+shift+tab(이전) 되긴 하지만 하나씩 넘기는 것도 쓸만함
-- [탭 이동 및 관리]
keymap.set("n", "<leader>to", function()
  vscode.action('workbench.action.files.newUntitledFile')
end, { desc = "VSC: Open new tab (Untitled)" })

-- 다음 탭 (<leader>tn)
keymap.set("n", "<leader>tn", function()
  vscode.action('workbench.action.nextEditorInGroup')
end, { desc = "VSC: Go to next tab" })

-- 이전 탭 (<leader>tp)
keymap.set("n", "<leader>tp", function()
  vscode.action('workbench.action.previousEditorInGroup')
end, { desc = "VSC: Go to previous tab" })

-- 1. 파일 트리 (탐색기) 토글
-- focus 만 주고, 동일 커맨드로 다시 돌아오는 게 안됨 -> 파일을 sideview 에서는 editorfocus 때랑 action 이 다른듯
 keymap.set("n", "<leader>ee", function()
  vscode.action('workbench.view.explorer') -- 탐색기 뷰를 토글
end, { desc = "VSC: Toggle File Explorer (nvim-tree 대체)" })

-- 2. 파일 검색 토글 (VS Code의 Ctrl+P 명령어)
keymap.set("n", "<leader>ff", function()
  vscode.action('workbench.action.quickOpen') -- 파일 검색
end, { desc = "VSC: Toggle Quick Open (Telescope 대체)" })