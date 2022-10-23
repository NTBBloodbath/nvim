local lsp = require("lspconfig")
local navic = require("nvim-navic")
-- local semantic_tokens = require("nvim-semantic-tokens")

--- Setup semantic tokens
-- semantic_tokens.setup({
-- 	preset = "default",
-- 	highlighters = {
-- 		require("nvim-semantic-tokens.table-highlighter"),
-- 	},
-- })

--- Diagnostics configuration
local severity = vim.diagnostic.severity
vim.diagnostic.config({
	underline = {
		severity = {
			min = severity.ERROR,
		},
	},
	signs = {
		severity = {
			min = severity.ERROR,
		},
	},
	virtual_text = false,
	update_in_insert = true,
	severity_sort = true,
	float = {
		show_header = false,
		border = "rounded",
	},
})

--- Improve UI
local sign_define = vim.fn.sign_define
sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{ border = "rounded", close_events = { "CursorMoved", "BufHidden", "InsertCharPre" } }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{ border = "rounded", close_events = { "CursorMoved", "BufHidden" } }
)

--- On attach
local function on_attach(client, bufnr)
	local capabilities = client.server_capabilities
	local formatting = {
		available = capabilities.document_formatting,
		range = capabilities.document_range_formatting,
	}

	--- Signature
	require("lsp_signature").on_attach({
		bind = true,
		fix_pos = true,
		floating_window_above_cur_line = true,
		doc_lines = 0,
		hint_enable = true,
		hint_prefix = "● ",
		hint_scheme = "DiagnosticSignInfo",
	}, bufnr)

	-- Semantic tokens
	-- if capabilities.semanticTokensProvider and capabilities.semanticTokensProvider.full then
	-- 	local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
	-- 	vim.api.nvim_create_autocmd("TextChanged", {
	-- 		group = augroup,
	-- 		buffer = bufnr,
	-- 		callback = function()
	-- 			vim.lsp.buf.semantic_tokens_full()
	-- 		end,
	-- 	})
	-- 	-- fire it first time on load as well
	-- 	vim.lsp.buf.semantic_tokens_full()
	-- end

	-- Set up navic
	if capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	-- Enable omnifunc-completion
	vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

	--- Keybindings
	local kbd = vim.keymap.set
	-- Show documentation
	kbd("n", "<leader>h", vim.lsp.buf.hover, { buffer = true })
	-- Open code actions
	kbd("n", "<leader>a", vim.lsp.buf.code_action, { buffer = true })
	-- Rename symbol under cursor
	kbd("n", "<leader>r", vim.lsp.buf.rename, { buffer = true })
	-- Show line diagnostics
	kbd("n", "<leader>l", function()
		vim.diagnostic.open_float({ focus = false })
	end, { buffer = true })
	-- Go to diagnostics
	kbd("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = true })
	kbd("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = true })
	-- Go to definition
	kbd("n", "<leader>gd", vim.lsp.buf.definition, { buffer = true })
	-- Go to declaration
	kbd("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = true })

	--- Autocommands
	vim.api.nvim_create_augroup("Lsp", { clear = true })
	-- Display line diagnostics on hover
	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = "Lsp",
		buffer = bufnr,
		callback = function()
			vim.diagnostic.open_float({ focus = false })
		end,
	})

	--- Commands
	vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, { desc = "Format current buffer using LSP" })
end

--- Capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
	dynamicRegistration = true,
	lineFoldingOnly = true,
}

--- Setup servers
local defaults = {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = { debounce_text_changes = 150 },
}

-- C/C++
if vim.fn.executable("clangd") == 1 then
	local clangd_defaults = require("lspconfig.server_configurations.clangd")
	local clangd_configs = vim.tbl_deep_extend("force", clangd_defaults.default_config, defaults, {
		cmd = {
			"-j=4",
			"--background-index",
			"--clang-tidy",
			"--fallback-style=llvm",
			"--all-scopes-completion",
			"--completion-style=detailed",
			"--header-insertion=iwyu",
			"--header-insertion-decorators",
			"--pch-storage=memory",
		},
	})
	require("clangd_extensions").setup({ server = clangd_configs })
end

-- Zig
if vim.fn.executable("zls") == 1 then
	lsp.zls.setup(defaults)
end

-- JavaScript/TypeScript
if vim.fn.executable("tsserver") == 1 then
	lsp.tsserver.setup(defaults)
end

-- Lua
if vim.fn.executable("lua-language-server") == 1 then
	require("neodev").setup({
		library = {
			enabled = true,
			runtime = true,
			types = true,
			plugins = true,
		},
	})
	local lua_config = {
		cmd = { "lua-language-server", "-E", vim.env.HOME .. "/Development/Nvim/lua-language-server/main.lua" },
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "_G", "vim" },
				},
				workspace = {
					preloadFileSize = 500,
				},
			},
		},
	}
	lsp.sumneko_lua.setup(vim.tbl_deep_extend("force", defaults, lua_config))
end

-- Teal
if vim.fn.executable("teal-language-server") == 1 then
	lsp.teal_ls.setup(defaults)
end

-- Elixir
if vim.fn.executable("elixir-ls") == 1 then
	lsp.elixirls.setup(vim.tbl_deep_extend("force", defaults, { cmd = { vim.env.HOME .. "/.local/bin/elixir-ls" } }))
end

-- Python
if vim.fn.executable("jedi-language-server") == 1 then
	lsp.jedi_language_server.setup(defaults)
end

-- Attach nvim-ufo folds to language servers
require("ufo").setup()
