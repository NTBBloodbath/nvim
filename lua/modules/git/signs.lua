require("gitsigns").setup({
	preview_config = { border = "rounded" },
})

vim.keymap.set("n", "gr", "<cmd>Gitsigns reset_buffer<cr>")
vim.keymap.set("n", "gh", "<cmd>Gitsigns preview_hunk<cr>")
