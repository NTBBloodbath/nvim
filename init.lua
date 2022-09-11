--- init.lua - Neovim init file
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbatb/nvim.fnl
-- License: GPLv3
--
--- Code:

-- Do not load Neovim runtime plugins automatically
vim.opt.loadplugins = false

-- Manually load runtime Man plugin to use Neovim as my man pager
vim.api.nvim_command("runtime! plugin/man.vim")

-- Set colorscheme
vim.g.colorscheme = "doom-one"

-- Enable first-class Lua tree-sitter parser highlights
vim.g.ts_highlight_lua = true

-- Temporarily disable syntax and filetype to improve startup time
vim.api.nvim_command("syntax off")
vim.api.nvim_command("filetype off")
vim.api.nvim_command("filetype plugin indent off")

-- Temporarily disable Shada file to improve startup time
vim.opt.shadafile = "NONE"

--- Check if a plugin is installed or not
--- @tparam string plugin_name
--- @return boolean
local function is_installed(plugin_name)
	local plugin_path = string.format("%s/packer/opt/%s", vim.fn.stdpath("data") .. "/site/pack", plugin_name)
	return vim.fn.isdirectory(plugin_path) ~= 0
end

-- Defer plugins loading
vim.defer_fn(function()
	-- Manually load Neovim runtime
	-- WARNING: enable only if using 'vim.g.loadplugins'
	vim.api.nvim_command("runtime! plugin/**/*.vim")
	vim.api.nvim_command("runtime! plugin/**/*.lua")

	-- Re-enable syntax and filetype
	vim.api.nvim_command("syntax on")
	vim.api.nvim_command("filetype on")
	vim.api.nvim_command("filetype plugin indent on")

	-- Re-enable Shada file
	vim.opt.shadafile = ""
	vim.api.nvim_command("rshada!")

	-- Load configuration core
	local loaded_core, core_err = xpcall(require, debug.traceback, "core")
	if not loaded_core then
	    vim.notify(string.format("There was an error requiring 'core'. Traceback:\n%s", core_err), vim.log.levels.ERROR)
	end

	-- Load user plugins
	if is_installed("packer.nvim") then
		-- Tree-Sitter
		if is_installed("nvim-treesitter") then
			vim.api.nvim_command("PackerLoad nvim-treesitter")
		end
	end

	-- Fix some plugins stuff, e.g. tree-sitter modules
	vim.api.nvim_exec_autocmds("BufEnter", {})
end, 0)

--- init.lua ends here
