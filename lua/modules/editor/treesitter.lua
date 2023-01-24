local setup = require("nvim-treesitter.configs").setup
local parsers = require("nvim-treesitter.parsers")

--- Extra parsers
local parser_config = parsers.get_parser_configs()

-- NASM
parser_config.nasm = {
  install_info = {
    url = "https://github.com/PictElm/tree-sitter-nasm",
    files = { "src/parser.c" },
    branch = "main",
  }
}

setup({
	ensure_installed = {
		"c",
		"cpp",
		"zig",
		"vim",
		"nasm",
		"diff",
		"json",
		"yaml",
		"toml",
		"julia",
		"regex",
		"fennel",
		"elixir",
		"python",
		"jsdoc",
		"javascript",
		"typescript",
		"markdown",
		"markdown_inline",
		"comment",
		"gitattributes",
		"norg",
		"norg_meta",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
		custom_captures = {
			["punctuation.bracket"] = "",
			["constructor"] = "",
		},
	},
	indent = {
		enable = true,
		disable = { "python" },
	},
	playground = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = 1000,
		colors = {
			"#51afef",
			"#4db5bd",
			"#c678dd",
			"#a9a1e1",
		},
	},
	update_strategy = "lockfile",
})
