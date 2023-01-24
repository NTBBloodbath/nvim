--- lsp.lua - Neovim LSP plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
	["neovim/nvim-lspconfig"] = {
		ft = { "c", "cpp", "zig", "lua", "julia", "python", "elixir", "javascript", "typescript" },
		config = function()
			require("modules.lsp.config")
		end,
	},

	["folke/neodev.nvim"] = {
		module = "neodev",
	},

	["p00f/clangd_extensions.nvim"] = {
		module = "clangd_extensions",
	},

	["ray-x/lsp_signature.nvim"] = {
		module = "lsp_signature",
	},

	["Maan2003/lsp_lines.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("lsp_lines").setup()

			vim.api.nvim_create_user_command(
				"LspLinesToggle",
				require("lsp_lines").toggle,
				{ desc = "Toggle lsp_lines.nvim plugin" }
			)
			vim.keymap.set("n", "<leader>ll", "<cmd>LspLinesToggle<cr>")
		end,
	},

	["SmiteshP/nvim-navic"] = {
		module = "nvim-navic",
	},

	["utilyre/barbecue.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("barbecue").setup({})
		end,
	},
}

--- lsp.lua ends here
