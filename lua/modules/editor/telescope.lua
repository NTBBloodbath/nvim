local telescope = require("telescope")
local ivy = require("telescope.themes").get_ivy

local load_extension = telescope.load_extension

local function get_dev_directories()
	return vim.split(vim.fn.globpath(vim.fn.expand("~/Development"), "*"), "\n")
end

telescope.setup({
	defaults = ivy(),
	extensions = {
		project = {
			base_dirs = get_dev_directories(),
		},
	},
})

--- Load extensions
load_extension("project")
load_extension("software-licenses")
