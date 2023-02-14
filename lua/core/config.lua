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

-- Enable bundled tree-sitter parser for Lua
vim.g.ts_highlight_lua = true

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

-- Enable mouse input
vim.opt.mouse = "a"

-- Faster macros
vim.opt.lazyredraw = true

-- Disable swapfiles and enable undofiles
vim.opt.swapfile = false
vim.opt.undofile = true

--- UI-related options
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

-- Do not show mode
vim.opt.showmode = false

-- Set windows width
vim.opt.winwidth = 40

-- Highlight current cursor line
vim.opt.cursorline = true

-- Set a global statusline
vim.opt.laststatus = 3

-- Hide command-line
-- BUG: cmdheight=0 is still buggy so I'm disabling it
-- vim.opt.cmdheight = 0

--- Buffer options
-- Never wrap
vim.opt.wrap = false

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
vim.opt.scrolloff = 8

-- Freely move cursor in buffer while in Visual block mode
vim.opt.virtualedit = "block"

-- Spelling
vim.opt.spelllang = "en,es"
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.spellsuggest = "best,6"

--- config.lua ends here
