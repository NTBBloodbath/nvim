--- init.lua - Core init
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Sane defaults
require("core.config")

--- Saner netrw
require("core.netrw")

--- UI
require("core.ui")

--- Autocommands
require("core.autocmds")

--- Keybindings
require("core.maps")

--- Plugins
require("modules")

-- Packer compiled file
local packer_compiled_path = table.concat({ vim.fn.stdpath("config"), "lua", "packer_compiled.lua" }, "/")
if vim.fn.filereadable(packer_compiled_path) == 1 then
	require("packer_compiled")
end

--- init.lua ends here
