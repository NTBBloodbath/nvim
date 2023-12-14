local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- Fix treesitter hardcoding Git branch to 'master'
parser_config.zig = vim.tbl_deep_extend("force", parser_config.zig, {
  install_info = { branch = "main" },
})
parser_config.diff = vim.tbl_deep_extend("force", parser_config.diff, {
  install_info = { branch = "main" },
})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "css",
    "vue",
    "zig",
    "diff",
    "fish",
    "html",
    "json",
    "toml",
    "yaml",
    "ruby",
    "regex",
    "luadoc",
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
  playground = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})
