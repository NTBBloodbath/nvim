--- ts.lua - Core tree-sitter utilities
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local function make_conceal(start_node, end_node, conceal_char)
  local start_row, start_col, _, _ = start_node:range()
  local _, _, end_row, end_col = end_node:range()

  -- Set conceal for the combined range
  vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("make-conceal"), start_row, start_col, {
    end_row = end_row,
    end_col = end_col,
    conceal = conceal_char,
    ephemeral = true
  })
end

vim.treesitter.query.add_directive("make-conceal!", function(match, _, _, predicate)
  local nodes = { match[predicate[2]], match[predicate[3]] }
  vim.print(predicate)
  local conceal_char = predicate[4]:gsub('^"|"$', '') -- Extract conceal char
  make_conceal(nodes[1], nodes[2], conceal_char)
end, {})

--- ts.lua ends here
