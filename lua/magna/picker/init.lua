--- init.lua - Magna picker init
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

--- Get the project root directory, fallback to current working directory if no VCS repository has been found
---@return string
local function get_root_dir()
  local cwd = vim.fn.getcwd()
  local git_root = vim.fs.root(0, ".git")
  local jj_root = vim.fs.root(0, ".jj")

  return git_root or jj_root or cwd
end

--- Run the file picker
---@param path string Project root directory
local function run_file_picker(path)
  local files = {}

  local rg_cmd = {
    "rg",
    "--files",
    "--hidden",
    "--follow",
    "--no-require-git",
    "--color=never",
    "--sort=path",
    "-g!.{git,jj}/*",
  }
  vim
    .system(rg_cmd, {
      cwd = path,
      stdout = function(_, data)
        if data ~= nil then
          for _, file in ipairs(vim.split(data, "\n")) do
            if file ~= "" then
              table.insert(files, file)
            end
          end
        end
      end,
    })
    :wait()

  zf_select(files, { prompt = "Fuzzy Finder", preview = true, root_dir = path, paths = true }, function(file)
    if not file then
      -- vim.notify("[picker] No file selected")
      return
    end
    vim.cmd.edit(vim.fs.joinpath(path, file))
  end)
end

--- Open the file picker
picker.open = function()
  -- Verify dependencies
  if not check_requirements() then
    return
  end

  -- Get project root (fallback to current dir)
  local root = get_root_dir()

  run_file_picker(root)
end

return picker

--- init.lua ends here
