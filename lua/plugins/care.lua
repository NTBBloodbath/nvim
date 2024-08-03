vim.keymap.set("i", "<CR>", "<Plug>(CareConfirm)")
vim.keymap.set("i", "<c-e>", "<Plug>(CareClose)")
vim.keymap.set("i", "<TAB>", "<Plug>(CareSelectNext)")
vim.keymap.set("i", "<S-TAB>", "<Plug>(CareSelectPrev)")

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if require("care").api.is_open() then
      require("care").api.close()
    end
  end,
})
