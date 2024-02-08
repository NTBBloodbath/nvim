--- quit.lua - Doom Emacs' doom-quit port to Neovim
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local quit_messages = {
  -- Doom 1
  "Please don't leave, there's more demons to toast!",
  "I wouldn't leave if I were you. DOS is much worse.",
  "Don't leave yet -- There's a demon around that corner!",
  "Ya know, next time you come in here I'm gonna toast ya.",
  "Go ahead and leave. See if I care.",
  "Are you sure you want to quit this great editor?",
  -- Portal
  "You can't fire me, I quit!",
  "I don't know what you think you are doing, but I don't like it. I want you to stop.",
  "This isn't brave. It's murder. What did I ever do to you?",
  "I'm the man who's going to burn your house down! With the lemons!",
  "Okay, look. We've both said a lot of things you're going to regret...",
  -- Custom
  "Go ahead and leave. I'll convert your code to Fennel!",
  "Neovim will remember that.",
  "Please don't leave, otherwise I'll tell packer to break your setup on next launch!",
  "It's not like I'll miss you or anything, b-baka!",
  "You are *not* prepared!",
}

local function going_to_quit()
  local open_buffers = 0
  for buf = vim.fn.bufnr(1), vim.fn.bufnr("$") do
    if vim.fn.bufloaded(buf) == 1 then
      open_buffers = open_buffers + 1
    end
  end
  return open_buffers == 1
end

local function confirm_quit(save, last_buffer)
  local buftype = vim.api.nvim_buf_get_option(0, "buftype")
  local msg =
    string.format("%s  %s", quit_messages[math.random(#quit_messages)], "Really quit Neovim?")

  if buftype == "help" or buftype == "nofile" then
    vim.api.nvim_command("quit")
  elseif last_buffer and going_to_quit() then
    vim.api.nvim_command("quit")
  elseif vim.fn.confirm(msg, "&Yes\n&No", 2) == 1 then
    if save and vim.api.nvim_buf_get_option(0, "modified") then
      vim.api.nvim_command("wqa")
    else
      vim.api.nvim_command("qa")
    end
  end
end

return { confirm_quit = confirm_quit }

--- quit.lua ends here
