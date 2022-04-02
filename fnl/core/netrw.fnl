;;; netrw.fnl - Saner netrw defaults
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : let! : kbd-buf!} :core.macros)

;;; Configuration
;; Disable banner
(let! :g.netrw_banner 0)

;; Keep the current directory and the broesing directory synced
;; NOTE: this helps to avoid the move files error
(let! :g.netrw_keepdir 0)

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

;;; Keybindings
(fn set-netrw-maps []
  ;; General keys
  ;; Toggle dotfiles
  (kbd-buf! [n] "." "gh")

  ;; Open file and close netrw
  (kbd-buf! [n] "l" "<cr>:Lexplore<cr>")

  ;; Open file or directory
  (kbd-buf! [n] "o" "<cr>")

  ;; Show netrw help in a floating (or maybe sidebar?) window
  ;; TODO: implement show_help function so we can implement this mapping

  ;; Close netrw
  (kbd-buf! [n] "q" "<cmd>Lexplore<cr>")

  ;; Files and Directories keys
  ;; Create a new file and save it
  (kbd-buf! [n] "ff" "%:w<CR>:buffer #<CR>")

  ;; Create a new directory
  (kbd-buf! [n] "fa" "d")

  ;; Rename file
  (kbd-buf! [n] "fr" "R")

  ;; Remove file or directory
  (kbd-buf! [n] "fd" "D")

  ;; Copy marked file
  (kbd-buf! [n] "fc" "mc")

  ;; Copy marked file in one step, with this we can put the cursor in a directory
  ;; after marking the file to assign target directory and copy file
  (kbd-buf! [n] "fC" "mtmc")

  ;; Move marked file
  (kbd-buf! [n] "fx" "mm")

  ;; Move marked file in one step, same as fC but for moving files
  (kbd-buf! [n] "fX" "mtmm")

  ;; Execute commands in marked file or directory
  (kbd-buf! [n] "fe" "mx")

  ;; Show a list of marked files and directories
  (kbd-buf! [n] "fm" ":echo \"Marked files:\n\" . join(netrw#Expose(\"netrwmarkfilelist\"), \"\n\")<CR>")

  ;; Show target directory
  (kbd-buf! [n] "ft" ":echo \"Target: \" . netrw#Expose(\"netrwmftgt\")<CR>")

  ;; Marks (selections) keys
  ;; Toggle the mark on a file or directory
  (kbd-buf! [n] "<TAB>" "mf")

  ;; Unmark all the files in the current buffer
  (kbd-buf! [n] "<S-TAB>" "mF")

  ;; Remove all the marks on all files
  (kbd-buf! [n] "<Leader><TAB>" "mu")

  ;; Bookmarks keys
  ;; Create a bookmark
  (kbd-buf! [n] "bc" "mb")

  ;; Remove the most recent bookmark
  (kbd-buf! [n] "bd" "mB")

  ;; Jump to the most recent bookmark
  (kbd-buf! [n] "bj" "gb"))

{:set_netrw_maps set-netrw-maps}

;;; netrw.fnl ends here
