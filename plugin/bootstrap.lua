--- This module bootstraps required plugins for my setup

local pack_path = vim.fn.stdpath("data") .. "/site/pack"

--- Ensures a given repository is cloned in the pack path
--- @param repo string Repository URL (user/repo_name)
local function ensure(repo, kind)
	local repo_name = vim.split(repo, "/")[2]
	local install_path = string.format("%s/packer/%s/%s", pack_path, kind, repo_name)

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.notify("Installing '" .. repo .. "', please wait ...")
		vim.fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"git@github.com:" .. repo .. ".git",
			install_path,
		})
		if vim.v.shell_error ~= 0 then
			vim.notify("Failed to install '" .. repo .. "', please restart to try again", vim.log.levels.ERROR)
		else
			vim.notify("Successfully installed '" .. repo .. "'", vim.log.levels.INFO)
		end
	end
end

--- Check if given plugin is installed locally so we can load it later
--- @param plugin_name string Plugin name
local function is_plugin_installed(plugin_name, kind)
	return vim.fn.empty(vim.fn.glob(string.format("%s/packer/kind/%s", pack_path, kind, plugin_name))) == 0
end

vim.defer_fn(function()
	-- Packer, sadly my plugins manager
	ensure("wbthomason/packer.nvim", "opt")

	-- Colorschemes
	ensure("NTBBloodbath/doom-one.nvim", "start")
	-- ensure("folke/tokyonight.nvim", "start")
	-- ensure("B4mbus/oxocarbon-lua.nvim", "start")

	if is_plugin_installed("packer.nvim", "opt") then
		vim.api.nvim_command("packadd packer.nvim")
	end
end, 0)
