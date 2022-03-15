-- use opt-in filetype.lua instead of vimscript default in Neovim nightly
-- EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
if vim.fn.has("nvim-0.7.0") == 1 then
  vim.g.did_load_filetypes = 1
  vim.g.do_filetype_lua = 1
end

-- Temporarily disable syntax and filetype to improve startup time
vim.cmd([[
  syntax off
  filetype off
  filetype plugin indent off
]])

vim.opt.shadafile = "NONE"

local pack_path = vim.fn.stdpath("data") .. "/site/pack"

--- Ensures a given repository is cloned in the pack path
local function ensure(repo, kind)
  local repo_name = vim.split(repo, "/")[2]
  local install_path = string.format("%s/packer/%s/%s", pack_path, kind, repo_name)

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.notify("Installing '" .. repo .. "', please wait ...")
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/" .. repo,
      install_path,
    })
    if vim.v.shell_error ~= 0 then
      vim.notify(
        "Failed to install '" .. repo .. "', please restart to try again",
        vim.log.levels.ERROR
      )
    else
      vim.notify("Successfully installed '" .. repo .. "'", vim.log.levels.INFO)
    end
  end
end

--- Check if given plugin is installed locally so we can load it later
local function is_plugin_installed(plugin_name, kind)
  kind = kind or "opt"
  return vim.fn.empty(vim.fn.glob(string.format("%s/packer/%s/%s", pack_path, kind, plugin_name)))
    == 0
end

-- BUG: It seems like impatient doesn't like aniseed so impatient is disabled at the moment
-- Load impatient and enable caching
-- if vim.fn.empty(vim.fn.glob(pack_path .. "/packer/opt/impatient.nvim")) == 0 then
--   vim.cmd("packadd impatient.nvim")
--   require("impatient").enable_profile()
-- end

-- Load aniseed
if is_plugin_installed("aniseed") then
  -- Uncomment to enable automatic compilation
  -- and loading of Fennel source code
  -- NOTE: this is going to add a 20ms average to startup time,
  --       consider disabling if not making changes to config to speed up things
  vim.g["aniseed#env"] = {
    module = "core.init",
  }
  vim.cmd("packadd aniseed")
end

-- Defer installation of required plugins and colorscheme loading
vim.defer_fn(function()
  -- Load setup, uncomment if automatic loading is commented
  -- require("core")

  vim.opt.shadafile = ""
  vim.cmd([[
    rshada!
    syntax on
    filetype on
    filetype plugin indent on
  ]])

  -- Caching because why not?
  -- ensure("lewis6991/impatient.nvim", "opt")

  -- Packer, sadly my plugins manager
  ensure("wbthomason/packer.nvim", "opt")

  -- Aniseed, Fennel core
  ensure("Olical/aniseed", "opt")

  -- Colorscheme
  ensure("NTBBloodbath/doom-one.nvim", "opt")
  if is_plugin_installed("doom-one.nvim") then
    vim.cmd([[
      packadd doom-one.nvim
      colorscheme doom-one
    ]])
  end

  if is_plugin_installed("nvim-treesitter") then
    vim.cmd("PackerLoad nvim-treesitter")
  end
  if is_plugin_installed("nvim-gps") then
    vim.cmd("PackerLoad nvim-gps")
  end
  if is_plugin_installed("heirline.nvim") then
    vim.cmd("PackerLoad heirline.nvim")
  end
  if is_plugin_installed("telescope.nvim") then
    vim.cmd("PackerLoad telescope.nvim")
  end

  -- Fix some plugins stuff, e.g. treesitter modules
  vim.cmd("doautocmd BufEnter")
end, 0)
