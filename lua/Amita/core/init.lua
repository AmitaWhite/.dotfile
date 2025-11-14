-- Prepend Mason's bin directory to the PATH
-- This allows nvim-lint and other tools to find executables installed by Mason
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

require("Amita.core.options")
require("Amita.core.keymaps")
