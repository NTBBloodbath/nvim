--- utils.lua - Autocommands functions
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local function preserve_position()
  if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
    vim.cmd("normal! g'\"")
  end
end

local function create_directory_on_save()
  local fpath = vim.fn.expand("<afile>")
  local dir = vim.fn.fnamemodify(fpath, ":p:h")

  if vim.fn.isdirectory(dir) ~= 1 then
    vim.fn.mkdir(dir, "p")
  end
end

local function show_tabline()
  -- This function shows tabline based on the following requirements:
  --
  -- 1. Two or more buffers in current tabpage
  -- 2. Two or more tabpages

  local ls = vim.split(vim.api.nvim_exec("ls", true), "\n")
  local bufs = vim.tbl_map(function(buf)
    return tonumber(buf:match("%d+"))
  end, ls)

  local tabs = vim.api.nvim_list_tabpages()

  return #bufs >= 2 or #tabs >= 2
end

return {
  preserve_position = preserve_position,
  create_directory_on_save = create_directory_on_save,
  show_tabline = show_tabline,
}

--- utils.lua
