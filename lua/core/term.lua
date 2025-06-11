--- term.lua - Core persistent terminal
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Terminal's TermClose autocommand ID
vim.g.term_au = nil
--- Terminal window ID
vim.g.term_win = nil
--- Terminal buffer ID
vim.g.term_buf = nil
--- Terminal job PID
vim.g.term_pid = nil

---@param force? boolean
local function close(force)
  vim.api.nvim_win_close(vim.g.term_win, true)
  vim.g.term_win = nil

  if force then
    if vim.g.term_buf and vim.api.nvim_buf_is_valid(vim.g.term_buf) then
      vim.api.nvim_buf_delete(vim.g.term_buf, { force = true })
      vim.g.term_buf = nil
    end

    if vim.g.term_pid then
      vim.fn.jobstop(vim.g.term_pid)
      vim.g.term_pid = nil
    end

    if vim.g.term_au then
      vim.api.nvim_del_autocmd(vim.g.term_au)
      vim.g.term_au = nil
    end
  end
end

local function open()
  -- Re-use existing terminal buffer if available
  if vim.g.term_buf and vim.api.nvim_buf_is_loaded(vim.g.term_buf) then
    vim.cmd("belowright split")
    vim.api.nvim_win_set_buf(0, vim.g.term_buf)
    vim.cmd("resize 15")
  else
    -- Create new terminal
    vim.cmd("belowright 15 split | terminal")
    vim.g.term_buf = vim.api.nvim_get_current_buf()
    vim.g.term_pid = vim.fn.jobpid(vim.o.channel)
  end
  vim.g.term_win = vim.api.nvim_get_current_win()

  vim.g.term_au = vim.api.nvim_create_autocmd("TermClose", {
    buffer = vim.g.term_buf,
    callback = function()
      close(true)
    end,
  })
end

vim.api.nvim_create_user_command("ToggleTerm", function()
  if vim.g.term_win and vim.api.nvim_win_is_valid(vim.g.term_win) then
    close()
  else
    open()
  end
end, {
  desc = "Toggle persistent terminal in a horizontal split",
})

--- init.lua ends here
