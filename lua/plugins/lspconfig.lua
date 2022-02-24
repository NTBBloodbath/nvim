local _2afile_2a = "fnl/plugins/lspconfig.fnl"
local _2amodule_name_2a = "plugins.lspconfig"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local autoload = (require("aniseed.autoload")).autoload
local lsp = autoload("lspconfig")
do end (_2amodule_locals_2a)["lsp"] = lsp
do
  local _let_1_ = vim.diagnostic
  local config = _let_1_["config"]
  local severity = _let_1_["severity"]
  local _let_2_ = vim.fn
  local sign_define = _let_2_["sign_define"]
  config({underline = {severity = {min = severity.INFO}}, signs = {severity = {min = severity.INFO}}, virtual_text = false, update_in_insert = true, severity_sort = true, float = {show_header = false, border = "single"}})
  sign_define("DiagnosticSignError", {text = "\239\129\151", texthl = "DiagnosticSignError"})
  sign_define("DiagnosticSignWarn", {text = "\239\129\177", texthl = "DiagnosticSignWarn"})
  sign_define("DiagnosticSignInfo", {text = "\239\129\170", texthl = "DiagnosticSignInfo"})
  sign_define("DiagnosticSignHint", {text = "\239\129\154", texthl = "DiagnosticSignHint"})
end
do
  local _let_3_ = vim.lsp
  local with = _let_3_["with"]
  local handlers = _let_3_["handlers"]
  vim.lsp.handlers["textDocument/signatureHelp"] = with(handlers.signature_help, {border = "single"})
  vim.lsp.handlers["textDocument/hover"] = with(handlers.hover, {border = "single"})
end
local function on_attach(client, bufnr)
  local _local_4_ = client.resolved_capabilities
  local has_formatting_3f = _local_4_["document_formatting"]
  local has_range_formatting_3f = _local_4_["document_range_formatting"]
  local _local_5_ = vim.lsp.buf
  local format_seq_sync_21 = _local_5_["formatting_seq_sync"]
  local open_float_doc_21 = _local_5_["hover"]
  local goto_definition_21 = _local_5_["definition"]
  local goto_declaration_21 = _local_5_["declaration"]
  local rename_21 = _local_5_["rename"]
  local goto_type_definition_21 = _local_5_["type_definition"]
  local open_float_actions_21 = _local_5_["code_action"]
  local _local_6_ = vim.diagnostic
  local open_float_diag_21 = _local_6_["open_float"]
  local goto_prev_diag_21 = _local_6_["goto_prev"]
  local goto_next_diag_21 = _local_6_["goto_next"]
  do
    local signature = require("lsp_signature")
    signature.on_attach({bind = true, fix_pos = true, floating_window_above_cur_line = true, doc_lines = 0, hint_enable = false, hint_prefix = "\226\151\143 ", hint_scheme = "DiagnossticSignInfo"}, bufnr)
  end
  vim.opt_local["omnifunc"] = "v:lua.vim.lsp.omnifunc"
  vim.keymap.set({"n"}, "K", open_float_doc_21, {buffer = true, desc = "open-float-doc!"})
  vim.keymap.set({"n"}, "<leader>a", open_float_actions_21, {buffer = true, desc = "open-float-actions!"})
  vim.keymap.set({"n"}, "<leader>r", rename_21, {buffer = true, desc = "rename!"})
  vim.keymap.set({"n"}, "<leader>d", open_float_diag_21, {buffer = true, desc = "open-float-diag!"})
  vim.keymap.set({"n"}, "<leader>[d", goto_prev_diag_21, {buffer = true, desc = "goto-prev-diag!"})
  vim.keymap.set({"n"}, "<leader>]d", goto_next_diag_21, {buffer = true, desc = "goto-next-diag!"})
  vim.keymap.set({"n"}, "<leader>gd", goto_definition_21, {buffer = true, desc = "goto-definition!"})
  vim.keymap.set({"n"}, "<leader>gD", goto_declaration_21, {buffer = true, desc = "goto-declaration!"})
  do
    vim.cmd("augroup lsp-display-diagnostics")
    vim.cmd("au! * <buffer>")
    do
      vim.cmd("au CursorHold,CursorHoldI * lua vim.diagnostic.open_float()")
    end
    vim.cmd("augroup END")
  end
  return vim.api.nvim_add_user_command("Format", vim.lsp.buf.formatting, {})
end
local capabilities
do
  local _let_7_ = vim.lsp.protocol
  local make_client_capabilities = _let_7_["make_client_capabilities"]
  local _let_8_ = require("cmp_nvim_lsp")
  local update_capabilities = _let_8_["update_capabilities"]
  capabilities = update_capabilities(make_client_capabilities())
end
local defaults = {on_attach = on_attach, capabilities = capabilities, handlers = handlers, flags = {debounce_text_changes = 150}}
lsp.clangd.setup(defaults)
lsp.rust_analyzer.setup(defaults)
do
  local lua_dev = require("lua-dev")
  local lua_dev_config = lua_dev.setup({library = {vimruntime = true, types = true, plugins = false}, lspconfig = {settings = {Lua = {workspace = {preloadFileSize = 500}}}}})
  lsp.sumneko_lua.setup(lua_dev_config)
end
return _2amodule_2a