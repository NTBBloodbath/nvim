local npairs = require("nvim-autopairs")
npairs.setup({ map_cr = false })

vim.keymap.set("i", "<cr>", function()
  if require("care").api.is_open() then
    require("care").api.confirm()
  else
    vim.fn.feedkeys(require("nvim-autopairs").autopairs_cr(), "in")
  end
end)
