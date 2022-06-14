;;; utils.fnl - Autocommands functions
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(local {: format} string)

(import-macros {: cmd : set-local! : kbd-buf!} :core.macros)

(fn preserve-position []
  (when (and (> (vim.fn.line "'\"") 1)
             (<= (vim.fn.line "'\"") (vim.fn.line "$")))
    (cmd "normal! g'\"")))

{:preserve_position preserve-position}

;;; utils.fnl ends here
