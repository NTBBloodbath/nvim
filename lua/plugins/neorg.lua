local _2afile_2a = "/home/alejandro/.config/nvim.fnl/fnl/plugins/neorg.fnl"
local _2amodule_name_2a = "plugins.neorg"
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
local _local_1_ = require("neorg")
local setup = _local_1_["setup"]
setup({load = {["core.defaults"] = {}, ["core.norg.concealer"] = {}, ["core.norg.qol.toc"] = {}, ["core.norg.dirman"] = {config = {workspaces = {main = "~/neorg"}, autodetect = true, autochdir = true}}}})
return _2amodule_2a