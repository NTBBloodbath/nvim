local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- Fix treesitter hardcoding Git branch to 'master'
parser_config.zig = vim.tbl_deep_extend("force", parser_config.zig, {
  install_info = { branch = "main" },
})
parser_config.diff = vim.tbl_deep_extend("force", parser_config.diff, {
  install_info = { branch = "main" },
})
parser_config.elixir = vim.tbl_deep_extend("force", parser_config.elixir, {
  install_info = { branch = "main" },
})
parser_config.http = vim.tbl_deep_extend("force", parser_config.http, {
  install_info = { branch = "next" }, -- "main"
  -- install_info = {
  --   url = "~/Develop/Nvim/tree-sitter-http",
  --   files = { "src/parser.c" },
  --   requires_generate_from_grammar = true,
  -- }
})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "css",
    "vue",
    "zig",
    "diff",
    "fish",
    "html",
    "http",
    "json",
    "toml",
    "yaml",
    "regex",
    "luadoc",
    "elixir",
    "python",
    "java",
    "jsdoc",
    "c_sharp",
    "javascript",
    "typescript",
    "comment",
    "gitattributes",
    -- "norg",
    -- "norg_meta",
  },
  highlight = {
    enable = true,
    disable = { "html" },
    use_languagetree = true,
    custom_captures = {
      ["punctuation.bracket"] = "",
      ["constructor"] = "",
    },
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
})
