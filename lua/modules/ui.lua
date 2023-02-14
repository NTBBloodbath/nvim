--- ui.lua - Neovim UI plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
  --- Colorschemes
  { "NTBBloodbath/doom-one.nvim", lazy = false },

  --- Automatically change colorscheme and background during day/night
  {
    "NTBBloodbath/daylight.nvim",
    cmd = "DaylightToggle",
    config = true,
  },

  --- Fancy icons!
  { "kyazdani42/nvim-web-devicons" },

  --- Distraction-free environment
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
  },

  --- Highlight over-length text lines
  {
    "lcheylus/overlength.nvim",
    ft = { "norg", "markdown" },
    config = function()
      require("overlength").setup()

      -- Set custom hl for OverLength
      vim.api.nvim_set_hl(0, "OverLength", { bg = "#ff6c6b", fg = "#5b6268" })
    end,
  },

	--- Color highlighter
	{
		"xiyaowong/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup({ "*" }, { mode = "virtualtext" })
		end,
	},

	--- Tabline
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		opts = {
			options = {
				numbers = "buffer_id",
				diagnostics = false,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
		},
	},
}

--- ui.lua ends here
