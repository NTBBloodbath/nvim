local ok, lspconfig = pcall(require, "lspconfig")

if not ok then return end

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
    source = "always",
    border = "rounded",
    show_header = false,
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

  -- Enable omnifunc-completion
  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

  --- Keybindings
  local kbd = vim.keymap.set
  -- Show documentation
  kbd("n", "<leader>lh", vim.lsp.buf.hover, { buffer = true, desc = "Hover documentation" })
  -- Open code actions
  kbd("n", "<leader>la", vim.lsp.buf.code_action, { buffer = true, desc = "Code actions" })
  -- Rename symbol under cursor
  kbd("n", "<leader>lr", vim.lsp.buf.rename, { buffer = true, desc = "Rename" })
  -- Show line diagnostics
  kbd(
  "n",
  "<leader>ldl",
  function()
    vim.diagnostic.open_float({
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    })
  end,
  { buffer = true, desc = "Show line diagnostics" }
  )
  -- Go to diagnostics
  kbd(
  "n",
  "<leader>ldp",
  vim.diagnostic.goto_prev,
  { buffer = true, desc = "Goto next diagnostic" }
  )
  kbd(
  "n",
  "<leader>ldn",
  vim.diagnostic.goto_next,
  { buffer = true, desc = "Goto prev diagnostic" }
  )
  -- Go to definition
  kbd("n", "<leader>lgd", vim.lsp.buf.definition, { buffer = true, desc = "Goto definition" })
  -- Go to declaration
  kbd(
  "n",
  "<leader>lgD",
  vim.lsp.buf.declaration,
  { buffer = true, desc = "Goto declaration" }
  )

  --- Autocommands
  vim.api.nvim_create_augroup("Lsp", { clear = true })
  -- Display line diagnostics on hover
  vim.api.nvim_create_autocmd("CursorHold", {
    group = "Lsp",
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "line",
      }
      vim.diagnostic.open_float(opts)
    end,
  })
  --- Commands
  vim.api.nvim_create_user_command(
  "Format",
  vim.lsp.buf.format,
  { desc = "Format current buffer using LSP" }
  )
end

--- Capabilities
local capabilities =
require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- Setup servers
local defaults = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
}

-- C/C++
if vim.fn.executable("clangd") == 1 then
  local clangd_defaults = require("lspconfig.server_configurations.clangd")
  local clangd_configs =
  vim.tbl_deep_extend("force", clangd_defaults.default_config, defaults, {
    cmd = {
      "clangd",
      "-j=4",
      "--background-index",
      "--clang-tidy",
      "--inlay-hints",
      "--fallback-style=llvm",
      "--all-scopes-completion",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--header-insertion-decorators",
      "--pch-storage=memory",
    },
  })
  -- require("clangd_extensions").setup({ server = clangd_configs })
end

-- Java
if vim.fn.executable("jdtls") == 1 then lsp.jdtls.setup(defaults) end

-- Zig
if vim.fn.executable("zls") == 1 then lsp.zls.setup(defaults) end

-- JavaScript/TypeScript
if vim.fn.executable("tsserver") == 1 then
  local settings = {
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    }
  }
  settings = vim.tbl_deep_extend("force", defaults, settings)
  lsp.tsserver.setup(settings)
end

-- Vue
-- Installation: npm i -g @volar/vue-language-server
if vim.fn.executable("vue-language-server") == 1 then lsp.volar.setup(defaults) end

-- ESLint, linting engine for JavaScript/TypeScript
-- Installation: npm i -g vscode-langservers-extracted
if vim.fn.executable("vscode-eslint-language-server") == 1 then lsp.eslint.setup(defaults) end

-- CSS
-- Installation: npm i -g vscode-langservers-extracted
if vim.fn.executable("vscode-css-language-server") == 1 then lsp.cssls.setup(defaults) end

-- TailwindCSS
-- Installation: npm i -g @tailwindcss/language-server
if vim.fn.executable("tailwindcss-language-server") == 1 then
  lsp.tailwindcss.setup(defaults)
end

-- HTML
-- Installation: npm i -g vscode-langservers-extracted
if vim.fn.executable("vscode-html-language-server") == 1 then lsp.html.setup(defaults) end

-- Lua
if vim.fn.executable("lua-language-server") == 1 then
  --[[ require("neodev").setup({
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
  }) --]]
  local lua_config = {
    cmd = {
      "lua-language-server",
      "-E",
      vim.env.HOME .. "/Develop/Nvim/lua-language-server/main.lua",
    },
    settings = {
      Lua = {
        hint = {
          enable = true,
        },
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
  -- I am installing lua LS through brew instead of manually compiling it like on my Linux machines.
  -- However, sometimes I use package managers to install lua lsp on my Linux machines so we gotta double check it
  if jit.os == "OSX" or vim.fn.executable("/usr/bin/lua-language-server") == 1 then
    lua_config.cmd = { "lua-language-server" }
  end

  lsp.lua_ls.setup(vim.tbl_deep_extend("force", defaults, lua_config))
end

-- Elixir
if vim.fn.executable("elixir-ls") == 1 then
  lsp.elixirls.setup(
  vim.tbl_deep_extend(
  "force",
  defaults,
  { cmd = { vim.env.HOME .. "/.local/bin/elixir-ls" } }
  )
  )
end

-- Ruby
if vim.fn.executable("ruby-lsp") == 1 then lsp.ruby_ls.setup(defaults) end

-- Python
if vim.fn.executable("jedi-language-server") == 1 then
  lsp.jedi_language_server.setup(defaults)
end

-- Dart & Flutter
if vim.fn.executable("dart") == 1 then lsp.dartls.setup(defaults) end
