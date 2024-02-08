--- Trailspace (highlight and remove)
require("mini.trailspace").setup()


--- Automatic highlighting of word under cursor
require("mini.cursorword").setup()


--- Align text
-- require("mini.align").setup()


--- Buffer removing (unshow, delete, wipeout), which saves window layout
require("mini.bufremove").setup()


--- Autopairs
require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = false },
})


--- Commenting
require("mini.comment").setup()


--- Surround
require("mini.surround").setup()


--- Completion
require("mini.completion").setup({
  window = {
    info = { border = "single" },
    signature = { border = "single" },
  }
})
vim.keymap.set("n", "<leader>tc", function()
    local is_completion_disabled = vim.b.minicompletion_disable
    if not is_completion_disabled then
      vim.b.minicompletion_disable = true
      vim.notify("[nvim] Completion has been temporarily disabled in this buffer")
    else
      vim.b.minicompletion_disable = false
      vim.notify("[nvim] Completion has been enabled again in this buffer")
    end
  end,
  {
    silent = true,
    desc = "Toggle completion",
  }
)

-- More consistent behavior of <CR>
local keys = {
  ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}
_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- If popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
  else
    return require('mini.pairs').cr()
  end
end

vim.keymap.set('i', '<CR>', 'v:lua._G.cr_action()', { expr = true })


--- Visualize and operate on indent scope
require("mini.indentscope").setup({
  symbol = "│",
})


--- Animations everywhere
require("mini.animate").setup({
  scroll = {
    enable = false, -- this thing is buggy af and `set smoothscroll` is a thing now
  },
})
