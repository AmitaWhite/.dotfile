local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
-- Disable deprecation warnings temporarily
vim.deprecate = function() end
-- init.lua 또는 관련 설정 파일에 추가
require("Amita.core")
require("Amita.lazy")
