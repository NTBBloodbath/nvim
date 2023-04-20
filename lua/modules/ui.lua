--- ui.lua - Neovim UI plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
  --- Colorschemes
  -- { "NTBBloodbath/doom-one.nvim", priority = 1000 },
  {
    "NTBBloodbath/sweetie.nvim",
    dev = vim.env.SWEETIE_DEV ~= nil,
    lazy = false,
  },
  { "EdenEast/nightfox.nvim", lazy = false },

  --- Automatically change colorscheme and background during day/night
  {
    "NTBBloodbath/daylight.nvim",
    cmd = "DaylightToggle",
    event = "VeryLazy",
    opts = {
      day = {
        time = 6,
        name = "dawnfox",
      },
      night = {
        time = 22, -- 10 pm
        name = "carbonfox",
      },
    },
  },

  --- Fancy icons!
  { "kyazdani42/nvim-web-devicons" },

  --- Distraction-free environment
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
  },

  --- Highlight over-length text lines
  {
    "lcheylus/overlength.nvim",
    ft = { "norg", "markdown" },
    config = function()
      require("overlength").setup()

      -- Set custom hl for OverLength
      vim.api.nvim_set_hl(0, "OverLength", { bg = "#ff6c6b", fg = "#5b6268" })
    end,
  },

  --- Color highlighter
  {
    "xiyaowong/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function() require("colorizer").setup({ "*" }, { mode = "virtualtext" }) end,
  },

  --- Automatically handle `:nohl`
  {
    "asiryk/auto-hlsearch.nvim",
    event = "VeryLazy",
    config = true,
  },

  --- Ah yeah, my neck is not going to suffer again!
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = { "NoNeckPain", "NoNeckPainResize", "NoNeckPainWidthUp", "NoNeckPainWidthDown" },
  },

  --- Tabline
  {
    "akinsho/bufferline.nvim",
    event = { "TabNew", "BufAdd" },
    opts = {
      options = {
        numbers = "buffer_id",
        diagnostics = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
  },
}

--- ui.lua ends here
