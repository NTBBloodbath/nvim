local _2afile_2a = "fnl/core/plugins.fnl"
local is_nightly = false
vim.cmd("packadd packer.nvim")
local rainbow_commit = nil
if not is_nightly then
  rainbow_commit = "c6c26c4def0e9cd82f371ba677d6fc9baa0038af"
else
end
local function _2_()
  use({opt = true, "wbthomason/packer.nvim"})
  use({opt = true, "Olical/aniseed"})
  use({opt = true, "NTBBloodbath/doom-one.nvim"})
  use({config = "require('Comment').setup()", event = "BufWinEnter", "numToStr/Comment.nvim"})
  use({config = "require('plugins.treesitter')", opt = true, requires = {{commit = rainbow_commit, "p00f/nvim-ts-rainbow"}, {cmd = "TSPlayground", "nvim-treesitter/playground"}}, run = ":TSUpdate", "nvim-treesitter/nvim-treesitter"})
  use({config = "require('pairs').setup()", event = "InsertEnter", "ZhiyuanLck/smart-pairs"})
  use({config = "require('plugins.statusline')", opt = true, requires = {{module = "nvim-web-devicons", "kyazdani42/nvim-web-devicons"}, {after = "nvim-treesitter", config = "require('nvim-gps').setup()", "SmiteshP/nvim-gps"}}, "rebelot/heirline.nvim"})
  use({config = "require('gitsigns').setup()", event = "BufWinEnter", requires = {{module = "plenary", "nvim-lua/plenary.nvim"}}, "lewis6991/gitsigns.nvim"})
  return use({after = "nvim-treesitter", config = "require('plugins.neorg')", "nvim-neorg/neorg"})
end
do end (require("packer")).startup(_2_)
return vim.cmd("PackerInstall")