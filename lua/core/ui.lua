--- ui.lua - UI Configurations
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local function is_installed(name)
  local path = ("%s/lazy/%s"):format(vim.fn.stdpath("data"), name)
  return vim.fn.isdirectory(path) == 1
end

local wanted_colorscheme = vim.g.colorscheme
local colorscheme_name = wanted_colorscheme .. ".nvim"

-- Load colorschemes and set the default one
if wanted_colorscheme == "doom-one" then
  -- Add color to cursor
  vim.g.doom_one_cursor_coloring = false
  -- Set :terminal colors
  vim.g.doom_one_terminal_colors = true
  -- Enable italic comments
  vim.g.doom_one_italic_comments = true
  -- Enable TS support
  vim.g.doom_one_enable_treesitter = true
  -- Color whole diagnostic text or only underline
  vim.g.doom_one_diagnostics_text_color = false
  -- Enable transparent background
  vim.g.doom_one_transparent_background = false
  -- Pumblend transparency
  vim.g.doom_one_pumblend_enable = true
  vim.g.doom_one_pumblend_transparency = 20
  -- Plugins integration
  vim.g.doom_one_plugin_neorg = true
  vim.g.doom_one_plugin_barbar = false
  vim.g.doom_one_plugin_telescope = true
  vim.g.doom_one_plugin_neogit = true
  vim.g.doom_one_plugin_nvim_tree = false
  vim.g.doom_one_plugin_dashboard = false
  vim.g.doom_one_plugin_startify = false
  vim.g.doom_one_plugin_whichkey = false
  vim.g.doom_one_plugin_indent_blankline = false
  vim.g.doom_one_plugin_vim_illuminate = false
  vim.g.doom_one_plugin_lspsaga = false
end

if is_installed(colorscheme_name) then
  vim.cmd("colorscheme " .. wanted_colorscheme)
else
  vim.notify_once(
    string.format(
      "[core.ui] %s colorscheme is not installed. Falling back to default colorscheme ...",
      wanted_colorscheme
    ),
    vim.log.levels.WARN
  )
  vim.cmd("colorscheme default")
end

--- ui.lua ends here
