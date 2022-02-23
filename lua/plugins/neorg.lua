local _2afile_2a = "fnl/plugins/neorg.fnl"
local _local_1_ = require("neorg")
local setup = _local_1_["setup"]
return setup({load = {["core.defaults"] = {}, ["core.norg.concealer"] = {}, ["core.norg.qol.toc"] = {}, ["core.norg.dirman"] = {config = {workspaces = {main = "~/neorg"}, autodetect = true, autochdir = true}}}})