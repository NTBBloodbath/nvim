;;; init.fnl - Fennel core init
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

;;; Plugins
;; plugins specifications
(require :core.plugins)
;; packer compiled file
(when (= (vim.fn.filereadable (.. (vim.fn.stdpath :config)
                                  :/lua/packer_compiled.lua)) 1)
  (require :packer_compiled))

;;; Sane defaults
(require :core.config)

;;; Autocommands
(require :core.autocmds)

;;; Keybindings
(require :core.maps)

;;; init.fnl ends here
