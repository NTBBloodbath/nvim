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

(fn hijack-directory []
  (when (= (vim.fn.isdirectory (vim.fn.expand "%:p")) 1)
    (local bufnr (vim.api.nvim_get_current_buf))
    (cmd (format "Xplr %s" (vim.fn.fnameescape (vim.fn.expand "%:p"))))
    (cmd (format "silent! bwipe %d" bufnr))))

(fn suppress-netrw []
  (when (= (vim.fn.exists "#FileExplorer") 1)
    (cmd "silent! autocmd! FileExplorer *")))

{:preserve_position preserve-position
 :hijack_directory hijack-directory
 :suppress_netrw suppress-netrw}

;;; utils.fnl ends here
