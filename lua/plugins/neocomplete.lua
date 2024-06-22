require("neocomplete.lsp_source")
vim.keymap.set("i", "<c-n>", function()
  vim.snippet.jump(1)
end)
vim.keymap.set("i", "<c-p>", function()
  vim.snippet.jump(-1)
end)
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if require("neocomplete").core.menu:is_open() then
    require("neocomplete").core.menu:select_next(1)
  else
    return "<Tab>"
  end
end, { expr = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  require("neocomplete").core.menu:select_prev(1)
end)
vim.keymap.set("i", "<c-e>", function()
  require("neocomplete").core.menu:close()
end)
vim.keymap.set("i", "<cr>", function()
  if require("neocomplete").core.menu:is_open() then
    vim.schedule(function()
      require("neocomplete").core.menu:confirm()
    end)
    return ""
  else
    return "<cr>"
  end
end, { expr = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    require("neocomplete").core.menu:close()
  end,
})
