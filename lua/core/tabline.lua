local blend_colors = require("utils.colors").blend_colors

local tabline_framework = require("tabline_framework")
local devicons = require("nvim-web-devicons")

--- Tabline dynamic color palette
local function get_color(name)
  ---@diagnostic disable undefined-field
  local palette = require("sweetie.colors").get_palette(vim.opt.background:get())

  local palette = {
    fg1 = palette.fg,
    fg2 = palette.fg_alt,
    bg1 = palette.bg,
    bg2 = palette.bg_alt,
    bg3 = palette.bg_hl,
    red = palette.red,
    org = palette.orange,
    ylw = palette.yellow,
    grn = palette.green,
    cya = palette.cyan,
    blu = palette.blue,
    tea = palette.teal,
    mag = palette.magenta,
    acc = palette.violet
  }

  return palette[name]
end

local function get_hl_group_property(name, prop)
  local hl_group_prop = vim.api.nvim_get_hl(0, { name = name })[prop]
  return string.format("#%06X", hl_group_prop)
end

--- Tabline setup
local function render(f)
  f.make_bufs(function(info)
    local file_icon, file_icon_hl = f.icon(info.filename), f.icon_color(info.filename)
    local file_extension = vim.fn.fnamemodify(info.filename, ":e")


    local custom_txt_icons = { "man", "norg", "help" }
    if not file_icon then
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
      -- NOTE: I have to manually load the highlight groups early so I can add the background to them
      if file_icon_hl then
        devicons.set_up_highlights()
        vim.cmd("hi " .. file_icon_hl .. " guibg=" .. get_hl_group_property("StatusLine", "bg"))
      end
    end

    -- Fallback to a custom icon if the file_icon is still non-existent
    file_icon = file_icon and file_icon or ""
    -- Fallback to foreground color if the file icon highlighting is still non-existent
    file_icon_hl = file_icon_hl and file_icon_hl or get_color("fg1")

    local color_fg = info.current and file_icon_hl or blend_colors(file_icon_hl, get_color("bg1"), 0.6)
    local color_bg = info.current and blend_colors(file_icon_hl, get_color("bg1"), 0.38) or blend_colors(file_icon_hl, get_color("bg1"), 0.2)

    f.add({
      ("  " .. file_icon .. " "),
      fg = color_fg,
      bg = color_bg,
    })
    f.add({
      (info.filename and info.filename or "Empty") .. " ",
      fg = color_fg,
      bg = color_bg,
    })
    f.add({
      (info.modified and "•" or "✕") .. " ",
      fg = info.modified and color_fg or (info.current and get_color("red") or color_fg),
      bg = color_bg,
    })
  end)
  f.add_spacer()
  f.make_tabs(function(info)
    f.add(" " .. info.index .. " ")
  end)
end
tabline_framework.setup({ render = render })

-- Fix for white colors on colorscheme change
vim.api.nvim_create_augroup("Tabline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "Tabline",
  callback = function()
    tabline_framework.setup({ render = render })
  end,
})
