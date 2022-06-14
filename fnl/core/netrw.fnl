;;; netrw.fnl - Saner netrw defaults
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : let!} :core.macros)

;;; Configuration
;; Disable banner
(let! :g.netrw_banner 0)

;; Keep the current directory and the broesing directory synced
;; NOTE: this helps to avoid the move files error
(let! :g.netrw_keepdir 1)

;; Show directories first (sorting)
(let! :g.netrw_sort_sequence "[\\/]$,*")

;; Human-readable file size
(let! :g.netrw_sizestyle :H)

;; Tree view
(let! :g.netrw_liststyle 3)

;; Hide files from .gitignore
(let! :g.netrw_lis_hide ((. vim.fn "netrw_gitignore#Hide")))

;; Show hidden files
(let! :g.netrw_hide 0)

;; Chang the size of the Netrw window when it creates a split
(let! :g.netrw_winsize (- 0 25))

;; Preview files in a vertical split window
(let! :g.netrw_preview 1)

;; Open files in split (open previous window)
(let! :g.netrw_browse_split 4)

;; Setup file operations commands (recursive operations)
(let! :g.netrw_localcopydircmd "cp -r")
(let! :g.netrw_localmkdir "mkdir -p")
(let! :g.netrw_localrmdir "rm -r")

;; Highlight marked files in the same way search matches are
(cmd "hi! link netrwMarkFile Search")

;;; netrw.fnl ends here
