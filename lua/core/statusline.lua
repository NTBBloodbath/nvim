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
    s = "%#StatusColorBlu#",
    S = "%#StatusColorBlu#",
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
    ["!"] = "%#StatusColorOrg#",
    t = "%#StatusColorRed#",
  },
}

local function get_hl_group_property(name, prop)
  local hl_group_prop = vim.api.nvim_get_hl(0, { name = name })[prop]
  return string.format("#%06X", hl_group_prop)
end

local function get_palette()
  local palette = require("sweetie.colors").get_palette(vim.opt.background:get())
  return {
    red = palette.red,
    blue = palette.blue,
    green = palette.green,
    yellow = palette.yellow,
    orange = palette.orange,
    violet = palette.violet,
  }
end

local function setup_hl()
  local set_hl = vim.api.nvim_set_hl

  -- Get `:hi StatusLine` guibg option dynamically and convert it from RGB to Hex
  local statusline_bg = get_hl_group_property("StatusLine", "bg")
  local colors = get_palette()

  --- Colors ---
  --------------
  set_hl(0, "StatusColorBlu", { fg = colors.blue, bg = statusline_bg })
  set_hl(0, "StatusColorGrn", { fg = colors.green, bg = statusline_bg })
  set_hl(0, "StatusColorYlw", { fg = colors.yellow, bg = statusline_bg })
  set_hl(0, "StatusColorOrg", { fg = colors.orange, bg = statusline_bg })
  set_hl(0, "StatusColorVio", { fg = colors.violet, bg = statusline_bg })
  set_hl(0, "StatusColorRed", { fg = colors.red, bg = statusline_bg })

  -- Reverse color hl groups, used by separators
  set_hl(0, "StatusColorBluInv", { bg = colors.blue, fg = statusline_bg })
  set_hl(0, "StatusColorGrnInv", { bg = colors.green, fg = statusline_bg })
  set_hl(0, "StatusColorYlwInv", { bg = colors.yellow, fg = statusline_bg })
  set_hl(0, "StatusColorOrgInv", { bg = colors.orange, fg = statusline_bg })
  set_hl(0, "StatusColorVioInv", { bg = colors.violet, fg = statusline_bg })
  set_hl(0, "StatusColorRedInv", { bg = colors.red, fg = statusline_bg })
end

local function get_mode_hl()
  return hl_groups["modes"][vim.fn.mode()]
end

local function get_mode_name()
  local modes = {
    n = "NOR",
    no = "NOR",
    nov = "NOR",
    noV = "NOR",
    ["no\22"] = "NOR",
    i = "INS",
    ic = "INS",
    ix = "INS",
    s = "SEL",
    S = "SEL",
    v = "VIS",
    V = "VIS",
    ["\22"] = "VIS",
    ["\22s"] = "VIS",
    c = "CMD",
    R = "REP",
    Rc = "REP",
    Rx = "REP",
    Rv = "REP",
    Rvc = "REP",
    Rvx = "REP",
    ["!"] = "CMD",
    t = "TERM",
  }
  return modes[vim.fn.mode()]
end

--- Components ---
------------------
local spaces = { " ", "  ", "   " }
local align = "%="
local separator = {
  left = function()
    return table.concat({ get_mode_hl(), "", hl_groups["StatusLine"] }, "")
  end,
  right = function()
    return table.concat({ get_mode_hl(), "", hl_groups["StatusLine"] }, "")
  end,
}

local function get_mode()
  local inverse_mode_hl = get_mode_hl():gsub("#$", "Inv#")
  return table.concat(
    { inverse_mode_hl, spaces[2], get_mode_name(), spaces[2], hl_groups["StatusLine"] },
    ""
  )
end

local function file_info()
  local file
  local file_path = vim.fn.fnamemodify(vim.fn.expand(vim.api.nvim_buf_get_name(0)), ":~:.")
  local file_extension = vim.api.nvim_get_option_value("filetype", { buf = 0 })

  local is_terminal_buffer = file_path:match("^term://") ~= nil
  local custom_txt_icons = { "man", "norg", "help" }

  --- File icon ---
  -----------------
  if file_extension ~= "" then
    local file_icon, file_icon_hl
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      if is_terminal_buffer then
        file_icon, file_icon_hl = devicons.get_icon_by_filetype("terminal")
      else
        -- Use the Git icon for jujutsu
        file_extension = file_extension == "jj" and "git" or file_extension
        -- Fallback to HTML icon in filetypes like htmldjango
        file_extension = file_extension:find("html") and "html" or file_extension
        -- There is no icon for filetypes such as 'man', 'norg' or 'help' so we have to fallback to 'txt' in them
        file_extension = vim.iter(custom_txt_icons):find(file_extension) and "txt" or file_extension
        file_icon, file_icon_hl = devicons.get_icon_by_filetype(file_extension)
      end
    end
    -- NOTE: I have to manually load the highlight groups early so I can add the background to them
    devicons.set_up_highlights()
    vim.cmd("hi " .. file_icon_hl .. " guibg=" .. get_hl_group_property("StatusLine", "bg"))

    if file_icon then
      file = string.format("%%#%s#%s %s", file_icon_hl, file_icon, hl_groups["StatusLine"])
    end
  else
    -- The current buffer is a directory (opened Neovim with no arguments)
    if vim.fn.argc() == 0 then
      vim.cmd(
        "hi DevIconDirectory guifg="
          .. get_palette().yellow
          .. " guibg="
          .. get_hl_group_property("StatusLine", "bg")
      )
      file = string.format("%%#%s#%s %s", "DevIconDirectory", "", hl_groups["StatusLine"])
    end
  end

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
    if is_terminal_buffer then
      if vim.b.toggle_number then
        file = table.concat({ "Terminal", spaces[1], vim.b.toggle_number }, "")
      end
    else
      file = file_path
    end
  end

  return file
end

local function git_info()
  if not vim.b.gitsigns_head then
    return ""
  end

  local git

  --- Branch name ---
  -------------------
  git = table.concat({ hl_groups["Red"], " ", hl_groups["StatusLine"], vim.b.gitsigns_head }, "")

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
    { inverse_mode_hl, spaces[1], " %7(%l/%3L%):%2c %P", spaces[1], hl_groups["StatusLine"] },
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
