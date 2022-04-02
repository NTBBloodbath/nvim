;;; init.fnl - Neovim init file
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

;; use opt-in filetype.lua instead of vimscript default
;; EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
(tset vim.g :did_load_filetypes 1)
(tset vim.g :do_filetype_lua 1)

;; Temporarily disable syntax and filetype to improve startup time
(vim.api.nvim_command "syntax off")
(vim.api.nvim_command "filetype off")
(vim.api.nvim_command "filetype plugin indent off")

;; Load configuration core
(require :core)

(fn installed! [plugin-name]
  "Check if a plugin is installed or not"
  (= 0 (vim.fn.empty (vim.fn.glob (string.format "%s/packer/opt/%s"
                                                 (.. (vim.fn.stdpath :data)
                                                     :/site/pack)
                                                 plugin-name)))))

;; Defer plugins loading
(vim.defer_fn (lambda loading []
                ;; Re-enable syntax and filetype
                (vim.api.nvim_command "syntax on")
                (vim.api.nvim_command "filetype on")
                (vim.api.nvim_command "filetype plugin indent on")
                ;; Load colorscheme
                (when (installed! :doom-one.nvim)
                  (vim.api.nvim_command "packadd doom-one.nvim")
                  (vim.api.nvim_command "colorscheme doom-one"))
                ;; Load plugins
                (when (installed! :packer.nvim)
                  ;; Tree-sitter
                  (when (installed! :nvim-treesitter)
                    (vim.api.nvim_command "PackerLoad nvim-treesitter"))
                  ;; Statusline components
                  (when (installed! :nvim-gps)
                    (vim.api.nvim_command "PackerLoad nvim-gps"))
                  ;; Statusline
                  (when (installed! :heirline.nvim)
                    (vim.api.nvim_command "PackerLoad heirline.nvim"))
                  ;; Telescope
                  (when (installed! :telescope.nvim)
                    (vim.api.nvim_command "PackerLoad telescope.nvim")))
                ;; Fix some plugins stuff, e.g. tree-sitter modules
                (vim.api.nvim_command "doautocmd BufEnter")) 0)
                ;; Launch *scratch* buffer if no arguments were passed to Neovim 
                ;; ((. (require :utils.scratch) :load))) 0)

;;; init.fnl ends here
