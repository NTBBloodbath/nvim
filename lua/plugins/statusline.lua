local _2afile_2a = "fnl/plugins/statusline.fnl"
local _2amodule_name_2a = "plugins.statusline"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local conditions, devicons, nvim_gps, utils = autoload("heirline.conditions"), autoload("nvim-web-devicons"), autoload("nvim-gps"), autoload("heirline.utils")
do end (_2amodule_locals_2a)["conditions"] = conditions
_2amodule_locals_2a["devicons"] = devicons
_2amodule_locals_2a["nvim-gps"] = nvim_gps
_2amodule_locals_2a["utils"] = utils
local _local_1_ = table
local insert = _local_1_["insert"]
local _local_2_ = string
local upper = _local_2_["upper"]
local format = _local_2_["format"]
local _local_3_ = autoload("heirline")
local setup = _local_3_["setup"]
local function get_hl(kind)
  _G.assert((nil ~= kind), "Missing argument kind on /var/home/alejandro/.config/nvim.fnl/fnl/plugins/statusline.fnl:17")
  local statusline = utils.get_highlight("StatusLine")
  if not conditions.is_active() then
    statusline = utils.get_highlight("StatusLineNC")
  else
  end
  return statusline[kind]
end
local border_left = {}
border_left.provider = function(self)
  return "\226\150\138"
end
border_left.hl = function(self)
  local hl = {fg = "#51afef", bg = get_hl("bg"), style = "bold"}
  return hl
end
local border_right = {}
border_right.provider = function(self)
  return "\226\150\138"
end
border_right.hl = function(self)
  local hl = {fg = "#51afef", bg = get_hl("bg"), style = "bold"}
  return hl
end
local align = {provider = "%="}
local space = {provider = " "}
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
  local hl = {fg = self.colors[mode], bg = get_hl("bg"), style = "bold"}
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
  local icon, icon_color = devicons.get_icon_color(self.filename, self.extension, {default = true})
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
  local hl = {fg = self.icon_color, bg = get_hl("bg")}
  return hl
end
local file_name = {}
local function _6_()
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  if (#filename == 0) then
    return "[No Name]"
  else
    return filename
  end
end
local function _8_()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
end
insert(file_name, utils.make_flexible_component(2, {provider = _6_}, {provider = _8_}))
file_name.hl = function(self)
  local hl = {fg = get_hl("fg"), bg = get_hl("bg")}
  return hl
end
local file_flags
local function _9_()
  if (vim.bo.modified == true) then
    return "\239\145\136 "
  else
    return nil
  end
end
local function _11_()
  if (not vim.bo.modifiable or vim.bo.readonly) then
    return "\239\128\163 "
  else
    return nil
  end
end
file_flags = {{provider = _9_, hl = {fg = get_hl("fg"), bg = "#23272e"}}, {provider = _11_, hl = {fg = "#ecbe7b", bg = get_hl("bg")}}}
insert(file_info, file_icon)
insert(file_info, file_name)
insert(file_info, space)
insert(file_info, space)
insert(file_info, file_flags)
insert(file_info, {provider = "%<"})
local ruler = {provider = "%7(%l/%3L%):%2c %P"}
local git = {condition = conditions.is_git_repo}
git.init = function(self)
  self["status-dict"] = vim.b.gitsigns_status_dict
  if (not ((self["status-dict"]).added == 0) or not ((self["status-dict"]).removed == 0) or not ((self["status-dict"]).changed == 0)) then
    self.has_changes = true
    return nil
  else
    self.has_changes = false
    return nil
  end
end
local git_branch = {}
local git_branch_icon = {provider = "\239\158\161 ", hl = {fg = "#ff6c6b"}}
local git_branch_name = {}
git_branch_name.provider = function(self)
  return (self["status-dict"]).head
end
insert(git_branch, git_branch_icon)
insert(git_branch, git_branch_name)
local git_diff_spacing = {provider = " "}
git_diff_spacing.condition = function(self)
  return self.has_changes
end
local git_added = {}
git_added.provider = function(self)
  local count = (self["status-dict"]).added
  if (not (count == nil) and (count > 0)) then
    return format("\239\145\151 %d", count)
  else
    return nil
  end
end
git_added.hl = function(self)
  return {fg = "#98be65"}
end
local git_removed = {}
git_removed.provider = function(self)
  local count = (self["status-dict"]).removed
  if (not (count == nil) and (count > 0)) then
    return format("\239\145\152 %d ", count)
  else
    return nil
  end
end
git_removed.hl = function(self)
  return {fg = "#ff6c6b"}
end
local git_changed = {}
git_changed.provider = function(self)
  local count = (self["status-dict"]).changed
  if (not (count == nil) and (count > 0)) then
    return format("\239\145\153 %d", count)
  else
    return nil
  end
end
git_changed.hl = function(self)
  return {fg = "#da8548"}
end
insert(git, git_branch)
insert(git, git_diff_spacing)
insert(git, git_added)
insert(git, git_diff_spacing)
insert(git, git_removed)
insert(git, git_changed)
local gps = {condition = nvim_gps.is_available}
gps.provider = function(self)
  return nvim_gps.get_location()
end
local default_statusline = {border_left, space, vi_mode, space, file_info, align, gps, align, git, space, ruler, space, border_right}
default_statusline.init = function(self)
  return utils.pick_child_on_condition
end
default_statusline.hl = function(self)
  local fg = get_hl("fg")
  local bg = get_hl("bg")
  return {fg = fg, bg = bg}
end
setup({default_statusline})
return _2amodule_2a