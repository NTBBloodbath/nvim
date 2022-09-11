--- utils.lua - Autocommands functions
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local function preserve_position()
	if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
		vim.cmd("normal! g'\"")
	end
end

local function create_directory_on_save()
	local fpath = vim.fn.expand("<afile>")
	local dir = vim.fn.fnamemodify(fpath, ":p:h")

	if vim.fn.isdirectory(dir) ~= 1 then
		vim.fn.mkdir(dir, "p")
	end
end

return {
	preserve_position = preserve_position,
	create_directory_on_save = create_directory_on_save,
}

--- utils.lua
