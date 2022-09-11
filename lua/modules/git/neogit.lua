local neogit = require("neogit")
local popups = neogit.popups

setup({
	use_magit_keybindings = true,
	disable_commit_confirmation = true,
	kind = "vsplit",
	commit_popup = { kind = "split" },
	signs = {
		section = { "▸", "▾" },
		item = { "▸", "▾" },
		hunk = { "樂", "" },
	},
})

vim.keymap.set("n", "<F2>", "<cmd>Neogit<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>")
vim.keymap.set("n", "<leader>gl", popups.pull.create)
vim.keymap.set("n", "<leader>gp", popups.push.create)
