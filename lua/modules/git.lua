--- git.lua - Neovim Git plugins
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

return {
  --- Signs for Git diff
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
      { "gr", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset changes in buffer" },
      { "gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview changes in buffer" },
    },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
  },

  --- More than 3 years using Git and conflicts still confuses my brain
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = true,
  },

  --- Magit? No, Neogit!
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    keys = {
      { "<F2>", "<cmd>Neogit<cr>", desc = "Open Neogit" },
      { "<leader>gs", "<cmd>Neogit<cr>", desc = "Open Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Commit changes" },
      { "<leader>gl", desc = "Pull changes" },
      { "<leader>gp", desc = "Push changes" },
    },
    opts = {
      use_magit_keybindings = true,
      disable_commit_confirmation = true,
      kind = "vsplit",
      commit_popup = {
        kind = "split",
      },
      signs = {
        section = { "▸", "▾" },
        item = { "▸", "▾" },
        hunk = { "樂", "" },
      },
    },
    config = function(_, opts)
      local neogit = require("neogit")
      local popups = neogit.popups

      neogit.setup(opts)
      vim.keymap.set("n", "<F2>", "<cmd>Neogit<cr>")
      vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>")
      vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>")
      vim.keymap.set("n", "<leader>gl", popups.pull.create)
      vim.keymap.set("n", "<leader>gp", popups.push.create)
    end,
  },
}

--- git.lua ends here
