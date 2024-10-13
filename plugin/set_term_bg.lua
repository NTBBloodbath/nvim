-- See: https://github.com/neovim/neovim/issues/16572#issuecomment-195442>
if not vim.env.WSLENV then
  local modified = false
  vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      if normal.bg then
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
        modified = true
      end
    end,
  })

  vim.api.nvim_create_autocmd("UILeave", {
    callback = function()
      if modified then
        io.write("\027]111\027\\")
      end
    end,
  })
end
