--- init.lua - Core init
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Sane defaults
require("core.config")

--- UI
require("core.ui")

--- Saner netrw, not using it at the moment
-- require("core.netrw")

--- Commands
require("core.commands")

--- Autocommands
require("core.autocmds")

--- Keybindings
require("core.maps")

--- Better notifications
local ok, notify = pcall(require, "notify")
if ok then
  ---@diagnostic disable-next-line
  notify.setup({ level = 0 })
  vim.notify = notify
end

--- Language Server Protocols
require("core.lsp")

--- NOTE: this is just temporal
-- require("plugins.neocomplete")

--- init.lua ends here
