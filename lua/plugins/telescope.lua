local ivy = require("telescope.themes").get_ivy
local telescope = require("telescope")

telescope.setup({
  defaults = ivy(),
  extensions = {
    file_browser = {
      theme = "ivy",
      hidden = true,
      use_fd = false, -- I am already using zf by default
      hijack_netrw = false,
    },
  },
})

--- Extensions, not available in LuaRocks yet
telescope.load_extension("zf-native")
telescope.load_extension("file_browser")

--- Keybinds
vim.keymap.set("n", "<F3>", "<cmd>Telescope file_browser<cr>", { desc = "File explorer (alt)" })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", {
  desc = "File explorer",
})
