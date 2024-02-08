require("neogit").setup({
  kind = "vsplit",
})

local pull_popup = require("neogit.popups.pull")
local push_popup = require("neogit.popups.push")

vim.keymap.set("n", "<F2>", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Commit changes" })
vim.keymap.set("n", "<leader>gl", pull_popup.create, { desc = "Pull changes" })
vim.keymap.set("n", "<leader>gp", push_popup.create, { desc = "Push changes" })
