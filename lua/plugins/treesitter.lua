local _2afile_2a = "fnl/plugins/treesitter.fnl"
local _local_1_ = require("nvim-treesitter.configs")
local setup = _local_1_["setup"]
local parser_config = (require("nvim-treesitter.parsers")).get_parser_configs()
parser_config.norg = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg", files = {"src/parser.c", "src/scanner.cc"}, branch = "main"}}
parser_config.norg_meta = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-meta", files = {"src/parser.c"}, branch = "main"}}
parser_config.norg_table = {install_info = {url = "https://github.com/nvim-neorg/tree-sitter-norg-table", files = {"src/parser.c"}, branch = "main"}}
return setup({ensure_installed = {"c", "lua", "fennel", "python", "markdown", "norg", "norg_meta", "norg_table"}, highlight = {enable = true, use_languagetree = true, custom_captures = {["punctuation.bracket"] = "", constructor = ""}}, indent = {enable = true, disable = {"python"}}, playground = {enable = true}, rainbow = {enable = true, extended_mode = true, max_file_lines = 1000, colors = {"#51afef", "#4db5bd", "#c678dd", "#a9a1e1"}}, update_strategy = "lockfile"})