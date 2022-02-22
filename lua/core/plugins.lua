local _2afile_2a = "fnl/core/plugins.fnl"
vim.cmd("packadd packer.nvim")
local function _1_()
  use({opt = true, "wbthomason/packer.nvim"})
  use({opt = true, "Olical/aniseed"})
  use({opt = true, "NTBBloodbath/doom-one.nvim"})
  use({config = "require('Comment').setup()", "numToStr/Comment.nvim"})
  use({config = "require('plugins.treesitter')", opt = true, requires = {{"p00f/nvim-ts-rainbow"}, {cmd = "TSPlayground", "nvim-treesitter/playground"}}, run = ":TSUpdate", "nvim-treesitter/nvim-treesitter"})
  use({config = "require('pairs').setup()", disable = true, event = "BufWinEnter", "ZhiyuanLck/smart-pairs"})
  use({config = "require('plugins.statusline')", opt = true, requires = {{module = "nvim-web-devicons", "kyazdani42/nvim-web-devicons"}}, "rebelot/heirline.nvim"})
  return use({config = "require('gitsigns').setup()", event = "BufWinEnter", requires = {{module = "plenary", "nvim-lua/plenary.nvim"}}, "lewis6991/gitsigns.nvim"})
end
do end (require("packer")).startup(_1_)
return vim.cmd("PackerInstall")