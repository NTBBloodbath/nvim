--- init.lua - Neovim init file
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbatb/nvim
-- License: GPLv3
--
--- Code:

-- Set colorscheme
vim.g.colorscheme = "sweetie"

-- Set keyboard layout. I've switched to Dvorak in my workstation
-- but my laptop is still using QWERTY
vim.g.layout = "qwerty"

-- rocks.nvim setup
local rocks_config = {
    rocks_path = "/home/alejandro/.local/share/nvim/rocks",
    luarocks_binary = "/home/alejandro/.local/share/nvim/rocks/bin/luarocks",
}
vim.g.rocks_nvim = rocks_config

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "?.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "*", "*"))

-- Fix treesitter
vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "share", "lua"))

-- Load configuration core
local loaded_core, core_err = xpcall(require, debug.traceback, "core")
if not loaded_core then
  vim.notify_once(
    string.format("There was an error requiring 'core'. Traceback:\n%s", core_err),
    vim.log.levels.ERROR
  )
end

--- init.lua ends here
