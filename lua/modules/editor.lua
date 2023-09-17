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
    dependencies = {
      { "windwp/nvim-ts-autotag" },
    },
    opts = {
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
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
        "comment",
        "gitcommit",
        "gitignore",
        "gitattributes",
        "norg",
        -- "norg_meta",
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
      update_strategy = "lockfile",
    },
    config = function(_, opts)
      -- Termux nightly version does not ship bundled parsers
      if vim.env.TERMUX_VERSION or jit.os == "OSX" then
        opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed, {
          "c",
          "lua",
          "vim",
          "vimdoc",
        })
      end

      local parsers = require("nvim-treesitter.parsers").list
      parsers.janet = {
        install_info = {
          url = "https://github.com/GrayJack/tree-sitter-janet",
          files = { "src/parser.c", "src/scanner.c" },
        },
        filetype = "janet",
      }

      parsers.erde = {
        install_info = {
          url = vim.env.HOME .. "/Development/Nvim/tree-sitter-erde",
          files = { "src/parser.c", "src/scanner.cc" },
        },
        filetype = "erde",
      }

      opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed, { "erde", "janet" })

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  },

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

  {
    "jbyuki/venn.nvim",
    cmd = "VBox",
    keys = {
      { "J", "<C-v>j:VBox<CR>" },
      { "K", "<C-v>k:VBox<CR>" },
      { "L", "<C-v>l:VBox<CR>" },
      { "H", "<C-v>h:VBox<CR>" },
    },
  },

  --- Better quickfix
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = true,
  },

  --- Fuzzy everywhere and every time
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = {
      { "<F3>", "<cmd>Telescope file_browser<cr>", desc = "File explorer (alt)" },
      {
        "<leader>f",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "File explorer",
      },
    },
    dependencies = {
      { "natecraddock/telescope-zf-native.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = function()
      local ivy = require("telescope.themes").get_ivy
      local telescope = require("telescope")

      telescope.setup({
        defaults = ivy(),
        extensions = {
          file_browser = {
            theme = "ivy",
            hidden = true,
            use_fd = false, -- I am already using zf by default
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
          },
        },
      })
      telescope.load_extension("zf-native")
      telescope.load_extension("file_browser")
    end,
  },

  --- Discord presence, I love people to stalk what am I losing my time with
  {
    "andweeb/presence.nvim",
    cond = vim.env.TERMUX_VERSION == nil, -- do not load on Termux as it is useless
    event = "VeryLazy",
    opts = {
      main_image = "file",
      neovim_image_text = "Break my pinky? No thanks, I'm more of breaking my editor config",
      enable_line_number = true,
    },
    config = function(_, opts) require("presence"):setup(opts) end,
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
    },
  },

  --- Erde language support
  {
    "erde-lang/vim-erde",
    lazy = false,
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
    },
  },

  --- MongoDB integration
  {
    "jrop/mongo.nvim",
    enabled = vim.fn.executable("mongosh") == 1,
    cmd = {
      "Mongoconnect",
      "Mongocollections",
      "Mongoquery",
      "Mongoexecute",
      "Mongoedit",
      "Mongorefresh",
    },
  },

  --- HTTP client
  {
    "NTBBloodbath/rest.nvim",
    ft = "http",
    config = true,
  },
}

--- editor.lua ends here
