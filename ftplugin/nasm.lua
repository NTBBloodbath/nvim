-- originally from:
-- https://github.com/irock/vim-config/blob/master/vim/ftplugin/nasm.vim

-- only run if noy done yet for this buffer
if vim.b.ftplugin_nasm_loaded then
  return
end

vim.b.ftplugin_nasm_loaded = 1

-- define match groups for nasm
if vim.g.loaded_matchit then
  vim.b.match_words = "%if:%elif:%else:%endif,%macro:%endmacro"
end

-- use asmfmt to format buffer on =G if asmfmt is installed
if vim.fn.executable("asmfmt") then
  vim.b.formatprg = "asmfmt"
end
