--- commands.lua - Commands
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

vim.api.nvim_create_user_command("SudoWrite", function()
  require("utils.sudo_write").write()
end, { desc = "Write file with sudo permissions" })

--- commands.lua ends here
