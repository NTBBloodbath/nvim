--- bootstrap.lua - Neovim setup dependencies bootstrapping
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local function installed(dep)
  return vim.fn.isdirectory(vim.fn.expand(dep)) == 1
end

local function ensure(dep, path)
  if installed(path) then
    return
  end

  vim.notify("Installing '" .. dep .. "', please wait ...")
  vim.fn.system({
    "git",
    "clone",
    "--no-tags",
    "--single-branch",
    "--filter=blob:none",
    "https://github.com/" .. dep .. ".git",
    path,
  })

  if vim.v.shell_error ~= 0 then
    vim.notify(
      "Failed to install '" .. dep .. "', please relaunch Neovim to try again.",
      vim.log.levels.ERROR
    )
  else
    vim.notify(
      "Successfully installed '" .. dep .. "' at '" .. vim.fn.expand(path) .. "'",
      vim.log.levels.INFO
    )
  end
end

vim.defer_fn(function()
	--- Plugin manager
	local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	ensure("folke/lazy.nvim", lazy_path)

	--- Colorscheme
	-- NOTE: perhaps this is not required as lazy is going to be an ass to manage it?
	-- ensure("NTBBloodbath/doom-one.nvim", "extern/doom-one.nvim")
end, 0)

--- bootstrap.lua ends here
