--- core.lua - Neovim core plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
	--- Plugins manager (I hate packer, BTW)
	["wbthomason/packer.nvim"] = {},

	--- Separate cut from delete registers
	["gbprod/cutlass.nvim"] = {
		event = "BufEnter",
		config = function()
			require("cutlass").setup({
				cut_key = "x",
			})
		end,
	},

	--- Prevent the cursor from moving when using shift and filter actions
	["gbprod/stay-in-place.nvim"] = {
		event = "BufEnter",
		config = function()
			require("stay-in-place").setup()
		end,
	},

	--- Lua and LibUV documentation
	["milisims/nvim-luaref"] = {
		opt = false,
	},
	["nanotee/luv-vimdocs"] = {
		opt = false,
	},

	--- Because we all need to take notes
	["nvim-neorg/neorg"] = {
		after = "nvim-treesitter",
		config = function()
			require("modules.core.neorg")
		end,
	},

	--- Sudo in Neovim
	["lambdalisue/suda.vim"] = {
		cmd = { "SudaRead", "SudaWrite" },
	},

	--- Smart ESC, ESC not gonna exit terminal mode again whenever I try to close htop!
	["sychen52/smart-term-esc.nvim"] = {
		event = "TermOpen",
		config = function()
			require("smart-term-esc").setup({
				key = "<Esc>",
				except = { "nvim", "emacs", "fzf", "zf", "htop" },
			})
		end,
	},

	--- Swiss Army Knife for Neovim
	["echasnovski/mini.nvim"] = {
		event = "BufEnter",
		config = function()
			-- Trailspace (highlight and remove)
			require("mini.trailspace").setup()

			-- Automatic highlighting of word under cursor
			require("mini.cursorword").setup()

			-- Align text
			require("mini.align").setup()

			-- Buffer removing (unshow, delete, wipeout), which saves window layout
			require("mini.bufremove").setup()

			-- Autopairs
			require("mini.pairs").setup()

			-- Commenting
			require("mini.comment").setup()

			-- Surround
			require("mini.surround").setup()

			-- Visualize and operate on indent scope
			require("mini.indentscope").setup({
				symbol = "│",
			})

			-- Minimap
			local map = require("mini.map")
			local diagnostic_integration = map.gen_integration.diagnostic({
				error = "DiagnosticFloatingError",
				warn = "DiagnosticFloatingWarn",
				info = "DiagnosticFloatingInfo",
				hint = "DiagnosticFloatingHint",
			})
			map.setup({
				integrations = {
					map.gen_integration.builtin_search(),
					map.gen_integration.gitsigns(),
					diagnostic_integration,
				},
			})
			vim.keymap.set("n", "<Leader>mr", map.refresh)
			vim.keymap.set("n", "<Leader>tm", map.toggle)
		end,
	},
}

--- core.lua ends here
