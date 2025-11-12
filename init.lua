-- Disable deprecation warnings temporarily
vim.deprecate = function() end
-- init.lua 또는 관련 설정 파일에 추가
-- vscode neovim 사용 할 떄엔 lazy 에서, lsp 랑  아마도 플러그인도 다 뺄듯
if vim.g.vscode then
	require("Amita.lazy")
else
	require("Amita.core")
	require("Amita.lazy")
end

