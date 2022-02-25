;;; utils.fnl - Autocommands functions
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(local {: format} string)

(import-macros {: cmd : set-local!} :core.macros)

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

(fn load-scratch []
  (when (and (= (vim.fn.argc) 0) (= (vim.fn.line2byte "$") -1)
             (= (vim.fn.bufexists 0) 0))
    (local scratch-comments ["-- This buffer is for Lua evaluation."
                             "-- If you want to create a file, run ':write' with a file name."
                             ""
                             ""])
     ;; Set buffer name
    (cmd "file *scratch*")
    ;; Hide buffer once it's no longer displayed in a window
    (set-local! bufhidden :hide)
    ;; Scratch buffer does not belong to a file so cannot be saved
    (set-local! buftype :nofile)
    ;; List buffer in ':ls'
    (set-local! buflisted true)
    ;; Set Lua as the filetype so we get highlighting and lsp
    (set-local! filetype :lua)
    ;; Set documentation lines and move cursor to last line
    (vim.api.nvim_buf_set_lines 0 0 -1 true scratch-comments)
    (vim.api.nvim_win_set_cursor 0 [4 0])
    ;; Automatically start insert mode
    (cmd "startinsert")
    ;; Attach luapad to scratch buffer for evaluation
    (cmd "lua require('luapad').attach()")))

{:preserve_position preserve-position
 :hijack_directory hijack-directory
 :suppress_netrw suppress-netrw
 :load_scratch load-scratch}

;;; utils.fnl ends here
