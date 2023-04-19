--- core.lua - Neovim core plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
  --- Lua and LibUV documentation
  { "milisims/nvim-luaref", lazy = false },
  { "nanotee/luv-vimdocs", lazy = false },

  --- That way I would not forget my keybinds again
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      layout = {
        align = "center",
        spacing = 5,
      },
      -- ignore_missing = true,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.register({
        ["<leader>"] = {
          b = { name = "Buffers" },
          g = { name = "Git" },
          l = { name = "LSP" },
          ld = { name = "Diagnostics" },
          lg = { name = "Goto" },
          n = { name = "Neorg" },
          no = { name = "ToC" },
          nm = { name = "Metadata" },
          p = { name = "Plugins" },
          t = { name = "Toggle" },
          w = { name = "Windows" },
        },
      })
    end,
  },

  --- Separate cut from delete registers
  {
    "gbprod/cutlass.nvim",
    event = "VeryLazy",
    opts = { cut_key = "x" },
  },

  --- Prevent the cursor from moving when using shift and filter actions
  {
    "gbprod/stay-in-place.nvim",
    event = "VeryLazy",
    config = true,
  },

  --- Sudo in Neovim
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },

  --- Smart ESC, ESC not gonna exit terminal mode again whenever I try to close htop!
  {
    "sychen52/smart-term-esc.nvim",
    event = "TermOpen",
    opts = {
      key = "<Esc>",
      except = { "nvim", "emacs", "fzf", "zf", "htop" },
    },
  },

  --- Swiss Army Knife for Neovim
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- Trailspace (highlight and remove)
      require("mini.trailspace").setup()

      -- Automatic highlighting of word under cursor
      require("mini.cursorword").setup()

      -- Align text
      require("mini.align").setup()

      -- Buffer removing (unshow, delete, wipeout), which saves window layout
      require("mini.bufremove").setup()

      -- Autopairs
      require("mini.pairs").setup()

      -- Commenting
      require("mini.comment").setup()

      -- Surround
      require("mini.surround").setup()

      -- Visualize and operate on indent scope
      require("mini.indentscope").setup({
        symbol = "│",
      })

      -- Animations everywhere
      require("mini.animate").setup()
    end,
  },

  --- Because we all need to take notes
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    keys = {
      { "<leader>ne", ":Neorg export to-file ", desc = "Export file" },
      { "<leader>nt", "<cmd>Neorg tangle current-file<cr>", desc = "Tangle file" },
      { "<leader>np", "<cmd>Neorg presenter<cr>", desc = "Presenter" },
      { "<leader>nmi", "<cmd>Neorg inject-metadata<cr>", desc = "Inject" },
      { "<leader>nmu", "<cmd>Neorg update-metadata<cr>", desc = "Update" },
      { "<leader>nol", "<cmd>Neorg toc left<cr>", desc = "Open ToC (left)" },
      { "<leader>nor", "<cmd>Neorg toc right<cr>", desc = "Open ToC (right)" },
      { "<leader>noq", "<cmd>Neorg toc qflist<cr>", desc = "Open ToC (quickfix list)" },
    },
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {},
        ["core.concealer"] = {
          config = {
            markup_preset = "conceal",
            icons = {
              heading = {
                enabled = true,
                level_1 = { icon = "◈" },
                level_2 = { icon = " ◆" },
                level_3 = { icon = "  ◇" },
                level_4 = { icon = "   ❖" },
                level_5 = { icon = "    ⟡" },
                level_6 = { icon = "     ⋄" },
              },
            },
            dim_code_blocks = {
              conceal = false, -- do not conceal @code and @end
            },
          },
        },
        ["core.qol.toc"] = {},
        ["core.qol.todo_items"] = {},
        ["core.dirman"] = {
          config = {
            autodetect = true,
            workspaces = {
              main = "~/notes",
            },
          },
        },
        ["core.journal"] = {},
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
          },
        },
        ["core.esupports.hop"] = {},
        ["core.esupports.metagen"] = {
          config = {
            type = "empty",
          },
        },
        ["core.manoeuvre"] = {},
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = {
            extensions = "all",
          },
        },
        ["core.tangle"] = {},
      },
    },
  },
}

--- core.lua ends here
