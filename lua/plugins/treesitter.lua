local _2afile_2a = "/home/alejandro/.config/nvim.fnl/fnl/plugins/treesitter.fnl"
local _2amodule_name_2a = "plugins.treesitter"
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
local parsers = autoload("nvim-treesitter.parsers")
do end (_2amodule_locals_2a)["parsers"] = parsers
local _local_1_ = require("nvim-treesitter.configs")
local setup = _local_1_["setup"]
local parser_config = parsers.get_parser_configs()
parser_config.norg = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg", files = {"src/parser.c", "src/scanner.cc"}, branch = "main"}}
parser_config.norg_meta = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-meta", files = {"src/parser.c"}, branch = "main"}}
parser_config.norg_table = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-table", files = {"src/parser.c"}, branch = "main"}}
setup({ensure_installed = {"c", "lua", "vim", "fennel", "python", "markdown", "norg", "norg_meta", "norg_table"}, highlight = {enable = true, use_languagetree = true, custom_captures = {["punctuation.bracket"] = "", constructor = ""}}, indent = {enable = true, disable = {"python"}}, playground = {enable = true}, rainbow = {enable = true, extended_mode = true, max_file_lines = 1000, colors = {"#51afef", "#4db5bd", "#c678dd", "#a9a1e1"}}, update_strategy = "lockfile"})
return _2amodule_2a