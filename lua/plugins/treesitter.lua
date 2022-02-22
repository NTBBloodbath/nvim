local _2afile_2a = "fnl/plugins/treesitter.fnl"
local _local_1_ = require("nvim-treesitter.configs")
local setup = _local_1_["setup"]
return setup({ensure_installed = {"c", "lua", "fennel", "python"}, highlight = {enable = true, use_languagetree = true, custom_captures = {["punctuation.bracket"] = "", constructor = ""}}, indent = {enable = true, disable = {"python"}}, playground = {enable = true}, rainbow = {enable = true, extended_mode = true, max_file_lines = 1000, colors = {"#51afef", "#4db5bd", "#c678dd", "#a9a1e1"}}, update_strategy = "lockfile"})