--- editor.lua - Neovim editor plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
  --- Plenary
  { "nvim-lua/plenary.nvim" },

  --- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "css",
				"lua",
        "vim",
        "vue",
        "zig",
        "diff",
        "fish",
        "html",
        "json",
        "toml",
        "yaml",
        "regex",
        "elixir",
        "python",
        "java",
        "jsdoc",
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
        "comment",
        "gitattributes",
        "norg",
        "norg_meta",
      },
      highlight = {
        enable = true,
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
      rainbow = {
        enable = true,
        max_file_lines = 2000,
        -- strategy = {
        --   require("ts-rainbow.strategy.global"),
        --   html = require("ts-rainbow.strategy.local"),
        -- },
        hl_groups = {
          "@operator",
          "@punctuation",
          "@attribute",
          "@type",
        },
      },
      update_strategy = "lockfile",
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },
  { "HiPhish/nvim-ts-rainbow2" },
  { "windwp/nvim-ts-autotag" },

  --- Annotations
  {
    "danymat/neogen",
    keys = {
      { "mm", "<cmd>Neogen<cr>", desc = "Generate annotations" },
    },
    opts = {
      enabled = true,
      input_after_comment = true,
      jump_map = "jn",
    },
  },

  --- Scope buffers to tabs
  {
    "tiagovla/scope.nvim",
    event = { "TabEnter", "BufWinEnter" },
    config = true,
  },

  --- Pastebins
  {
    "rktjmp/paperplanes.nvim",
    cmd = "PP",
    opts = { provider = "0x0.st" },
  },

  --- Peek lines just when you intend
  {
    "nacro90/numb.nvim",
    event = "VeryLazy",
    config = true,
  },

  --- Fuzzy everywhere and every time
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<F3>", "<cmd>Telescope find_files<cr>", desc = "Find files (alt)" },
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    },
    config = function()
      local ivy = require("telescope.themes").get_ivy

      require("telescope").setup({
        defaults = ivy(),
      })
    end,
  },

  --- Discord presence, I love people to stalk what am I losing my time with
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {
      main_image = "file",
      neovim_image_text = "Break my pinky? No thanks, I'm more of breaking my editor config",
      enable_line_number = true,
    },
    config = function(_, opts)
      require("presence"):setup(opts)
    end,
  },

  --- A better terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<F4>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = {
      size = 25,
      open_mapping = [[<F4>]],
      direction = "horizontal",
    }
  },

  --- Zig development tools
  {
    "NTBBloodbath/zig-tools.nvim",
    ft = "zig",
    opts = {
      integrations = {
        package_managers = {},
        zls = {
          management = {
            enable = true,
          },
        },
      },
    }
  },
}

--- editor.lua ends here
