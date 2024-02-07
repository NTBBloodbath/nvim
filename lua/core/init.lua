--- init.lua - Core init
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Sane defaults
require("core.config")

--- Saner netrw, not using it at the moment
-- require("core.netrw")

--- Autocommands
require("core.autocmds")

--- Keybindings
require("core.maps")

--- Better notifications
local ok, notify = pcall(require, "notify")
if ok then
  notify.setup({ level = 0 })
  vim.notify = notify
end

--- UI
--- Loads colorscheme so we gotta wait for lazy to load plugins first
require("core.ui")

--- init.lua ends here
