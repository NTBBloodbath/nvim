--- statusline.lua - Neovim statusline
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

-- Optional dependencies:
-- • gitsigns             | Git component (branch name, diff)
-- • toggleterm           | Terminal numbering
-- • nvim-web-devicons    | Filetype icons

--- Highlights ---
------------------
local hl_groups = {
  StatusLine = "%#StatusLine#",
  Red = "%#StatusColorRed#",
  Green = "%#StatusColorGrn#",
  Yellow = "%#StatusColorYlw#",
  Orange = "%#StatusColorOrg#",
  Violet = "%#StatusColorVio#",
  Blue = "%#StatusColorBlu#",
  modes = {
    n = "%#StatusColorRed#",
    no = "%#StatusColorRed#",
    nov = "%#StatusColorRed#",
    noV = "%#StatusColorRed#",
    ["no\22"] = "%#StatusColorRed#",
    i = "%#StatusColorGrn#",
    ic = "%#StatusColorGrn#",
    ix = "%#StatusColorGrn#",
    v = "%#StatusColorYlw#",
    V = "%#StatusColorYlw#",
    ["\22"] = "%#StatusColorYlw#",
    ["\22s"] = "%#StatusColorYlw#",
    c = "%#StatusColorVio#",
    R = "%#StatusColorBlu#",
    Rc = "%#StatusColorBlu#",
    Rx = "%#StatusColorBlu#",
    Rv = "%#StatusColorBlu#",
    Rvc = "%#StatusColorBlu#",
    Rvx = "%#StatusColorBlu#",
    ["!"] = "%#StatusColorOrg",
    t = "%#StatusColorRed#",
  },
}

local function setup_hl()
  local set_hl = vim.api.nvim_set_hl

  --- Colors ---
  --------------
  set_hl(0, "StatusColorBlu", { fg = "#75daff", bg = "#232331" })
  set_hl(0, "StatusColorGrn", { fg = "#91f582", bg = "#232331" })
  set_hl(0, "StatusColorYlw", { fg = "#f7e277", bg = "#232331" })
  set_hl(0, "StatusColorOrg", { fg = "#f4b47c", bg = "#232331" })
  set_hl(0, "StatusColorVio", { fg = "#c8b5ff", bg = "#232331" })
  set_hl(0, "StatusColorRed", { fg = "#e87272", bg = "#232331" })

  -- Reverse color hl groups, used by separators
  set_hl(0, "StatusColorBluInv", { bg = "#75daff", fg = "#232331" })
  set_hl(0, "StatusColorGrnInv", { bg = "#91f582", fg = "#232331" })
  set_hl(0, "StatusColorYlwInv", { bg = "#f7e277", fg = "#232331" })
  set_hl(0, "StatusColorOrgInv", { bg = "#f4b47c", fg = "#232331" })
  set_hl(0, "StatusColorVioInv", { bg = "#c8b5ff", fg = "#232331" })
  set_hl(0, "StatusColorRedInv", { bg = "#e87272", fg = "#232331" })
end

local function get_mode_hl() return hl_groups["modes"][vim.fn.mode()] end

--- Components ---
------------------
local spaces = { " ", "  ", "   " }
local align = "%="
local separator = {
  left = function() return table.concat({ get_mode_hl(), "", hl_groups["StatusLine"] }, "") end,
  right = function() return table.concat({ get_mode_hl(), "", hl_groups["StatusLine"] }, "") end,
}

local function get_mode()
  local inverse_mode_hl = get_mode_hl():gsub("#$", "Inv#")
  return table.concat(
    { inverse_mode_hl, spaces[2], " ", spaces[2], hl_groups["StatusLine"] },
    ""
  )
end

local function file_info()
  local file
  local file_path = vim.fn.fnamemodify(vim.fn.expand(vim.api.nvim_buf_get_name(0)), ":~:.")
  local file_extension = vim.api.nvim_buf_get_option(0, "filetype")

  local is_terminal_buffer = file_path:match("^term://") ~= nil

  --- File icon ---
  -----------------
  -- local file_icon, file_icon_hl
  -- local ok, devicons = pcall(require, "nvim-web-devicons")
  -- if ok then
  --   if is_terminal_buffer then
  --     file_icon, file_icon_hl = devicons.get_icon_by_filetype("terminal")
  --   else
  --     file_icon, file_icon_hl = devicons.get_icon_by_filetype(file_extension)
  --   end
  -- end
  --
  -- if file_icon then
  --   file = string.format("%%#%s#%s %s", file_icon_hl, file_icon, hl_groups["StatusLine"])
  -- end

  --- File name ---
  -----------------
  if file then
    if is_terminal_buffer then
      file = table.concat({ file, "Terminal" }, "")
      if vim.b.toggle_number then
        file = table.concat({ file, spaces[1], vim.b.toggle_number }, "")
      end
    else
      file = table.concat({ file, file_path }, "")
    end
  else
    file = file_path
  end

  return file
end

local function git_info()
  if not vim.b.gitsigns_head then return "" end

  local git

  --- Branch name ---
  -------------------
  git = table.concat({ hl_groups["Red"], " ", hl_groups["StatusLine"], vim.b.gitsigns_head }, "")

  --- Diff ---
  ------------
  local diff = {
    added = vim.b.gitsigns_status_dict.added or 0,
    changed = vim.b.gitsigns_status_dict.changed or 0,
    removed = vim.b.gitsigns_status_dict.removed or 0,
  }

  if diff.added > 0 then
    git = table.concat(
      { git, spaces[1], hl_groups["Green"], "+", diff.added, hl_groups["StatusLine"] },
      ""
    )
  end
  if diff.changed > 0 then
    git = table.concat(
      { git, spaces[1], hl_groups["Orange"], "~", diff.changed, hl_groups["StatusLine"] },
      ""
    )
  end
  if diff.removed > 0 then
    git = table.concat(
      { git, spaces[1], hl_groups["Red"], "-", diff.removed, hl_groups["StatusLine"] },
      ""
    )
  end

  return table.concat({ git, spaces[1] }, "")
end

local function ruler()
  local inverse_mode_hl = get_mode_hl():gsub("#$", "Inv#")
  return table.concat(
    { inverse_mode_hl, spaces[2], "%7(%l/%3L%):%2c %P", spaces[2], hl_groups["StatusLine"] },
    ""
  )
end

local function statusline()
  setup_hl()

  local components = {
    get_mode(),
    separator.left(),
    spaces[2],
    file_info(),
    align,
    git_info(),
    -- align,
    separator.right(),
    ruler(),
  }
  return table.concat(components, "")
end

return {
  set = statusline,
}

--- statusline.lua ends here