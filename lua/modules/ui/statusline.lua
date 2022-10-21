local heirline = require("heirline")
local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

--- Colors
local function setup_colors()
	local doom_one_palette = require("doom-one.colors").get_palette(vim.o.background)
	return {
		fg1 = utils.get_highlight("StatusLine").fg,
		bg1 = utils.get_highlight("StatusLine").bg,
		red = doom_one_palette.red,
		ylw = doom_one_palette.yellow,
		org = doom_one_palette.orange,
		grn = doom_one_palette.green,
		cya = doom_one_palette.cyan,
		blu = doom_one_palette.blue,
		mag = doom_one_palette.magenta,
		vio = doom_one_palette.violet,
	}
end
heirline.load_colors(setup_colors())

--- Components
--
-- Spacing
local align, space = { provider = "%=" }, { provider = " " }

-- Vi-mode
local vi_mode = {
	static = {
		names = {
			n = "Normal",
			no = "Normal",
			i = "Insert",
			t = "Terminal",
			v = "Visual",
			V = "Visual (line)",
			s = "Select",
			S = "Select (line)",
			R = "Replace",
			Rv = "Replace",
			r = "Prompt",
			c = "Command",
		},
		colors = {
			n = "red",
			no = "red",
			i = "grn",
			t = "red",
			v = "blu",
			V = "blu",
			s = "cya",
			S = "cya",
			R = "mag",
			Rv = "mag",
			r = "cya",
			c = "mag",
		},
	},

	init = function(self)
		self.mode = vim.fn.mode()
	end,
	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return {
			bg = "bg1",
			fg = self.colors[mode],
			bold = true,
		}
	end,
}
vi_mode.provider = function(self)
	-- return "    "
	return "    " .. vi_mode.static.names[self.mode] .. " "
end

-- File (name, icon)
local file_name = utils.make_flexible_component(2, {
	provider = function()
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
		return filename:len() == 0 and "[No Name]" or filename
	end,
}, {
	provider = function()
		return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	end,
})
file_name.hl = function(self)
	return { bg = "bg1", fg = "fg1" }
end

local file_flags = {
	{
		provider = function()
			return vim.bo.modified and " " or ""
		end,
		hl = { bg = "bg1", fg = "ylw" },
	},
	{
		provider = function()
			if not vim.bo.modifiable or vim.bo.readonly then
				return " "
			end
			return ""
		end,
		hl = { bg = "bg1", fg = "ylw" },
	},
}
local file_info = {
	init = function(self)
		self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
		self.extension = vim.fn.fnamemodify(self.filename, ":e")
	end,
	file_name,
	space,
	space,
	file_flags,
	{ provider = "%<" },
}

-- Ruler
-- %l = current line number
-- %L = number of lines in the buffer
-- %c = column number
-- %P = percentage through file of displayed window
local ruler = { provider = "%7(%l/%3L%):%2c  %P" }

-- Git
local git_branch = {
	{ provider = " ", hl = { fg = "red" } },
	{
		provider = function(self)
			return self.status_dict.head
		end,
	},
	space,
}

local git_diff_spacing = {
	provider = " ",
	condition = function(self)
		return self.has_changes
	end,
}
local git_added = {
	provider = function(self)
		local count = self.status_dict.added
		if count and count > 0 then
			string.format(" %d", count)
		end
	end,
	hl = { fg = "grn" },
}
local git_removed = {
	provider = function(self)
		local count = self.status_dict.removed
		if count and count > 0 then
			string.format(" %d", count)
		end
	end,
	hl = { fg = "red" },
}
local git_changed = {
	provider = function(self)
		local count = self.status_dict.changed
		if count and count > 0 then
			string.format(" %d", count)
		end
	end,
	hl = { fg = "org" },
}

local git = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.has_changes = false
		self.status_dict = vim.b.gitsigns_status_dict
		if
			not self.status_dict.added == 0
			or not self.status_dict.removed == 0
			or not self.status_dict.changed == 0
		then
			self.has_changes = true
		end
	end,
	git_branch,
	git_diff_spacing,
	git_added,
	git_diff_spacing,
	git_removed,
	git_diff_spacing,
	git_changed,
	git_diff_spacing,
}

-- Diagnostics
local diagnostics = {
	condition = conditions.has_diagnostics,
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	{
		provider = function(self)
			if self.errors > 0 then
				return " " .. self.errors
			end
		end,
		hl = { fg = "red" },
	},
	{
		provider = function(self)
			if self.warnings > 0 then
				return " " .. self.warnings
			end
		end,
		hl = { fg = "ylw" },
	},
	{
		provider = function(self)
			if self.hints > 0 then
				return " " .. self.hints
			end
		end,
		hl = { fg = "grn" },
	},
	{
		provider = function(self)
			if self.info > 0 then
				return " " .. self.info
			end
		end,
		hl = { fg = "cya" },
	},
}

-- Terminal name
local terminal_name = {
	provider = function(self)
		string.format("Terminal %d", vim.b.toggle_number)
	end,
}

--- Statuslines
--
-- Default
local default = { space, vi_mode, space, file_info, diagnostics, align, git, space, ruler, space, space, space }
default.hl = function(self)
	return { bg = "bg1", fg = "fg1" }
end

-- Terminal
local terminal = { space, terminal_name, align }
terminal.hl = function(self)
	return { bg = "bg1", fg = "fg1" }
end
terminal.condition = function(self)
	return vim.bo.filetype == "toggleterm"
end

heirline.setup({
	fallthrough = false,
	terminal,
	default,
})

-- Fix for white colors on colorscheme change
vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "Heirline",
	callback = function()
		local colors = setup_colors()
		utils.on_colorscheme(colors)
	end,
})
