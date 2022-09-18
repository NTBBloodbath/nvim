require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.keybinds"] = {},
		["core.norg.concealer"] = {
			config = {
				markup_preset = "conceal",
				icons = {
					heading = {
						enabled = true,
						level_1 = { icon = "◈" },
						level_2 = { icon = " ◆" },
						level_3 = { icon = "  ◇" },
						level_4 = { icon = "   ❖" },
						level_5 = { icon = "    ⟡" },
						level_6 = { icon = "     ⋄" },
					},
				},
			},
		},
		["core.norg.qol.toc"] = {},
		["core.norg.qol.todo_items"] = {},
		["core.norg.dirman"] = {
			config = {
				autodetect = true,
				workspaces = {
					main = "~/notes",
				},
			},
		},
		["core.norg.journal"] = {},
		["core.presenter"] = {
			config = {
				zen_mode = "zen-mode",
			},
		},
		["core.norg.esupports.hop"] = {},
		["core.norg.esupports.metagen"] = {
			config = {
				type = "empty",
			},
		},
		["core.norg.manoeuvre"] = {},
		["core.export"] = {},
		["core.export.markdown"] = {
			config = {
				extensions = "all",
			},
		},
		["core.tangle"] = {},
	},
})
