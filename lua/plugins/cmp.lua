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
local _local_4_ = _local_2_["ItemField"]
local kind = _local_4_["Kind"]
local abbr = _local_4_["Abbr"]
local menu = _local_4_["Menu"]
local _local_5_ = _local_2_["SelectBehavior"]
local insert_behavior = _local_5_["Insert"]
local select_behavior = _local_5_["Select"]
local event = _local_2_["event"]
local types = require("cmp.types")
local under_compare = require("cmp-under-comparator")
local _local_6_ = require("lspkind")
local cmp_format = _local_6_["cmp_format"]
local _local_7_ = require("luasnip")
local lsp_expand = _local_7_["lsp_expand"]
local expand_or_jump = _local_7_["expand_or_jump"]
local expand_or_jumpable = _local_7_["expand_or_jumpable"]
local jump = _local_7_["jump"]
local jumpable = _local_7_["jumpable"]
local function has_words_before()
  local col = (vim.fn.col(".") - 1)
  local ln = vim.fn.getline(".")
  if ((col == 0) or string.match(string.sub(ln, col, col), "%s")) then
    return true
  else
    return false
  end
end
local function _9_(args)
  return lsp_expand(args.body)
end
local function _10_(fallback)
  if visible() then
    return mapping.select_next_item({behavior = insert_behavior})
  elseif expand_or_jumpable() then
    return expand_or_jump()
  else
    return fallback()
  end
end
local function _12_(fallback)
  if visible() then
    return mapping.select_prev_item({behavior = insert_behavior})
  elseif jumpable(-1) then
    return jump(-1)
  else
    return fallback()
  end
end
setup({preselect = types.cmp.PreselectMode.None, completion = {border = {"\226\149\173", "\226\148\128", "\226\149\174", "\226\148\130", "\226\149\175", "\226\148\128", "\226\149\176", "\226\148\130"}, scrollbar = "\226\149\145"}, window = {documentation = {border = "rounded", scrollbar = "\226\149\145"}, completion = {border = "rounded", scrollbar = "\226\149\145"}}, snippet = {expand = _9_}, mapping = {["<C-b>"] = mapping.scroll_docs(-4), ["<C-f>"] = mapping.scroll_docs(4), ["<C-Space>"] = mapping.complete(), ["<C-e>"] = mapping.abort(), ["<Tab>"] = mapping(_10_, {"i", "s", "c"}), ["<S-Tab>"] = mapping(_12_, {"i", "s", "c"}), ["<Space>"] = mapping.confirm({select = false})}, sources = {{name = "nvim_lsp"}, {name = "luasnip"}, {name = "path"}, {name = "buffer"}}, sorting = {comparators = {compare.offset, compare.exact, compare.score, under_compare.under, compare.kind, compare.sort_text, compare.length, compare.order}}, formatting = {fields = {kind, abbr, menu}, format = cmp_format({with_text = false})}, experimental = {ghost_text = true}})
setup.cmdline("/", {view = {entries = "wildmenu", separator = "|"}, sources = {{name = "buffer"}}})
setup.cmdline(":", {view = {entries = "wildmenu", separator = "|"}, sources = {{name = "path"}, {name = "cmdline"}}})
return _2amodule_2a