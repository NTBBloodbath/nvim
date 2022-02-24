local _2afile_2a = "fnl/core/plugins.fnl"
local _2amodule_name_2a = "core.plugins"
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
local packer = autoload("packer")
do end (_2amodule_locals_2a)["packer"] = packer
local is_nightly = true
local fennelview = require("core.fennelview")
vim.cmd("packadd packer.nvim")
local function open_fn()
  local _local_1_ = require("packer.util")
  local float = _local_1_["float"]
  return float({border = "single"})
end
packer.init({opt_default = true, git = {clone_timeout = 300}, display = {open_fn = open_fn}, profile = {enable = true}})
local rainbow_commit = nil
if not is_nightly then
  rainbow_commit = "c6c26c4def0e9cd82f371ba677d6fc9baa0038af"
else
end
local function _3_()
  use({"wbthomason/packer.nvim"})
  use({"Olical/aniseed"})
  use({"lewis6991/impatient.nvim"})
  use({"NTBBloodbath/doom-one.nvim"})
  use({config = "require('Comment').setup()", event = "BufWinEnter", "numToStr/Comment.nvim"})
  use({config = "require('plugins.treesitter')", requires = {{commit = rainbow_commit, "p00f/nvim-ts-rainbow"}, {cmd = "TSPlayground", "nvim-treesitter/playground"}}, run = ":TSUpdate", "nvim-treesitter/nvim-treesitter"})
  use({config = "require('pairs'):setup()", event = "InsertEnter", "ZhiyuanLck/smart-pairs"})
  use({module = "nvim-web-devicons", "kyazdani42/nvim-web-devicons"})
  use({config = "require('plugins.indentlines')", event = "BufWinEnter", "lukas-reineke/indent-blankline.nvim"})
  use({config = "require('plugins.bufferline')", event = "BufWinEnter", "akinsho/bufferline.nvim"})
  use({config = "require('plugins.statusline')", requires = {{after = "nvim-treesitter", config = "require('nvim-gps').setup()", "SmiteshP/nvim-gps"}}, "rebelot/heirline.nvim"})
  use({config = "require('gitsigns').setup()", event = "ColorScheme", requires = {{module = "plenary", "nvim-lua/plenary.nvim"}}, "lewis6991/gitsigns.nvim"})
  use({after = "nvim-treesitter", config = "require('plugins.neorg')", "nvim-neorg/neorg"})
  use({config = "require('plugins.lspconfig')", event = "BufWinEnter", "neovim/nvim-lspconfig"})
  use({module = "lua-dev", "folke/lua-dev.nvim"})
  use({module = "lsp_signature", "ray-x/lsp_signature.nvim"})
  return use({config = "require('plugins.cmp')", event = "BufReadPre", requires = {{config = "require('plugins.luasnip')", event = "BufReadPre", requires = {{opt = false, "rafamadriz/friendly-snippets"}}, wants = "friendly-snippets", "L3MON4D3/LuaSnip"}, {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-cmdline"}, {"saadparwaiz1/cmp_luasnip"}, {module = "cmp-under-comparator", "lukas-reineke/cmp-under-comparator"}}, wants = {"LuaSnip"}, "hrsh7th/nvim-cmp"})
end
do end (require("packer")).startup(_3_)
vim.cmd("PackerInstall")
return _2amodule_2a