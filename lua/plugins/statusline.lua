local _2afile_2a = "fnl/plugins/statusline.fnl"
local _local_1_ = table
local insert = _local_1_["insert"]
local fennelview = require("core.fennelview")
local _local_2_ = require("nvim-web-devicons")
local get_icon_color = _local_2_["get_icon_color"]
local _local_3_ = require("heirline")
local setup = _local_3_["setup"]
local _local_4_ = require("heirline.utils")
local make_flexible_component = _local_4_["make_flexible_component"]
local pick_child_on_condition = _local_4_["pick_child_on_condition"]
local get_highlight = _local_4_["get_highlight"]
local _local_5_ = require("heirline.conditions")
local width_percent_below = _local_5_["width_percent_below"]
local border_left = {}
border_left.provider = function(self)
  return "\226\150\138"
end
border_left.hl = function(self)
  local hl = {fg = "#51afef", style = "bold"}
  return hl
end
local border_right = {}
border_right.provider = function(self)
  return "\226\150\138"
end
border_right.hl = function(self)
  local hl = {fg = "#51afef", bg = "#23272e", style = "bold"}
  return hl
end
local align = {provider = "%=", bg = "#23272e"}
local space = {provider = " ", bg = "#23272e"}
local vi_mode = {static = {names = {n = "Normal", no = "Normal", i = "Insert", t = "Terminal", v = "Visual", V = "Visual", r = "Replace", R = "Replace", Rv = "Replace", c = "Command"}, colors = {n = "#ff6c6b", no = "#ff6c6b", i = "#98be65", t = "#ff6c6b", v = "#51afef", V = "#51afef", r = "#4db5bd", R = "#c678dd", Rv = "#c678dd", c = "#c678dd"}}}
vi_mode.init = function(self)
  self.mode = vim.fn.mode()
  return nil
end
vi_mode.provider = function(self)
  return "\239\140\140 "
end
vi_mode.hl = function(self)
  local mode = (self.mode):sub(1, 1)
  local hl = {fg = self.colors[mode], bg = "#23272e", style = "bold"}
  return hl
end
local file_info = {}
file_info.init = function(self)
  self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  self.extension = vim.fn.fnamemodify(self.filename, ":e")
  return nil
end
local file_icon = {}
file_icon.init = function(self)
  local icon, icon_color = get_icon_color(self.filename, self.extension, {default = true})
  self.icon = icon
  self.icon_color = icon_color
  return nil
end
file_icon.provider = function(self)
  if not false then
    return (self.icon .. " ")
  else
    return self.icon
  end
end
file_icon.hl = function(self)
  local hl = {fg = self.icon_color, bg = "#23272e"}
  return hl
end
local file_name = {}
local function _7_()
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  if (#filename == 0) then
    return "[No Name]"
  else
    return filename
  end
end
local function _9_()
  return vim.fn.pathshorten(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":."))
end
insert(file_name, make_flexible_component(2, {provider = _7_}, {provider = _9_}))
file_name.hl = function(self)
  local hl = {fg = "#bbc2cf", bg = "#23272e"}
  return hl
end
local file_flags
local function _10_()
  if (vim.bo.modified == true) then
    return "[+]"
  else
    return nil
  end
end
local function _12_()
  if (not vim.bo.modifiable or vim.bo.readonly) then
    return "\239\128\163"
  else
    return nil
  end
end
file_flags = {{provider = _10_, hl = {fg = "#98be65", bg = "#23272e"}}, {provider = _12_, hl = {fg = "#ecbe7b", bg = "#23272e"}}}
insert(file_info, file_icon)
insert(file_info, file_name)
insert(file_info, space)
insert(file_info, file_flags)
insert(file_info, {provider = "%<", hl = {bg = "#23272e"}})
local default_statusline = {border_left, space, vi_mode, space, file_info, align, border_right}
default_statusline.init = function(self)
  return pick_child_on_condition
end
default_statusline.hl = function(self)
  local statusline = get_highlight("StatusLine")
  return {fg = statusline[fg], bg = statusline[bg]}
end
return setup({default_statusline})