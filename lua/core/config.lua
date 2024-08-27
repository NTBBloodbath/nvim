--- config.lua - Neovim user configurations (saner defaults)
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Disable some built-in Neovim plugins and unneeded providers
local builtins = {
  "tar",
  "zip",
  "gzip",
  "tarPlugin",
  "zipPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
}
local providers = { "perl", "node", "ruby", "python", "python3" }
for _, builtin in ipairs(builtins) do
  vim.g["loaded_" .. builtin] = 1
end
for _, provider in ipairs(providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- Set C syntax for '.h' header files (default is C++)
vim.g.c_syntax_for_h = true

--- Global options
vim.opt.hidden = true
vim.opt.updatetime = 200
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 5
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.shortmess = "filnxtToOFatsc"
vim.opt.inccommand = "split"
vim.opt.path = "**"

-- Use clipboard outside Neovim
vim.opt.clipboard = "unnamedplus"
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

-- Enable mouse input
vim.opt.mouse = "a"

-- Faster macros
vim.opt.lazyredraw = true

-- Disable swapfiles and enable undofiles
vim.opt.swapfile = false
vim.opt.undofile = true

--- UI-related options
-- Smooth all the way!
vim.opt.smoothscroll = true

-- Smooth mouse scrolling
vim.opt.mousescroll = { "hor:1", "ver:1" }

-- Disable ruler
vim.opt.ruler = false

-- Confirmation prompts for unsaved files, etc
vim.opt.confirm = true

-- Numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- True-color
vim.opt.termguicolors = true

-- Columns and characters
vim.opt.signcolumn = "auto:1-3"
vim.opt.foldenable = true
vim.opt.foldlevel = 6
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "auto:2"

vim.opt.fillchars = {
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
  fold = " ",
  diff = "─",
  msgsep = "‾",
  foldsep = "│",
  foldopen = "▾",
  foldclose = "▸",
}

local space = "·"
vim.opt.list = true
vim.opt.listchars = {
  tab = "▸ ",
  -- multispace = space,
  -- lead = space,
  trail = space,
  -- nbsp = space
}

-- Do not show mode
vim.opt.showmode = false

-- Set windows width
vim.opt.winwidth = 40

-- Highlight current cursor line
vim.opt.cursorline = true

-- Set a global statusline
vim.opt.laststatus = 3
-- Loading the statusline takes ~20ms, deferring has no visual impact but makes it not block the editor
vim.defer_fn(function()
  vim.opt.statusline = [[%!luaeval("require('core.statusline').set()")]]
end, 0)

-- Set tabline
vim.defer_fn(function()
  require("core.tabline")
end, 0)

-- Hide command-line
vim.opt.cmdheight = 0

--- Buffer options
-- Never wrap unless I manually tweak this again
vim.opt.wrap = false

-- Every wrapped line will continue visually indented, preserving horizontal spacing
vim.opt.breakindent = true

-- Smart search
vim.opt.smartcase = true

-- Case-insensitive search
vim.opt.ignorecase = true

-- Indentation rules
vim.opt.copyindent = true
vim.opt.smartindent = true
vim.opt.preserveindent = true

-- Indentation level
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Expand tabs
vim.opt.expandtab = true

-- Enable concealing
vim.opt.conceallevel = 2

-- Automatic split locations
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Scroll off
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 8

-- Freely move cursor in buffer while in Visual block mode
vim.opt.virtualedit = "block"

-- Spelling
vim.opt.spelllang = "en,es"
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.spellsuggest = "best,6"

--- config.lua ends here
