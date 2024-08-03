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

vim.api.nvim_create_user_command("ToggleCommentsInsertion", function()
  local comment_opts = { "c", "r", "o" }

  --- I add and remove cro at the same time so checking for only one of them is enough
  if not vim.tbl_contains(vim.tbl_keys(vim.opt.formatoptions:get()), "c") then
    for _, opt in ipairs(comment_opts) do
      vim.opt.formatoptions:append(opt)
    end
    vim.notify("[core.commands] Enabled automatic comments insertion")
  else
    for _, opt in ipairs(comment_opts) do
      vim.opt.formatoptions:remove(opt)
    end
    vim.notify("[core.commands] Disabled automatic comments insertion")
  end
end, { desc = "Toggle automatic comments insertion" })

--- commands.lua ends here
