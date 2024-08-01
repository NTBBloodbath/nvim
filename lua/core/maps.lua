--- maps.lua - Keybindings
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

-- Set space as leader key
vim.g.mapleader = ","

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
kbd("c", "ZZ", function()
  require("utils.quit").confirm_quit(true, true)
end)

-- Fast save current buffer
kbd("n", "ww", "<cmd>w<cr>")

-- ESC to turn off search highlighting
kbd("n", "<esc>", "<cmd>nohlsearch<cr>")

-- Escape remaps
local esc_keys = {
  qwerty = { "jk", "kj" },
  dvorak = { "hh" },
}
for _, keys in ipairs(esc_keys[vim.g.layout]) do
  kbd("i", keys, "<esc>")
end

-- Do not copy on paste
kbd("v", "p", '"_dP')

-- Do not copy on delete
kbd({ "n", "v" }, "d", '"_d')

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
if vim.g.layout == "dvorak" then
  kbd("n", "<A-h>", "<cmd>tabnext<cr>")
  kbd("n", "<A-s>", "<cmd>tabprevious<cr>")
else
  kbd("n", "<A-h>", "<cmd>tabnext<cr>")
  kbd("n", "<A-l>", "<cmd>tabprevious<cr>")
end

-- Close tab
if vim.g.layout == "dvorak" then
  kbd("n", "ce", "<cmd>tabclose<cr>")
else
  kbd("n", "cd", "<cmd>tabclose<cr>")
end

-- Navigate through completion list
kbd("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
kbd("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

-- Move between windows
--
-- left
kbd("n", "<S-Left>", "<C-w>h")

-- down
kbd("n", "<S-Down>", "<C-w>j")

-- upper
kbd("n", "<S-Up>", "<C-w>k")

-- right
kbd("n", "<S-Right>", "<C-w>l")

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
vim.keymap.set("n", "<leader>", "<cmd>WhichKey ,<cr>", { desc = "WhichKey menu" })

-- UI
--
-- Toggle background
kbd("n", "<leader>tb", function()
  ---@diagnostic disable-next-line undefined-field
  vim.opt.background = vim.opt.background:get() == "dark" and "light" or "dark"
end, { desc = "Toggle background" })

-- Toggle numbering
kbd("n", "<leader>tn", function()
  ---@diagnostic disable-next-line undefined-field
  vim.opt.number = not vim.opt.number:get()
  ---@diagnostic disable-next-line undefined-field
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle numbering" })

-- Toggle spelling
kbd("n", "<leader>ts", function()
  ---@diagnostic disable-next-line
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spelling" })

-- Toggle automatic comments insertion
kbd("n", "<leader>tC", function()
  vim.cmd("ToggleCommentsInsertion")
end, { desc = "Toggle automatic comments insertion" })

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
kbd("n", "<leader>ps", "<cmd>Rocks sync<cr>", { desc = "Sync" })

-- Edit
kbd("n", "<leader>pe", "<cmd>Rocks edit<cr>", { desc = "Edit" })

-- Update
kbd("n", "<leader>pu", "<cmd>Rocks update<cr>", { desc = "Update" })

-- Log
kbd("n", "<leader>pl", "<cmd>Rocks log<cr>", { desc = "Logs" })

--- maps.lua ends here
