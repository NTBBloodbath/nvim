--- lazy.lua - Lazy.nvim setup
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Lazy.nvim
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Add lazy.nvim to Neovim runtime path
if vim.fn.isdirectory(lazy_path) == 1 then
  vim.opt.rtp:prepend(lazy_path)
  require("lazy").setup("modules", {
    defaults = {
      lazy = true,
    },
    concurrency = 20,
    git = {
      timeout = 300, -- 5 mins
      url_format = "git@github.com:%s.git",
    },
    dev = {
      path = "~/Development/Nvim",
    },
    install = {
      colorscheme = { "sweetie", "doom-one", "lunaperche" },
    },
    ui = {
      border = "rounded",
    },
    performance = {
      rtp = {
        reset = false,
      },
    },
  })
end

--- Luarocks stuff
local luarocks_path = {
  table.concat({ vim.env.HOME, ".luarocks", "share", "lua", "5.1", "?.lua" }, "/"),
  table.concat({ vim.env.HOME, ".luarocks", "share", "lua", "5.1", "?", "init.lua" }, "/"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = table.concat({ vim.env.HOME, ".luarocks", "lib", "lua", "5.1", "?.so" }, "/")
package.cpath = package.cpath .. ";" .. luarocks_cpath

--- lazy.lua ends here
