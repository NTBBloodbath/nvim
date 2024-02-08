local wk = require("which-key")

wk.setup({
  layout = {
    align = "center",
    spacing = 5,
  },
})

wk.register({
  ["<leader>"] = {
    b = { name = "Buffers" },
    g = { name = "Git" },
    l = { name = "LSP" },
    ld = { name = "Diagnostics" },
    lg = { name = "Goto" },
    n = { name = "Neorg" },
    no = { name = "ToC" },
    nm = { name = "Metadata" },
    p = { name = "Plugins" },
    t = { name = "Toggle" },
    w = { name = "Windows" },
  },
})

vim.keymap.set("n", "<leader>", "<cmd>WhichKey \\ <cr>", { desc = "WhichKey menu" })
