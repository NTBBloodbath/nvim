require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.keybinds"] = {},
    ["core.concealer"] = {
      config = {
        icons = {
          heading = {
            icons = { "◈", "◆", "◇", "❖", "⟡", "⋄" },
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
    ["core.export"] = {},
    ["core.export.markdown"] = {
      config = {
        extensions = "all",
      },
    },
    ["core.tangle"] = {},
    ["core.tempus"] = {},
    ["core.clipboard"] = {},
    ["core.clipboard.code-blocks"] = {},
    ["core.ui.calendar"] = {},
    -- ["core.integrations.image"] = {},
    ["external.conceal-wrap"] = {},
  },
})

--- Keybindings
vim.keymap.set("n", "<leader>ne", ":Neorg export to-file ", { desc = "Export file" })
vim.keymap.set("n", "<leader>nt", "<cmd>Neorg tangle current-file<cr>", { desc = "Tangle file" })
vim.keymap.set("n", "<leader>np", "<cmd>Neorg presenter<cr>", { desc = "Presenter" })
vim.keymap.set("n", "<leader>nmi", "<cmd>Neorg inject-metadata<cr>", { desc = "Inject" })
vim.keymap.set("n", "<leader>nmu", "<cmd>Neorg update-metadata<cr>", { desc = "Update" })
vim.keymap.set("n", "<leader>nol", "<cmd>Neorg toc left<cr>", { desc = "Open ToC (left)" })
vim.keymap.set("n", "<leader>nor", "<cmd>Neorg toc right<cr>", { desc = "Open ToC (right)" })
vim.keymap.set(
  "n",
  "<leader>noq",
  "<cmd>Neorg toc qflist<cr>",
  { desc = "Open ToC (quickfix list)" }
)
