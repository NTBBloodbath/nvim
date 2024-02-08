require("lsp_lines").setup()

vim.api.nvim_create_user_command(
  "LspLinesToggle",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines.nvim plugin" }
)

vim.keymap.set("n", "<leader>td", "<cmd>LspLinesToggle<cr>", {
  desc = "Toggle diagnostics",
})
