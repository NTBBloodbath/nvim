--- lsp.lua - Language Server Protocol integration
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

-- I don't need to do anything if I'm not editing a file that I have an LSP configured for
-- NOTE: I am managing rust-analyzer through rustaceanvim but I still load my lsp module on Rust files
-- so stuff like my diagnostics configurations, LSP UI improvements and keybindings still work on them
if
  not vim
    .iter({ "c", "cpp", "zig", "rs", "ex", "exs", "nix", "lua", "js", "ts", "css", "html", "svelte" })
    :find(vim.fn.expand("%:e"))
then
  return
end

-- Diagnostics {{{
local severity = vim.diagnostic.severity
vim.diagnostic.config({
  underline = {
    severity = {
      min = severity.WARN,
    },
  },
  signs = {
    severity = {
      min = severity.WARN,
    },
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
  virtual_text = false,
  virtual_lines = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = "if_many",
    border = "rounded",
    show_header = false,
  },
})
-- }}}

-- Improve LSPs UI {{{
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded", close_events = { "CursorMoved", "BufHidden", "InsertCharPre" } }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded", close_events = { "CursorMoved", "BufHidden" } }
)

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end
-- }}}

-- Lsp capabilities {{{
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}
capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

local loaded_blink, blink = xpcall(require, debug.traceback, "blink.cmp")
if loaded_blink then
  ---@diagnostic disable-next-line undefined-field
  capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
  capabilities = capabilities,
})
-- }}}

-- Servers {{{
---@type table<string, vim.lsp.ClientConfig>
local servers = {
  -- Lua {{{
  lua_ls = {
    cmd = { "lua-language-server" },
    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
      ---@diagnostic disable-next-line undefined-field
      vim.uv.cwd(), -- equivalent of `single_file_mode` in lspconfig
    },
    filetypes = { "lua" },
    on_init = function(client)
      local path = client.workspace_folders and client.workspace_folders[1].name or "."
      ---@diagnostic disable-next-line undefined-field
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        hint = {
          enable = true,
        },
        diagnostics = {
          globals = { "_G", "vim" },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          preloadFileSize = 500,
          checkThirdParty = false,
          -- library = {
          --   vim.env.VIMRUNTIME
          -- }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          library = vim.api.nvim_get_runtime_file("", true),
        },
      })
    end,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
      },
    },
  },
  -- }}}
  -- Zig {{{
  zls = {
    cmd = { "zls" },
    root_markers = { "zls.json", "build.zig", ".git" },
    filetypes = { "zig", "zir" },
  },
  -- }}}
  -- Nix {{{
  nil_ls = {
    cmd = { "nil" },
    -- vim.uv.cwd() is the equivalent of `single_file_mode` in lspconfig
    ---@diagnostic disable-next-line undefined-field
    root_markers = { "flake.nix", ".git", vim.uv.cwd() },
    filetypes = { "nix" },
  },
  -- }}}
  -- Elixir {{{
  elixir_ls = {
    cmd = { "elixir-ls" },
    -- vim.uv.cwd() is the equivalent of `single_file_mode` in lspconfig
    ---@diagnostic disable-next-line undefined-field
    root_markers = { "mix.exs", ".git", vim.uv.cwd() },
    filetypes = { "elixir", "eelixir", "heex", "surface" },
  },
  -- }}}

  -- C/C++ {{{
  -- NOTE: the CORES environment variable is declared in my shell configuration
  clangd = {
    cmd = {
      "clangd",
      "-j=" .. vim.env.CORES,
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
    root_markers = {
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git",
      ---@diagnostic disable-next-line undefined-field
      vim.uv.cwd(), -- equivalent of `single_file_mode` in lspconfig
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  },
  -- }}}
  -- TSServer {{{
  tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    init_options = {
      hostInfo = "neovim",
    },
  },
  -- }}}
  -- EslintLS {{{
  -- NOTE: install with 'npm i -g vscode-langservers-extracted'
  eslintls = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "svelte",
      "astro",
    },
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine",
        },
        showDocumentation = {
          enable = true,
        },
      },
      codeActionOnSave = {
        enable = false,
        mode = "all",
      },
      experimental = {
        useFlatConfig = false,
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      problems = {
        shortenToSingleLine = false,
      },
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "location",
      },
    },
  },
  -- }}}
  -- CSSLS {{{
  -- NOTE: install with 'npm i -g vscode-langservers-extracted'
  cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    root_markers = { "package.json", ".git" },
    filetypes = { "css", "scss", "less" },
    init_options = {
      provideFormatter = true,
    },
  },
  -- }}}
  -- Svelte {{{
  svelteserver = {
    cmd = { "svelteserver", "--stdio" },
    root_markers = { "package.json", ".git" },
    filetypes = { "svelte" },
  },
  -- }}}
  -- TailwindCSS {{{
  -- NOTE: install with 'npm install -g @tailwindcss/language-server'
  tailwindcssls = {
    cmd = { "tailwindcss-language-server", "--stdio" },
    root_markers = {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.cjs",
      "postcss.config.mjs",
      "postcss.config.ts",
      "package.json",
      "node_modules",
      ".git",
    },
    filetypes = {
      "aspnetcorerazor",
      "astro",
      "astro-markdown",
      "blade",
      "clojure",
      "django-html",
      "htmldjango",
      "edge",
      "eelixir",
      "elixir",
      "ejs",
      "erb",
      "eruby",
      "gohtml",
      "gohtmltmpl",
      "haml",
      "handlebars",
      "hbs",
      "html",
      "htmlangular",
      "html-eex",
      "heex",
      "jade",
      "leaf",
      "liquid",
      "markdown",
      "mdx",
      "mustache",
      "njk",
      "nunjucks",
      "php",
      "razor",
      "slim",
      "twig",
      "css",
      "less",
      "postcss",
      "sass",
      "scss",
      "stylus",
      "sugarss",
      "javascript",
      "javascriptreact",
      "reason",
      "rescript",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "templ",
    },
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
        includeLanguages = {
          eelixir = "html-eex",
          eruby = "erb",
          htmlangular = "html",
          templ = "html",
        },
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning",
        },
        validate = true,
      },
    },
  },
  -- }}}
  -- HTML {{{
  -- NOTE: installed with 'npm i -g vscode-langservers-extracted'
  htmlls = {
    name = "html",
    cmd = { "vscode-html-language-server", "--stdio" },
    root_markers = { "package.json", ".git" },
    filetypes = { "html", "templ" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = true,
    },
  },
  -- }}}
}

