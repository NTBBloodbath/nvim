function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

require("oil").setup({
  win_options = {
    number = false,
    relativenumber = false,
    cursorline = false,
    winbar = "%!v:lua.get_oil_winbar()",
  },
  view_options = {
    show_hidden = true,
  },
})
