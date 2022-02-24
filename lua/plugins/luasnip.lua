local _2afile_2a = "fnl/plugins/luasnip.fnl"
local _2amodule_name_2a = "plugins.luasnip"
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
local _local_1_ = require("luasnip")
local config = _local_1_["config"]
local jump = _local_1_["jump"]
local expand_or_jumpable = _local_1_["expand_or_jumpable"]
local _local_2_ = require("luasnip/loaders/from_vscode")
local load = _local_2_["load"]
local _local_3_ = require("cmp")
local visible = _local_3_["visible"]
local select_prev_item = _local_3_["select_prev_item"]
local select_next_item = _local_3_["select_next_item"]
local complete = _local_3_["complete"]
config.set_config({history = true, updateevents = "TextChanged,TextChangedI"})
load()
local function t(s)
  _G.assert((nil ~= s), "Missing argument s on /home/alejandro/.config/nvim.fnl/fnl/plugins/luasnip.fnl:19")
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end
local function check_back_space()
  local col = (vim.fn.col(".") - 1)
  local ln = vim.fn.getline(".")
  if ((col == 0) or string.match(string.sub(ln, col, col), "%s")) then
    return true
  else
    return false
  end
end
local function on_tab()
  if visible() then
    select_next_item()
  elseif expand_or_jumpable() then
    t("<Plug>luasnip-expand-or-jump")
  elseif check_back_space() then
    t("<Tab>")
  else
    complete()
  end
  return ""
end
local function on_s_tab()
  if visible() then
    select_prev_item()
  elseif jump(-1) then
    t("<Plug>luasnip-jump-preview")
  else
    t("<S-Tab>")
  end
  return ""
end
return _2amodule_2a