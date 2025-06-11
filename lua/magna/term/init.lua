--- init.lua - Magna picker init
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

vim.g.term_win = nil
vim.g.term_buf = nil

vim.api.nvim_create_user_command("ToggleTerm", function()
  if vim.g.term_win and vim.api.nvim_win_is_valid(vim.g.term_win) then
    vim.api.nvim_win_close(vim.g.term_win, true)
    vim.g.term_win = nil
    return
  end

  -- Re-use existing terminal buffer if available
  if vim.g.term_buf and vim.api.nvim_buf_is_loaded(vim.g.term_buf) then
    vim.cmd("belowright split")
    vim.api.nvim_win_set_buf(0, vim.g.term_buf)
    vim.cmd("resize 15")
  else
    -- Create new terminal
    vim.cmd("belowright 15 split | terminal")
    vim.g.term_buf = vim.api.nvim_get_current_buf()
  end
  vim.g.term_win = vim.api.nvim_get_current_win()
end, {
  desc = "Toggle persistent terminal in a horizontal split",
})

--- init.lua ends here
