--- autocmds.lua - Autocommands
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local au = vim.api.nvim_create_autocmd

-- Packer
au("BufWritePost", {
	pattern = "*/modules/init.lua",
	callback = function()
		require("packer").compile()
	end,
})
au("VimLeavePre", {
	pattern = "*/modules/init.lua",
	callback = function()
		require("packer").compile()
	end,
})

-- Highlight yanked text
au("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
	end,
})

-- Autosave
au("BufModifiedSet", {
	pattern = "<buffer>",
	command = "silent! write",
})

-- Update file on external changes
au("FocusGained", {
  pattern = "<buffer>",
	command = "checktime",
})

-- Format on save
-- au("BufWritePre", {
--   pattern = "<buffer>",
--   command = "silent! Format"
-- })

-- Auto cd to current buffer path
au("BufEnter", {
	pattern = "*",
	command = "silent! lcd %:p:h",
})

-- Automatically create directory when saving a file in case it does not exist
au("BufWritePre", {
	pattern = "*",
	callback = require("core.autocmds.utils").create_directory_on_save,
})

-- Preserve last editing position
au("BufReadPost", {
	pattern = "*",
	callback = require("core.autocmds.utils").preserve_position,
})

-- We do not like automatic comments on <cr> here, get lost
au("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Quickly exit help pages
au("FileType", {
	pattern = "help",
	callback = function()
		vim.keymap.set("n", "q", "<cmd>q<cr>", {
			silent = true,
			buffer = true,
		})
	end,
})

-- Disable numbering, folding and signcolumn in Man pages and terminal buffers
local function disable_ui_settings()
	local opts = {
		number = false,
		relativenumber = false,
		signcolumn = "no",
		foldcolumn = "0",
		foldlevel = 999,
	}
	for opt, val in pairs(opts) do
		vim.opt_local[opt] = val
	end
end

local function start_term_mode()
  disable_ui_settings()
  vim.cmd("startinsert!")
end

au({ "BufEnter", "BufWinEnter" }, {
	pattern = "man://*",
	callback = disable_ui_settings,
})

au("TermOpen", {
	pattern = "term://*",
	callback = start_term_mode,
})

--- autocmds.lua ends here
