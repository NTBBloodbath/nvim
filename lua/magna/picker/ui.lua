--- ui.lua - Magna file picker
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local ui = {}

---Create an interactive floating window with zf
---@param items string[]
---@param opts table
---@param on_choice fun(choice: string[]|nil)
function ui.zf_select(items, opts, on_choice)
  if not items or #items == 0 then
    on_choice(nil)
    return
  end

  opts = opts or {}

  -- Create floating window
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.4)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    title = opts.prompt and (" %s "):format(opts.prompt) or '',
    title_pos = 'center',
    style = 'minimal',
    border = 'rounded',
  })

  -- Format items
  if opts.format_item then
    for idx, item in ipairs(items) do
      items[idx] = opts.format_item(item)
    end
  else
    -- Mimic the vanilla vim.ui.select behavior
    for idx, item in ipairs(items) do
      items[idx] = tostring(item)
    end
  end

  -- Prepare items file (for large lists)
  local tempfile = os.tmpname()
  local items_file = io.open(tempfile, 'w')
  ---@diagnostic disable-next-line need-check-nil
  items_file:write(table.concat(items, '\n'))
  ---@diagnostic disable-next-line need-check-nil
  items_file:close()

  -- Configure zf command
  local cmd = {
    'cat',
    tempfile,
    '|',
    'zf',
    '--height',
    height,
  }
  if opts.preview then
    table.insert(cmd, "--preview")
    table.insert(cmd, "'cat " .. opts.root_dir .. "/{}'")
    table.insert(cmd, "--preview-width")
    table.insert(cmd, "50%")
  end
  -- Behave like fzf by default if no strict path matching wanted
  if not opts.paths then
    table.insert(cmd, "--plain")
  end

  -- Start interactive terminal
  vim.fn.jobstart(table.concat(cmd, " "), {
    term = true,
    cwd = vim.fn.getcwd(),
    env = { ZF_INPUT_FILE = tempfile },
    on_exit = function(_, code, _)
      vim.fs.rm(tempfile)
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
        if code == 0 then
          -- Get selection
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)
          for idx, line in ipairs(lines) do
            if line == "" then
              lines[idx] = nil
            end
          end

          on_choice(lines)
        else
          on_choice(nil)
        end

        -- Post cleanup
        if vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end)
    end
  })

  -- Keymaps for better UX
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:q!<CR>', { buffer = buf })
  vim.keymap.set('t', '<C-c>', '<C-\\><C-n>:q!<CR>', { buffer = buf })

  -- Focus and enter insert mode
  vim.cmd('startinsert')
end

return ui

--- ui.lua ends here
