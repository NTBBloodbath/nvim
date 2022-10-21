--- editor.lua - Neovim editor plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
	--- Plenary
	["nvim-lua/plenary.nvim"] = {
		module_pattern = "plenary.*",
	},

	--- Tree-sitter
	["nvim-treesitter/nvim-treesitter"] = {
		run = ":TSUpdate",
		config = function()
			require("modules.editor.treesitter")
		end,
	},
	["p00f/nvim-ts-rainbow"] = {},
	["nvim-treesitter/playground"] = {
		cmd = "TSPlaygroundToggle",
	},

	--- Comments
	["LudoPinelli/comment-box.nvim"] = {
		cmd = { "CBcatalog", "CBaclbox", "CBaccbox", "CBlbox", "CBclbox" },
	},
	["ram02z/dev-comments.nvim"] = {
		event = { "BufNewFile", "BufRead" },
		wants = "telescope.nvim",
		module = "telescope._extensions.dev_comments",
		config = function()
			require("dev_comments").setup()
		end,
	},
	["jbyuki/venn.nvim"] = {
		cmd = "VBox",
	},

	--- Annotations
	["danymat/neogen"] = {
		keys = {
			{ "n", "mm" },
		},
		after = "nvim-treesitter",
		config = function()
			require("modules.editor.neogen")
		end,
	},

	--- Templates
	["NTBBloodbath/templar.nvim"] = {
		opt = false,
		branch = "refact/fields-syntax-fix-change",
	},

	--- Editorconfig support
	["gpanders/editorconfig.nvim"] = {
		event = { "BufNewFile", "BufRead" },
	},

	--- Scope buffers to tabs
	["tiagovla/scope.nvim"] = {
		event = { "TabEnter", "BufWinEnter" },
		config = function()
			require("scope").setup()
		end,
	},

	--- Restore after :q sounds like a plan
	["olimorris/persisted.nvim"] = {
		opt = false,
		config = function()
			require("persisted").setup()
		end,
	},

	--- Pastebins
	["rktjmp/paperplanes.nvim"] = {
		cmd = "PP",
		config = function()
			require("paperplanes").setup({
				provider = "0x0.st",
			})
		end,
	},

	--- Non-intrusive notification system
	-- ["vigoux/notifier.nvim"] = {
	-- 	opt = false,
	-- 	disable = true,
	-- 	config = function()
	-- 		require("notifier").setup({
	-- 			component_name_recall = true,
	-- 		})
	-- 	end,
	-- },

	--- Peek lines just when you intend
	["nacro90/numb.nvim"] = {
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("numb").setup()
		end,
	},

	--- Better buffers cycles
	["ghillb/cybu.nvim"] = {
		cmd = { "CybuNext", "CybuPrev" },
		keys = {
			{ "n", "K" },
			{ "n", "J" },
			{ "n", "<Tab>" },
			{ "n", "<S-Tab>" },
		},
		event = "BufWinEnter",
		config = function()
			require("modules.editor.cybu")
		end,
	},

	--- Better default terminal
	["akinsho/toggleterm.nvim"] = {
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "n", "<F4>" },
		},
		module_pattern = "toggleterm.*",
		config = function()
			require("modules.editor.terminal")
		end,
	},

	--- Fuzzy everywhere and every time
	["nvim-telescope/telescope.nvim"] = {
		event = "BufEnter",
		config = function()
			require("modules.editor.telescope")
		end,
	},
	["nvim-telescope/telescope-project.nvim"] = {
		module = "telescope._extensions.project",
	},
	["chip/telescope-software-licenses.nvim"] = {
		module = "telescope._extensions.software-licenses",
	},

	--- Do we have NNN? We gotta embed NNN
	["luukvbaal/nnn.nvim"] = {
		cmd = { "NnnExplorer", "NnnPicker" },
		cond = function()
			return vim.fn.executable("nnn") == 1
		end,
		config = function()
			require("modules.editor.nnn")
		end,
	},

	--- Toggle booleans and operators
	["rmagatti/alternate-toggler"] = {
		cmd = "ToggleAlternate",
		setup = function()
			vim.g.at_custom_alternates = {
				["=="] = "!=",
				["==="] = "!==",
			}
		end,
	},

	--- Smart semicolons
	["iagotito/smart-semicolon.nvim"] = {
		ft = { "c", "cpp", "zig", "rust", "javascript", "typescript" },
	},

	--- Tab out from parentheses, quotes, etc
	["abecodes/tabout.nvim"] = {
		after = "nvim-cmp",
		wants = "nvim-treesitter",
		config = function()
			require("tabout").setup({
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
					{ open = "<", close = ">" },
				},
			})
		end,
	},

	--- Preview markdown using Glow
	["ellisonleao/glow.nvim"] = {
		cmd = "Glow",
		config = function()
			require("modules.editor.glow")
		end,
	},

	--- Discord presence, I like people to stalk what I'm losing my time with
	["andweeb/presence.nvim"] = {
		event = { "BufNewFile", "BufRead" },
		config = function()
			require("presence"):setup({
				main_image = "file",
				neovim_image_text = "Break my pinky? No thanks, I'm more of breaking my editor config",
				enable_line_number = true,
			})
		end,
	},

	--- Elixir development support
	["mhanberg/elixir.nvim"] = {
		ft = "elixir",
		config = function()
			local elixir = require("elixir")
			elixir.setup({
				cmd = vim.env.HOME .. "/.local/bin/elixir-ls",
				settings = elixir.settings({
					dialyzerEnabled = true,
					fetchDeps = true,
					enableTestLenses = true,
					suggestSpecs = true,
				}),
			})
		end,
	},
	["ustrajunior/ex_maps"] = {
		ft = "elixir",
		config = function()
			require("ex_maps").setup({
				create_mappings = true,
				mapping = "tt",
			})
		end,
	},

	--- Zig development tools
	["NTBBloodbath/zig-tools.nvim"] = {
		ft = "zig",
		config = function()
			require("zig-tools").setup({
				integrations = {
					package_managers = {},
					zls = {
						management = {
							enable = true,
						},
					},
				},
			})
		end,
	},
}

--- editor.lua ends here
