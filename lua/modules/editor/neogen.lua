require("neogen").setup({
	enabled = true,
	input_after_comment = true,
	jump_map = "jn",
	languages = {
		python = {
			template = {
				annotation_convention = "numpydoc",
			},
		},
	},
})

vim.keymap.set("n", "mm", "<cmd>Neogen<cr>")
