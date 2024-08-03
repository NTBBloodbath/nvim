require("tabby.tabline").use_preset("active_wins_at_tail", {
  theme = {
    fill = "TabLineFill",
    head = "TabLine",
    current_tab = "TabLineSel",
    tab = "TabLine",
    win = "TabLine",
    tail = "TabLine",
  },
  nerdfont = true,
  lualine_theme = nil,
  buf_name = {
    mode = "unique",
  },
})
