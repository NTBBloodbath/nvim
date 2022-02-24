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
return _2amodule_2a