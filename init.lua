--- init.lua - Neovim init file
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

-- Do not load Neovim runtime plugins automatically
-- vim.opt.loadplugins = false

-- Manually load runtime Man plugin to use Neovim as my man pager
vim.api.nvim_command("runtime! plugin/man.lua")

-- Enable the experimental Lua module loader, slightly improves startup time
vim.loader.enable()

-- Set colorscheme
vim.g.colorscheme = "sweetie"

-- Set keyboard layout. I've switched to Dvorak in my workstation
-- but my laptop is still using QWERTY
vim.g.layout = "qwerty"

-- rocks.nvim config and bootstrapping {{{
do
  -- Specifies where to install/use rocks.nvim
  ---@diagnostic disable-next-line param-type-mismatch
  local install_location = vim.fs.joinpath(vim.fn.stdpath("data"), "rocks")

  -- Set up configuration options related to rocks.nvim (recommended to leave as default)
  local rocks_config = {
    rocks_path = vim.fs.normalize(install_location),
  }
  -- I have to manually compile Lua5.1 on MacOS. Thank you, homebrew
  if jit.os == "OSX" then
    rocks_config.luarocks_config = {
      variables = {
        LUA = "/usr/local/bin/lua5.1",
        LUA_BINDIR = "/usr/local/bin",
        LUA_DIR = "/usr/local",
        LUA_INCDIR = "/usr/local/include/lua",
        LUA_VERSION = "5.1",
      },
    }
  elseif vim.env.NIX_PATH then
    -- HACK: Nix does not expose development headers by default,
    -- so I extract the relevant header files from the lua5.1
    -- tarball and it seems to do the trick.
    rocks_config.luarocks_config = {
      variables = {
        LUA_INCDIR = vim.env.HOME .. "/Develop/Nvim/lua-inc",
      },
    }
  end
  vim.g.rocks_nvim = rocks_config

  -- Configure the package path (so that plugin code can be found)
  local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
  }
  package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

  -- Configure the C path (so that e.g. tree-sitter parsers can be found)
  local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
  }
  package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

  -- Load all installed plugins, including rocks.nvim itself
  vim.opt.runtimepath:append(
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*")
  )
end

-- If rocks.nvim is not installed then install it!
if not pcall(require, "rocks") then
  ---@diagnostic disable-next-line param-type-mismatch
  local rocks_location = vim.fs.joinpath(vim.fn.stdpath("cache"), "rocks.nvim")
  ---@diagnostic disable-next-line undefined-field
  if not vim.uv.fs_stat(rocks_location) then
    -- Pull down rocks.nvim
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/nvim-neorocks/rocks.nvim",
      rocks_location,
    })
  end

  -- If the clone was successful then source the bootstrapping script
  assert(
    vim.v.shell_error == 0,
    "rocks.nvim installation failed. Try exiting and re-entering Neovim!"
  )

  vim.cmd.source(vim.fs.joinpath(rocks_location, "bootstrap.lua"))

  vim.fn.delete(rocks_location, "rf")
end
-- }}}

-- Load configuration core
local loaded_core, core_err = xpcall(require, debug.traceback, "core")
if not loaded_core then
  vim.notify_once(
    string.format("There was an error requiring 'core'. Traceback:\n%s", core_err),
    vim.log.levels.ERROR
  )
end

-- Manually load Neovim runtime
-- WARN: enable only if using 'vim.g.loadplugins'
-- vim.defer_fn(function()
--   vim.api.nvim_command("runtime! plugin/**/*.vim")
--   vim.api.nvim_command("runtime! plugin/**/*.lua")
-- end, 0)

-- vim: fdm=marker:fdl=0
--- init.lua ends here
