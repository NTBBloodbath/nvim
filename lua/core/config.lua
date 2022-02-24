local _2afile_2a = "fnl/core/config.fnl"
do
  local built_ins = {"tar", "zip", "gzip", "zipPlugin", "tarPlugin", "getscript", "getscriptPlugin", "vimball", "vimballPlugin", "2html_plugin", "logipat", "rrhelper"}
  local providers = {"perl", "node", "ruby", "python", "python3"}
  for _, v in ipairs(built_ins) do
    local plugin = ("loaded_" .. v)
    do end (vim.g)[plugin] = 1
  end
  for _, v in ipairs(providers) do
    local provider = ("loaded_" .. v .. "_provider")
    do end (vim.g)[provider] = 0
  end
end
do
  vim.opt["hidden"] = true
  vim.opt["updatetime"] = 200
  vim.opt["timeoutlen"] = 500
  vim.opt["completeopt"] = {"menu", "menuone", "preview", "noinsert", "noselect"}
  vim.opt["shortmess"] = "filnxtToOFatsc"
  vim.opt["inccommand"] = "split"
  vim.opt["path"] = "**"
end
vim.opt["clipboard"] = "unnamedplus"
vim.opt["mouse"] = "a"
vim.opt["lazyredraw"] = true
do
  vim.opt["swapfile"] = false
  vim.opt["undofile"] = true
end
vim.opt["ruler"] = false
do
  vim.opt["number"] = true
  vim.opt["relativenumber"] = true
end
vim.opt["termguicolors"] = true
do
  vim.opt["signcolumn"] = "auto:2-3"
  vim.opt["foldcolumn"] = "auto:9"
  vim.opt["fillchars"] = {eob = " ", vert = "\226\150\149", fold = " ", diff = "\226\148\128", msgsep = "\226\128\190", foldsep = "\226\148\130", foldopen = "\226\150\190", foldclose = "\226\150\184"}
end
vim.opt["showmode"] = false
vim.opt["winwidth"] = 40
vim.opt["cursorline"] = true
vim.opt["wrap"] = false
vim.opt["smartcase"] = true
vim.opt["ignorecase"] = true
do
  vim.opt["copyindent"] = true
  vim.opt["smartindent"] = true
  vim.opt["preserveindent"] = true
end
do
  vim.opt["tabstop"] = 4
  vim.opt["shiftwidth"] = 4
  vim.opt["softtabstop"] = 4
end
vim.opt["expandtab"] = true
vim.opt["conceallevel"] = 2
do
  vim.opt["splitright"] = true
  vim.opt["splitbelow"] = true
end
vim.opt["scrolloff"] = 8
return nil