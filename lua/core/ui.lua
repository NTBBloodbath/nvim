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
local colorscheme_name = (wanted_colorscheme:find("fox") and "nightfox" or wanted_colorscheme)
  .. ".nvim"

-- Load colorschemes and set the default one

-- Do not set global doom variables if not installed and wanted to not pollute global state
if wanted_colorscheme == "doom-one" and is_installed(colorscheme_name) then
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
  local hl_overrides = {
    Conditional = { italic = true },
    ["@neorg.headings.1.title"] = { italic = true },
    ["@neorg.headings.2.title"] = { italic = true },
    ["@neorg.headings.3.title"] = { italic = true },
    ["@neorg.headings.4.title"] = { italic = true },
    ["@neorg.headings.5.title"] = { italic = true },
    ["@neorg.headings.6.title"] = { italic = true },
  }

  if vim.env.TERMUX_VERSION then
    hl_overrides = {
      Comment = { italic = false },
      CommentBold = { italic = false },
      Keyword = { italic = false },
      Boolean = { italic = false },
      Class = { italic = false },
      Constant = { bold = false },
    }
  end

  require("sweetie").setup({
    overrides = hl_overrides,
  })
end

-- Set default background to light, I am not coding during nighttime nowadays
-- and daylight.nvim will automatically swap to dark background if needed
vim.opt.background = "light"

-- Set colorscheme, fallback to `default` if wanted colorscheme is not installed
local function set_colorscheme()
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
end
set_colorscheme()

-- Set cursor coloring in the terminal
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor"

-- Disable background
vim.api.nvim_create_user_command("ToggleBackground", function()
  -- NOTE: perhaps there is a better way to restore everything without fully
  -- loading the colorscheme again?
  local normal_hi = vim.api.nvim_get_hl(0, { name = "Normal"})
  if normal_hi.bg then
    vim.cmd([[
      hi Normal guibg=none ctermbg=none
      hi NormalNC guibg=none ctermbg=none
      hi LineNr guibg=none ctermbg=none
      hi LineNrAbove guibg=none ctermbg=none
      hi LineNrBelow guibg=none ctermbg=none
      hi Folded guibg=none ctermbg=none
      hi NonText guibg=none ctermbg=none
      hi SpecialKey guibg=none ctermbg=none
      hi VertSplit guibg=none ctermbg=none
      hi FoldColumn guibg=none ctermbg=none
      hi SignColumn guibg=none ctermbg=none
      hi EndOfBuffer guibg=none ctermbg=none
    ]])
  else
    set_colorscheme()
  end
end, { desc = "Toggle colorscheme background transparency" })

--- ui.lua ends here
