--- buffers.lua - Magna buffers picker
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local picker = {}

local zf_select = require("magna.picker.ui").zf_select

--- Check if system-wide dependencies are available
---@return boolean
local function check_requirements()
  if vim.fn.executable("rg") == 0 then
    vim.notify("ripgrep not found in PATH", vim.log.levels.ERROR)
    return false
  end

  if vim.fn.executable("zf") == 0 then
    vim.notify("zf not found in PATH", vim.log.levels.ERROR)
    return false
  end

  return true
end

local function get_buffers()
  local bufs = {}

  local bufnrs = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(bufnrs) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) then
      local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":~")
      table.insert(bufs, { id = bufnr, name = buf_name })
    end
  end

  return bufs
end

local function run_buffers_picker(buf_list)
  zf_select(
    buf_list,
    {
      prompt = "Buffer Switcher",
      format_item = function(item)
        return ("%d: %s"):format(item.id, item.name)
      end
    },
    function(bufs)
      if not bufs then
        -- vim.notify("[picker] No file selected")
        return
      end

      ---@diagnostic disable-next-line undefined-field
      vim.cmd.buffer(bufs[1].id)
    end
  )
end

picker.open = function()
  -- Verify dependencies
  if not check_requirements() then
    return
  end

  -- Get all loaded buffers
  local bufs = get_buffers()

  run_buffers_picker(bufs)
end

return picker

--- buffers.lua ends here
