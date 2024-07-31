local bufnr = vim.api.nvim_get_current_buf()

vim.api.nvim_create_augroup("RustLsp", { clear = true })
-- Display line diagnostics on hover
vim.api.nvim_create_autocmd("CursorHold", {
  group = "RustLsp",
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "line",
    }
    vim.diagnostic.open_float(opts)
  end,
})
