;; use opt-in filetype.lua instead of vimscript default in Neovim nightly
;; EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
(when (= (vim.fn.has :nvim-0.7.0) 1)
  (tset vim.g :did_load_filetypes 1)
  (tset vim.g :do_filetype_lua 1))

;; Temporarily disable syntax and filetype to improve startup time
(vim.cmd "syntax off")
(vim.cmd "filetype off")
(vim.cmd "filetype plugin indent off")

(fn installed! [plugin-name]
  "Check if a plugin is installed or not"
  (= 0 (vim.fn.empty (vim.fn.glob (string.format "%s/packer/opt/%s"
                                                 (.. (vim.fn.stdpath :data)
                                                     :/site/pack)
                                                 plugin-name)))))

;; Defer plugins loading
(vim.defer_fn (lambda loading []
                ;; Require core
                (require :core)
                ;; Re-enable syntax and filetype
                (vim.cmd "syntax on")
                (vim.cmd "filetype on")
                (vim.cmd "filetype plugin indent on")
                ;; Load plugins
                (when (installed! :packer.nvim)
                  ;; Tree-sitter
                  (when (installed! :nvim-treesitter)
                    (vim.cmd "PackerLoad nvim-treesitter"))
                  ;; Statusline components
                  (when (installed! :nvim-gps)
                    (vim.cmd "PackerLoad nvim-gps"))
                  ;; Statusline
                  (when (installed! :heirline.nvim)
                    (vim.cmd "PackerLoad heirline.nvim"))
                  ;; Telescope
                  (when (installed! :telescope.nvim)
                    (vim.cmd "PackerLoad telescope.nvim")))
                ;; Fix some plugins stuff, e.g. tree-sitter modules
                (vim.cmd "doautocmd BufEnter")) 0)
