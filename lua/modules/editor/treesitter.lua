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
		"css",
		"vue",
		"nasm",
		"diff",
		"fish",
		"json",
		"yaml",
		"toml",
		"html",
		"julia",
		"regex",
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
		-- disable = { "html" },
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
	autotag = {
	  enable = true,
	},
	playground = {
		enable = true,
	},
	rainbow = {
		enable = true,
		max_file_lines = 2000,
		strategy = {
		  require("ts-rainbow.strategy.global"),
		  html = require("ts-rainbow.strategy.local"),
		},
		hlgroups = {
		  "@operator",
		  "@punctuation",
		  "@attribute",
		  "@type",
		},
	},
	update_strategy = "lockfile",
})
