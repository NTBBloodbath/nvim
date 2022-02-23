local _2afile_2a = "fnl/plugins/indentlines.fnl"
local _2amodule_name_2a = "plugins.indentlines"
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
local _local_1_ = require("indent_blankline")
local setup = _local_1_["setup"]
setup({char = "\226\148\130", use_treesitter = true, show_first_indent_level = true, show_current_context = true, show_current_context_start = true, filetype_exclude = {"help", "packer", "norg", "fennel"}, buftype_exclude = {"terminal"}})
return _2amodule_2a