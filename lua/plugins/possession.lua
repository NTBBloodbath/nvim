local possession = require("nvim-possession")

possession.setup({
  autoload = true,
})

vim.keymap.set("n", "<leader>s", function()
  possession.list()
end, { desc = "List sessions" })
vim.keymap.set("n", "<leader>sn", function()
  possession.new()
end, { desc = "New session" })
vim.keymap.set("n", "<leader>su", function()
  possession.list()
end, { desc = "Update session" })
vim.keymap.set("n", "<leader>sd", function()
  possession.list()
end, { desc = "Delete session" })
