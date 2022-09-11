if vim.fn.exists("b:did_ftplugin") == 0 then
  vim.b.did_ftplugin = 1

  vim.opt_local.iskeyword = "!,$,%,#,*,+,-,.,/,:,<,=,>,?,_,a-z,A-Z,48-57,128-247,124,126,38,94"

  -- There will be false positives, but this is better than missing the whole set
  -- of user-defined def* definitions.
  vim.opt_local.define = "\\v[(/]def(ault)@!\\S*"

  vim.opt_local.suffixesadd = ".fnl"

  -- Remove 't' from 'formatoptions' to avoid auto-wrapping code.
  vim.opt_local.formatoptions:remove("t")

  vim.opt_local.comments = "n:;"
  vim.opt_local.commentstring = "; %s"
end
