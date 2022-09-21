--- completion.lua - Neovim completion plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
	--- Please someone make a better and consistent completion engine
	["hrsh7th/nvim-cmp"] = {
		module = "cmp",
		event = "InsertEnter",
		config = function()
			require("modules.completion.cmp")
		end,
	},
	["hrsh7th/cmp-path"] = {
	  after = "nvim-cmp",
	},
	["hrsh7th/cmp-buffer"] = {
	  after = "nvim-cmp",
  },
	["saadparwaiz1/cmp_luasnip"] = {
	  after = "nvim-cmp",
	},
	["hrsh7th/cmp-nvim-lsp"] = {
	  after = "nvim-cmp",
		module = "cmp_nvim_lsp",
	},
	["lukas-reineke/cmp-under-comparator"] = {
	  after = "nvim-cmp",
		module = "cmp-under-comparator",
	},
	["onsails/lspkind-nvim"] = {
		module = "lspkind",
	},

	--- God bless snippets
	["rafamadriz/friendly-snippets"] = {
		opts = false,
	},
	["L3MON4D3/LuaSnip"] = {
	  after = "nvim-cmp",
		event = "InsertEnter",
		module = "luasnip",
		config = function()
			require("modules.completion.snippets")
		end,
	},

  --- Autopairs, I'm lazy enough to hate typing `(` and `)`
  ["windwp/nvim-autopairs"] = {
    wants = "nvim-cmp",
    module = "nvim-autopairs.completion.cmp",
    config = function()
      require("nvim-autopairs").setup()
    end
  },

}

--- completion.lua ends here
