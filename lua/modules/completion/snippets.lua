local luasnip = require("luasnip")
local loader = require("luasnip.loaders.from_vscode")

luasnip.config.setup({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

--- Load snippets
loader.load()
