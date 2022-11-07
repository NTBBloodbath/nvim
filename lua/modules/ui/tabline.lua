local blend_colors = require("utils.colors").blend_colors

--- Tabline dynamic color palette
local function get_color(name)
	local doom_one_palette = require("doom-one.colors").get_palette(vim.o.background)
	local palette = {
		fg1 = doom_one_palette.fg,
		fg2 = doom_one_palette.fg_alt,
		bg1 = doom_one_palette.base0,
		bg2 = doom_one_palette.bg,
		bg3 = doom_one_palette.bg,
		bg4 = doom_one_palette.bg_alt,
		red = doom_one_palette.red,
		ylw = doom_one_palette.yellow,
		grn = doom_one_palette.green,
		cya = doom_one_palette.cyan,
		blu = doom_one_palette.blue,
		tea = doom_one_palette.teal,
		mag = doom_one_palette.magenta,
		acc = doom_one_palette.violet,
	}
	return palette[name]
end

--- Set custom icons
local setup_icons = require("nvim-web-devicons").setup

setup_icons({
	override = {
		tl = { name = "Teal", icon = "", color = get_color("tea") },
		fnl = { name = "Fennel", icon = "", color = get_color("grn") },
		rockspec = { name = "Rockspec", icon = "", color = get_color("blu") },
	},
})

--- Tabline setup
local setup = require("tabline_framework").setup

local function format_filename(info)
	local name = info.buf_name
	if not info.filename then
		return "[No Name]"
	end

	local formatted_name = vim.fn.fnamemodify(name, ":~:.")
	if formatted_name:match("term:") then
		return "Terminal"
	end

	if formatted_name:len() >= 20 then
		local trunc = vim.split(formatted_name, "/")
		if #trunc <= 2 then
			return formatted_name
		end

		return ".../" .. trunc[#trunc - 1] .. "/" .. trunc[#trunc]
	end
	return formatted_name
end

local function render(f)
	f.make_bufs(function(info)
		local icon, icon_color = f.icon(info.filename) or "", f.icon_color(info.filename) or get_color("fg1")
		local color_fg = info.current and icon_color or blend_colors(icon_color, get_color("bg1"), 0.41)
		local color_bg = blend_colors(icon_color, get_color("bg1"), info.current and 0.38 or 0.2)

		f.add({
			" " .. icon .. " ",
			bg = color_bg,
			fg = color_fg,
		})
		f.add({
			format_filename(info) .. " ",
			bg = color_bg,
			fg = info.current and get_color("fg1") or color_fg,
		})
		f.add({
			string.format("%s ", info.modified and "•" or "✕"),
			bg = color_bg,
			fg = info.modified and color_fg or (info.current and get_color("red") or color_fg),
		})
	end)
	f.add_spacer()
	f.make_tabs(function(info)
		f.add(" " .. info.index .. " ")
	end)
end
setup({ render = render })

-- Fix for white colors on colorscheme change
-- HACK: find a way to update everything without calling setup again
vim.api.nvim_create_augroup("Tabline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "Tabline",
	callback = function()
		setup_icons({
			override = {
				tl = { name = "Teal", icon = "", color = get_color("tea") },
				fnl = { name = "Fennel", icon = "", color = get_color("grn") },
			},
		})
		setup({ render = render })
	end,
})
