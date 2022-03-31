;;; init.fnl - Fennel core init
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

;; (module core.init)

;;; Plugins
(require :core.plugins)

;;; Sane defaults
(require :core.config)

;;; Autocommands
(require :core.autocmds)

;;; Keybindings
(require :core.maps)

;;; init.fnl ends here
