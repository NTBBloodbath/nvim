require("bufferline").setup({
  options = {
    numbers = "buffer_id",
    diagnostics = false,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    },
  }
})
