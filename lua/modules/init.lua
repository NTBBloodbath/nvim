--- modules.lua - Neovim plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Packer setup
--
-- Load Packer
vim.cmd("packadd packer.nvim")

-- Setup packer
local packer = require("packer")
packer.init({
	max_jobs = 20,
	autoremove = true,
	opt_default = true,
	compile_path = table.concat({ vim.fn.stdpath("config"), "lua", "packer_compiled.lua" }, "/"),
	git = {
		clone_timeout = 300,
		default_url_format = "git@github.com:%s",
	},
	display = {
		compact = true,
		working_sym = "ﲊ ",
		error_sym = " ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = " ",
		header_sym = "─",
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	profile = { enable = true },
})

packer.reset()

local ui = require("modules.ui")
local git = require("modules.git")
local lsp = require("modules.lsp")
local core = require("modules.core")
local editor = require("modules.editor")
local completion = require("modules.completion")

local plugins = vim.tbl_deep_extend("force", {}, core, ui, editor, git, completion, lsp)

for name, specs in pairs(plugins) do
	specs[1] = name
	packer.use(specs)
end

-- Automatically install new plugins or install all on first launch and compile changes
if vim.fn.filereadable(table.concat({ vim.fn.stdpath("config"), "lua", "packer_compiled.lua" }, "/")) == 1 then
	packer.install()
	packer.compile()
else
	packer.sync({ preview_updates = true })
end

--- modules.lua ends here
