require("indent_blankline").setup({
	char = "│",
	use_treesitter = false,
	show_first_indent_level = true,
	show_current_context = true,
	show_current_context_start = true,
	buftype_exclude = { "terminal" },
	filetype_exclude = {
		"help",
		"lspinfo",
		"packer",
		"norg",
		"fennel",
		"man",
	},
})
