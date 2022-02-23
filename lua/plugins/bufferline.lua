local _2afile_2a = "fnl/plugins/bufferline.fnl"
local _2amodule_name_2a = "plugins.bufferline"
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
local _local_1_ = require("bufferline")
local setup = _local_1_["setup"]
setup({options = {numbers = "buffer_id", max_name_length = 20, tab_size = 20, diagnostics = "nvim_lsp", offsets = {[{filetype = "help", text = "Help page", text_align = "center"}] = {filetype = "packer", text = "Plugins manager", text_align = "center"}}, show_buffer_icons = true, show_buffer_close_icons = true, show_close_button = false, sho_tab_indicators = true, persist_buffer_sort = true, separator_style = "slant", enforce_regular_tabs = true, always_show_bufferline = false, sort_by = "directory"}})
return _2amodule_2a