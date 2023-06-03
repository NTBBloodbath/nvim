--- maps.lua - Keybindings
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

-- Set space as leader key
vim.g.mapleader = " "

-- Some weird shorthand names, as it should be
local kbd = vim.keymap.set

--- Disable
--
-- Disable accidentally pressing Ctrl-Z and suspending Neovim
kbd("n", "<C-z>", "<Nop>")

-- Disable ex-mode
kbd("n", "Q", "<Nop>")

--- Core
--
-- Fast command-line mode
kbd("n", ";", ":")

-- Confirm on quit, doom-quit port in Neovim
-- kbd("c", "quit", function() require("utils.quit").confirm_quit(false, true) end)
-- kbd("c", "wq", function() require("utils.quit").confirm_quit(true, true) end)

-- Fast exit from Neovim
kbd("c", "ZZ", function() require("utils.quit").confirm_quit(true, true) end)

-- Fast save current buffer
kbd("n", "ww", "<cmd>w<cr>")

-- ESC to turn off search highlighting
kbd("n", "<esc>", "<cmd>nohlsearch<cr>")

-- Escape remaps
for _, keys in ipairs({ "jk", "kj" }) do
  kbd("n", keys, "<esc>")
end

-- Do not copy on paste
kbd("v", "p", '"_dP')

-- Stay in visual mode after indenting with < or >
kbd("v", ">", ">gv")
kbd("v", "<", "<gv")

-- Ah yes, lovely native multi-cursor hack, see
-- https://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
kbd("n", "cn", "*``cgn")
kbd("n", "cN", "*``cgN")

-- Exit insert mode in terminal
kbd("t", "<esc>", "<C-\\><C-n>")

--- Movement
-- TAB to cycle buffers
kbd("n", "<Tab>", "<cmd>bnext<cr>")
kbd("n", "<S-Tab>", "<cmd>bprev<cr>")

-- Cycle between tabs
kbd("n", "<A-h>", "<cmd>tabnext<cr>")
kbd("n", "<A-l>", "<cmd>tabprevious<cr>")

-- Close tab
kbd("n", "cd", "<cmd>tabclose<cr>")

-- Move between windows
--
-- left
kbd("n", "<C-h>", "<C-w>h")

-- down
kbd("n", "<C-j>", "<C-w>j")

-- upper
kbd("n", "<C-k>", "<C-w>k")

-- right
kbd("n", "<C-l>", "<C-w>l")

-- Resize splits
--
-- increase height
kbd("n", "<A-Up>", "<cmd>resize +2<cr>")

-- decrease height
kbd("n", "<A-Down>", "<cmd>resize -2<cr>")

-- increase width
kbd("n", "<A-Left>", "<cmd>vertical resize +2<cr>")

-- decrease width
kbd("n", "<A-Right>", "<cmd>vertical resize -2<cr>")

-- Smooth scrolling
kbd(
  "n",
  "<C-U>",
  "<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>"
)
kbd(
  "n",
  "<C-D>",
  "<C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>"
)

--- Leader Keybindings
--
-- UI
--
-- Toggle background
kbd(
  "n",
  "<leader>tb",
  function() vim.opt.background = vim.opt.background:get() == "dark" and "light" or "dark" end,
  { desc = "Toggle background" }
)

-- Toggle numbering
kbd("n", "<leader>tn", function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle numbering" })

-- Toggle spelling
kbd("n", "<leader>ts", function()
  ---@diagnostic disable-next-line
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spelling" })

-- Buffers
--
-- Close current buffer
kbd("n", "<leader>bc", "<cmd>bd<cr>", { desc = "Close current buffer" })

-- Goto next buffer
kbd("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Goto next buffer" })

-- Goto prev buffer
kbd("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Goto next buffer" })

-- Windows
--
-- Close current window
kbd("n", "<leader>wc", "<C-w>c", { desc = "Close current window" })

-- Split below
kbd("n", "<leader>ws", "<C-w>s", { desc = "Split below" })

-- Split right
kbd("n", "<leader>wv", "<C-w>v", { desc = "Split right" })

-- Balance windows
kbd("n", "<leader>w=", "<C-w>=", { desc = "Balance windows" })

-- Plugin manager
--
-- Synchronize
kbd("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Sync" })

-- Info
kbd("n", "<leader>pi", "<cmd>Lazy show<cr>", { desc = "Info" })

-- Profile
kbd("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Profile" })

-- Log
kbd("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Logs" })

--- maps.lua ends here
