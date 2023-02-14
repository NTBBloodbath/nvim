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
require("core.lazy")

--- init.lua ends here
