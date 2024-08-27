--- ui.lua - UI Configurations
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

-- Configure sweetie.nvim overrides
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
}

-- Set default background to dark/light automatically based on the current time and
-- daylight.nvim will automatically swap it if needed, e.g. light to dark if it's already too late (>= 8 pm)
local function set_background()
  local ctime = os.date("*t")
  -- NOTE: dark is the default in Neovim so it's worthless to make an else statement
  if os.date("*t").hour <= 18 and ctime.hour >= 8 then
    return "light"
  end
  return "dark"
end
vim.opt.background = set_background()

-- Set cursor coloring in the terminal
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor"

-- Enable window transparency
vim.opt.winblend = 20

-- Disable background
vim.api.nvim_create_user_command("ToggleBackground", function()
  -- NOTE: perhaps there is a better way to restore everything without fully
  -- loading the colorscheme again?
  local normal_hi = vim.api.nvim_get_hl(0, { name = "Normal" })
  if normal_hi.bg then
    vim.cmd([[
      hi Normal guibg=none ctermbg=none
      hi NormalNC guibg=none ctermbg=none
      hi NormalFloat guibg=none ctermbg=none
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
    -- I am only using sweetie.nvim colorscheme nowadays
    vim.cmd.colorscheme("sweetie")
  end
end, { desc = "Toggle colorscheme background transparency" })

vim.keymap.set("n", "<leader>to", "<cmd>ToggleBackground<cr>", {
  desc = "Toggle background opacity",
})

--- ui.lua ends here
