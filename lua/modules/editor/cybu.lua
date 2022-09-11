require("cybu").setup({
	display_time = 1000,
	position = {
		relative_to = "editor",
		anchor = "center",
	},
	style = {
		path = "relative",
		prefix = "",
		padding = 2,
		devicons = {
			enabled = true,
			colored = true,
		},
		highlights = {
			current_buffer = "Constant",
			background = "NormalFloat",
		},
	},
	exclude = {
		"Neogit",
		"qf",
	},
})

vim.keymap.set("n", "K", "<Plug>(CybuNext)")
vim.keymap.set("n", "J", "<Plug>(CybuPrev)")
vim.keymap.set("n", "<Tab>", "<Plug>(CybuNext)")
vim.keymap.set("n", "<S-Tab>", "<Plug>(CybuPrev)")
