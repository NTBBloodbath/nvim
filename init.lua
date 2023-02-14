--- init.lua - Neovim init file
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbatb/nvim
-- License: GPLv3
--
--- Code:

-- Set colorscheme
vim.g.colorscheme = "doom-one"

-- Enable first-class Lua tree-sitter parser highlights
vim.g.ts_highlight_lua = true

-- Load configuration core
local loaded_core, core_err = xpcall(require, debug.traceback, "core")
if not loaded_core then
	vim.notify_once(string.format("There was an error requiring 'core'. Traceback:\n%s", core_err), vim.log.levels.ERROR)
end

--- init.lua ends here
