--- git.lua - Neovim Git plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local function is_git_repo()
	return vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";") ~= ""
end

return {
	["lewis6991/gitsigns.nvim"] = {
		cond = is_git_repo,
		config = function()
			require("modules.git.signs")
		end,
	},

	--- More than 3 years using Git and conflicts still confuses my brain
	["akinsho/git-conflict.nvim"] = {
		cond = is_git_repo,
		config = function()
			require("git-conflict").setup()
		end,
	},

	--- Magit? No, Neogit!
	["TimUntersberger/neogit"] = {
		cmd = "Neogit",
		keys = {
			{ "n", "<leader>gs" },
			{ "n", "<leader>gc" },
			{ "n", "<leader>gl" },
			{ "n", "<leader>gp" },
			{ "n", "<F2>" },
		},
		cond = is_git_repo,
		config = function()
			require("modules.git.neogit")
		end,
	},
}

--- git.lua ends here
