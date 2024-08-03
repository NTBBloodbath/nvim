require("rest-nvim").setup({
  client = "curl",
  env_file = ".env",
  env_pattern = "\\.env$",
  env_edit_command = "tabedit",
  encode_url = true,
  skip_ssl_verification = false,
  custom_dynamic_variables = {},
  logs = {
    level = "info",
    save = true,
  },
  highlight = {
    enable = true,
    timeout = 750,
  },
  result = {
    split = {
      in_place = false,
      horizontal = false,
      stay_in_current_window_after_split = true,
    },
    behavior = {
      decode_url = true,
      show_info = {
        url = true,
        headers = true,
        http_info = true,
        curl_command = true,
      },
      formatters = {
        json = "jq",
        html = function(body)
          if vim.fn.executable("tidy") == 0 then
            return body, { found = false, name = "tidy" }
          end
          local fmt_body = vim.fn
            .system({
              "tidy",
              "-i",
              "-q",
              "--tidy-mark",
              "no",
              "--show-body-only",
              "auto",
              "--show-errors",
              "0",
              "--show-warnings",
              "0",
              "-",
            }, body)
            :gsub("\n$", "")

          return fmt_body, { found = true, name = "tidy" }
        end,
      },
    },
  },
  keybinds = {
    { "<localleader>rr", "<cmd>Rest run<cr>", "Run request under the cursor" },
    { "<localleader>rl", "<cmd>Rest run last<cr>", "Re-run latest request" },
  },
})
