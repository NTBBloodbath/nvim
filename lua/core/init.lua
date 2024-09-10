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

---Make notifications not block the editor on launch, it is disgusting
---@diagnostic disable-next-line
vim.notify = function(msg, ...)
  vim.schedule(function()
    print(msg)
  end)
end

--- Language Server Protocols
require("core.lsp")

--- Better notifications with nvim-notify. Nothing really significant
--- happens during the startup so I do not need to load it too early.
vim.defer_fn(function()
  local ok, notify = pcall(require, "notify")
  if ok then
    notify.setup({ level = 0, fps = 75, render = "compact", top_down = false })
    vim.notify = notify
  end
end, 100)

--- init.lua ends here
