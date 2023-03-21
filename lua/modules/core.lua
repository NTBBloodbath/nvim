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
        spacing = 6,
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.register({
        ["<leader>"] = {
          b = { name = "Buffers" },
          d = { name = "Diagnostics" },
          g = { name = "Git" },
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
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {},
        ["core.norg.concealer"] = {
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
        ["core.norg.qol.toc"] = {},
        ["core.norg.qol.todo_items"] = {},
        ["core.norg.dirman"] = {
          config = {
            autodetect = true,
            workspaces = {
              main = "~/notes",
            },
          },
        },
        ["core.norg.journal"] = {},
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
          },
        },
        ["core.norg.esupports.hop"] = {},
        ["core.norg.esupports.metagen"] = {
          config = {
            type = "empty",
          },
        },
        ["core.norg.manoeuvre"] = {},
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
