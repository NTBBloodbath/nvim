--- ui.lua - Neovim UI plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
	--- Colorschemes
	["NTBBloodbath/doom-one.nvim"] = {
		opt = false,
	},
	["folke/tokyonight.nvim"] = {
		opt = false,
	},
	["aktersnurra/no-clown-fiesta.nvim"] = {
		opt = false,
	},
	["B4mbus/oxocarbon-lua.nvim"] = {
		opt = false,
	},
	["catppuccin/nvim"] = {
	  opt = false,
	  as = "catppuccin.nvim",
	},

	--- Automatically change colorscheme and background during day/night
	["NTBBloodbath/daylight.nvim"] = {
		cmd = "DaylightToggle",
		config = function()
			require("daylight").setup()
		end,
	},

	--- Fancy icons!
	["kyazdani42/nvim-web-devicons"] = {
		module = "nvim-web-devicons",
	},

	--- Modern folds
	["kevinhwang91/nvim-ufo"] = {
		module = "ufo",
		after = "nvim-lspconfig",
	},
	["kevinhwang91/promise-async"] = {
		module = "promise",
	},

	--- Beautify markup documents
	["lukas-reineke/headlines.nvim"] = {
		disable = true,
		ft = { "norg", "markdown" },
		config = function()
			require("modules.ui.headlines")
		end,
	},

	-- Distraction-free environment
	["folke/zen-mode.nvim"] = {
		cmd = "ZenMode",
		module_pattern = "zen-mode.*",
		config = function()
			require("zen-mode").setup()
		end,
	},

	-- Highlight over-length text lines
	["lcheylus/overlength.nvim"] = {
		ft = { "norg", "markdown" },
		config = function()
			require("overlength").setup()

			-- Set custom hl for OverLength
			vim.api.nvim_set_hl(0, "OverLength", { bg = "#ff6c6b", fg = "#5B6268" })
		end,
	},

	--- Color highlighter
	["xiyaowong/nvim-colorizer.lua"] = {
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("modules.ui.colorizer")
		end,
	},

	--- Tabline
	["rafcamlet/tabline-framework.nvim"] = {
		event = "BufEnter",
		config = function()
			require("modules.ui.tabline")
		end,
	},

	--- Statusline
	["rebelot/heirline.nvim"] = {
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("modules.ui.statusline")
		end,
	},
}

--- ui.lua ends here