local server_names = vim.tbl_keys(servers)
-- Iterate over all the server names and add them to the `vim.lsp.config` table.
-- I'm way too lazy to refactor the whole servers table and that way it also lets
-- me to enable them all at once later.
for _, server_name in ipairs(server_names) do
  vim.lsp.config[server_name] = servers[server_name]
end

vim.lsp.enable(server_names)
-- }}}

-- Disable default keybinds {{{
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
  vim.keymap.del("n", bind)
end
-- }}}

-- Create keybindings, commands and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    --- Set omnifunc completion and use LSP for finding tags whenever possible
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    --- Disable semantic tokens
    ---@diagnostic disable-next-line need-check-nil
    client.server_capabilities.semanticTokensProvider = nil

    --- Keybindings
    local kbd = vim.keymap.set
    -- Show documentation
    kbd("n", "<leader>lh", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
    -- Open code actions
    kbd("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
    -- Rename symbol under cursor
    kbd("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
    -- Show line diagnostics
    kbd("n", "<leader>ldl", function()
      vim.diagnostic.open_float({
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "if_many",
        prefix = " ",
        scope = "cursor",
      })
    end, { buffer = bufnr, desc = "Show line diagnostics" })
    -- Go to diagnostics
    kbd(
      "n",
      "<leader>ldp",
      vim.diagnostic.goto_prev,
      { buffer = bufnr, desc = "Goto next diagnostic" }
    )
    kbd(
      "n",
      "<leader>ldn",
      vim.diagnostic.goto_next,
      { buffer = bufnr, desc = "Goto prev diagnostic" }
    )
    -- Go to definition
    kbd("n", "<leader>lgd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto definition" })
    -- Go to declaration
    kbd("n", "<leader>lgD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto declaration" })

    --- Autocommands
    vim.api.nvim_create_augroup("Lsp", { clear = true })
    -- Display line diagnostics on hover
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   group = "Lsp",
    --   buffer = bufnr,
    --   callback = function()
    --     local opts = {
    --       focusable = false,
    --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --       border = "rounded",
    --       source = "always",
    --       prefix = " ",
    --       scope = "line",
    --     }
    --     vim.diagnostic.open_float(opts)
    --   end,
    -- })
    -- Fix all eslint offenses on save in JavaScript/TypeScript files
    ---@diagnostic disable-next-line need-check-nil
    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "Lsp",
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end

    --- Commands
    -- Format
    vim.api.nvim_create_user_command(
      "LspFormat",
      vim.lsp.buf.format,
      { desc = "Format current buffer using LSP" }
    )
  end,
})
-- }}}

-- Global commands (start, stop, restart, etc) {{{
-- rust-analyzer is handled by rustaceanvim so we save some time ignoring it
if vim.fn.expand("%:e") ~= "rs" then
  -- Start {{{
  vim.api.nvim_create_user_command("LspStart", function()
    vim.cmd.e()
  end, { desc = "Starts LSP clients in the current buffer" })
  -- }}}

  -- Stop {{{
  vim.api.nvim_create_user_command("LspStop", function(opts)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
      if opts.args == "" or opts.args == client.name then
        client:stop(true)
        vim.notify("[core.lsp] " .. client.name .. ": stopped")
      end
    end
  end, {
    desc = "Stop all the LSP clients or a specific client attached to the current buffer.",
    nargs = "?",
    complete = function(_, _, _)
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      return client_names
    end,
  })
  -- }}}

  -- Restart {{{
  vim.api.nvim_create_user_command("LspRestart", function()
    local detach_clients = {}
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
      client:stop(true)
      if vim.tbl_count(client.attached_buffers) > 0 then
        detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
      end
    end
    local timer = vim.uv.new_timer()
    timer:start(
      100,
      50,
      vim.schedule_wrap(function()
        for name, client in pairs(detach_clients) do
          local client_id = vim.lsp.start(client[1].config, { attach = false })
          if client_id then
            for _, buf in ipairs(client[2]) do
              vim.lsp.buf_attach_client(buf, client_id)
            end
            vim.notify("[core.lsp] " .. name .. ": restarted")
          end
          detach_clients[name] = nil
        end
        if next(detach_clients) == nil and not timer:is_closing() then
          timer:close()
        end
      end)
    )
  end, {
    desc = "Restart all the LSP clients attached to the current buffer",
  })
  -- }}}

  -- Log {{{
  vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
  end, { desc = "Get all the LSP logs" })
  -- }}}

  -- Info {{{
  vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
  end, { desc = "Get all the information about all LSP attached" })
  -- }}}
end
-- }}}

-- vim: fdm=marker:fdl=0
--- lsp.lua ends here
