;;; init.fnl - Fennel core init
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(module core.init)

;;; Sane defaults
(require :core.config)

;;; Autocommands
(require :core.autocmds)

;;; Keybindings
(require :core.maps)

;;; Plugins
(require :core.plugins)

;;; init.fnl ends here
