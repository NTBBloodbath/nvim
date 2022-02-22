local _2afile_2a = "fnl/core/plugins.fnl"
vim.cmd("packadd packer.nvim")
local function _1_()
  use({opt = true, "wbthomason/packer.nvim"})
  use({opt = true, "Olical/aniseed"})
  use({opt = true, "NTBBloodbath/doom-one.nvim"})
  use({config = "require('Comment').setup()", "numToStr/Comment.nvim"})
  return use({config = "require('plugins.treesitter')", requires = {{"p00f/nvim-ts-rainbow"}, {cmd = "TSPlayground", "nvim-treesitter/playground"}}, run = ":TSUpdate", "nvim-treesitter/nvim-treesitter"})
end
return (require("packer")).startup(_1_)