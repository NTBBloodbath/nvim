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
kbd("n", "<C-z>", "<Nop>", { desc = "Disable suspend" })

-- Disable ex-mode
kbd("n", "Q", "<Nop>", { desc = "Disable ex-mode" })

-- Disable command-line window with 'q:'
kbd("n", "q:", "<Nop>", { desc = "Disable command-line window" })

--- Core
--
-- Fast command-line mode
kbd("n", ";", ":", { desc = "Command mode" })

-- Fast save current buffer
kbd("n", "ww", "<cmd>w<cr>", { desc = "Save buffer" })

-- ESC to turn off search highlighting
kbd("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Escape remaps
for _, keys in ipairs({ "jk", "kj" }) do
  kbd("i", keys, "<Esc>", { desc = "Escape insert mode" })
end

-- Do not copy on paste/delete
kbd("v", "p", '"_dP', { desc = "Paste without yanking" })
kbd({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })

-- Stay in visual mode after indenting with < or >
kbd("v", ">", ">gv")
kbd("v", "<", "<gv")

-- Ah yes, lovely native multi-cursor hack, see
-- https://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
kbd("n", "m", "*``cgn", { desc = "Multi-cursor next" })
kbd("n", "M", "*``cgN", { desc = "Multi-cursor prev" })

-- Exit insert mode in terminal
kbd("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Fuzzy find files in project
kbd("n", "-", require("magna.picker").files.open, { desc = "Find files" })
kbd("n", "<leader>j", require("magna.picker").files.open, { desc = "Find files (alt)" })

-- Fuzzy select buffer
kbd("n", "<leader>k", require("magna.picker").buffers.open, { desc = "Find buffers" })

--- Movement
-- TAB to cycle buffers
kbd("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
kbd("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Previous buffer" })

-- Cycle between tabs
kbd("n", "gt", "<cmd>tabnext<cr>", { desc = "Next tab" })
kbd("n", "gT", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Close tab
kbd("n", "cd", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- Navigate through completion list
kbd("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, desc = "Next completion item" })
kbd("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, desc = "Previous completion item" })

-- Move between windows
kbd("n", "<C-h>", "<C-w>h", { desc = "Window left" })
kbd("n", "<C-j>", "<C-w>j", { desc = "Window down" })
kbd("n", "<C-k>", "<C-w>k", { desc = "Window up" })
kbd("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Resize splits
--
--Height
kbd("n", "<A-k>", "<cmd>resize +2<cr>", { desc = "Increase height" })
kbd("n", "<A-j>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
-- Width
kbd("n", "<A-h>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })
kbd("n", "<A-l>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })

--- Leader Keybindings
vim.keymap.set("n", "<leader>", "<cmd>WhichKey <space><cr>", { desc = "WhichKey menu" })

-- UI/Toggles
--
-- Toggle background
kbd("n", "<leader>ub", function()
  ---@diagnostic disable-next-line undefined-field
  vim.opt.background = vim.opt.background:get() == "dark" and "light" or "dark"
end, { desc = "Toggle background" })

-- Toggle numbering
kbd("n", "<leader>un", function()
  ---@diagnostic disable-next-line undefined-field
  vim.opt.number = not vim.opt.number:get()
  ---@diagnostic disable-next-line undefined-field
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle numbering" })

-- Toggle spelling
kbd("n", "<leader>us", function()
  ---@diagnostic disable-next-line
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spelling" })

-- Toggle automatic comments insertion
kbd("n", "<leader>uc", function()
  vim.cmd("ToggleCommentsInsertion")
end, { desc = "Toggle automatic comments insertion" })

-- Toggle terminal
vim.keymap.set("n", "<leader>ut", "<cmd>ToggleTerm<cr>", { silent = true })

-- Buffers
--
-- Close current buffer
kbd("n", "<leader>e", "<cmd>bd<cr>", { desc = "Close current buffer" })

-- Goto next buffer
kbd("n", "<leader>r", "<cmd>bn<cr>", { desc = "Goto next buffer" })

-- Goto prev buffer
kbd("n", "<leader>w", "<cmd>bp<cr>", { desc = "Goto next buffer" })

-- Windows
--
-- Close current window
kbd("n", "<leader>c", "<C-w>c", { desc = "Close current window" })

-- Split below
kbd("n", "<leader>,", "<C-w>s", { desc = "Split below" })

-- Split right
kbd("n", "<leader>.", "<C-w>v", { desc = "Split right" })

-- Balance (equalize) windows
kbd("n", "<leader>=", "<C-w>=", { desc = "Balance windows" })

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
