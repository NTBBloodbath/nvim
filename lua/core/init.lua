local _2afile_2a = "fnl/core/init.fnl"
local _2amodule_name_2a = "core.init"
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
require("core.config")
require("core.maps")
require("core.plugins")
return _2amodule_2a