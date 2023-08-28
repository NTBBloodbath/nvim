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
if wanted_colorscheme == "sweetie" and is_installed(colorscheme_name) then
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

  vim.g.sweetie = {
    overrides = hl_overrides,
    -- use_legacy_dark_bg = true,
  }
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
