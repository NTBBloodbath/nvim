vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.textwidth = 100

vim.opt.lisp = true
vim.opt.lispwords = vim.tbl_extend("force", vim.opt.lispwords:get(), {
  "def",
  "var",
  "defn",
  "defn-",
  "varfn",
  "varfn-",
  "defmacro",
  "defmacro-",
  "do",
  "if",
  "fn",
  "break",
  "quote",
  "while",
  "splice",
  "unquote",
  "quasiquote",
  "upscope",
  "let",
  "let*",
})
