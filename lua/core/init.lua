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

--- Autocommands
require("core.autocmds")

--- Keybindings
require("core.maps")

--- Plugins
require("core.lazy")

--- UI
--- Loads colorscheme so we gotta wait for lazy to load plugins first
require("core.ui")

--- init.lua ends here
