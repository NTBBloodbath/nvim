local _2afile_2a = "fnl/plugins/cmp.fnl"
local _2amodule_name_2a = "plugins.cmp"
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
local _local_1_ = table
local insert = _local_1_["insert"]
local _local_2_ = require("cmp")
local setup = _local_2_["setup"]
local mapping = _local_2_["mapping"]
local visible = _local_2_["visible"]
local complete = _local_2_["complete"]
local _local_3_ = _local_2_["config"]
local compare = _local_3_["compare"]
local disable = _local_3_["disable"]
local _local_4_ = _local_2_["SelectBehavior"]
local insert_behavior = _local_4_["Insert"]
local select_behavior = _local_4_["Select"]
local event = _local_2_["event"]
local types = require("cmp.types")
local under_compare = require("cmp-under-comparator")
local _local_5_ = require("luasnip")
local lsp_expand = _local_5_["lsp_expand"]
local expand_or_jump = _local_5_["expand_or_jump"]
local expand_or_jumpable = _local_5_["expand_or_jumpable"]
local jump = _local_5_["jump"]
local jumpable = _local_5_["jumpable"]
local function has_words_before()
  local col = (vim.fn.col(".") - 1)
  local ln = vim.fn.getline(".")
  if ((col == 0) or string.match(string.sub(ln, col, col), "%s")) then
    return true
  else
    return false
  end
end
local function _7_(args)
  return lsp_expand(args.body)
end
local function _8_(fallback)
  if visible() then
    return mapping.select_next_item({behavior = insert_behavior})
  elseif expand_or_jumpable() then
    return expand_or_jump()
  else
    return fallback()
  end
end
local function _10_(fallback)
  if visible() then
    return mapping.select_prev_item({behavior = insert_behavior})
  elseif jumpable(-1) then
    return jump(-1)
  else
    return fallback()
  end
end
local function _12_(entry, vim_item)
  vim_item.dup = ({buffer = 1, path = 1, nvim_lsp = 0})[entry.source.name]
  vim_item.menu = ({nvim_lsp = "[Lsp]", path = "[Pth]", buffer = "[Buf]", luasnip = "[Snp]", treesitter = "[TS]"})[entry.source.name]
  vim_item.kind = ({Text = "\239\146\158 ", Method = "\239\154\166 ", Function = "\239\158\148 ", Constructor = "\239\144\163 ", Field = "\239\176\160 ", Variable = "\238\156\150 ", Class = "\239\160\150 ", Interface = "\239\131\168 ", Module = "\239\153\168 ", Property = "\239\176\160 ", Unit = "\229\161\158", Value = "\239\162\159 ", Enum = "\239\169\151", Keyword = "\239\160\138 ", Snippet = "\239\145\143 ", Color = "\239\163\151 ", File = "\239\156\147 ", Reference = "\239\156\156 ", Folder = "\239\157\138 ", EnumMember = "\239\133\157 ", Constant = "\239\178\128 ", Struct = "\239\179\164 ", Event = "\239\131\167 ", Operator = "\239\154\148 ", TypeParameter = "\239\158\131 "})[vim_item.kind]
  return vim_item
end
setup({preselect = types.cmp.PreselectMode.None, view = {entries = "custom"}, snippet = {expand = _7_}, mapping = {["<C-b>"] = mapping.scroll_docs(-4), ["<C-f>"] = mapping.scroll_docs(4), ["<C-Space>"] = mapping.complete(), ["<C-e>"] = mapping.abort(), ["<Tab>"] = mapping(_8_, {"i", "s"}), ["<S-Tab>"] = mapping(_10_, {"i", "s"}), ["<Space>"] = mapping.confirm({select = false})}, sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "path"}, {name = "buffer"}}, sorting = {comparators = {compare.offset, compare.exact, compare.score, under_compare.under, compare.kind, compare.sort_text, compare.length, compare.order}}, formatting = {format = _12_}})
setup.cmdline("/", {view = {name = "wildmenu", separator = "|"}, sources = {name = "buffer"}})
setup.cmdline(":", {view = {name = "wildmenu", separator = "|"}, sources = {name = "cmdline"}})
return _2amodule_2a