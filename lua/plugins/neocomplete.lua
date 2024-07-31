vim.keymap.set('i', '<CR>', '<Plug>(NeocompleteConfirm)')
vim.keymap.set('i', '<c-e>', '<Plug>(NeocompleteClose)')
vim.keymap.set('i', '<TAB>', '<Plug>(NeocompleteSelectNext)')
vim.keymap.set('i', '<S-TAB>', '<Plug>(NeocompleteSelectPrev)')

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    require("neocomplete").core.menu:close()
  end,
})
