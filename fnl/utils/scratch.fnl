;;; scratch.fnl - Emacs' *scratch*-like buffer
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : set-local! : kbd-buf!} :core.macros)

(fn load []
  (when (and (= (vim.fn.argc) 0) (= (vim.fn.line2byte "$") -1)
             (= (vim.fn.bufexists 0) 0))
    (local scratch-comments [";; This buffer is for Fennel evaluation."
                             ";; If you want to create a file, run ':write' with a file name."
                             ";; NOTE: press <A-r> to evaluate buffer"
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
    ;; Set Lua as the filetype so we get highlighting
    (set-local! filetype :fennel)
    ;; Set documentation lines and move cursor to last line
    (vim.api.nvim_buf_set_lines 0 0 -1 true scratch-comments)
    (vim.api.nvim_win_set_cursor 0 [5 0])
    ;; Automatically start insert mode
    (cmd :startinsert)
    ;; Set keybindings
    (kbd-buf! [n] :<A-r> :<cmd>FnlBuffer<cr>)
    (kbd-buf! [i] :<A-r> :<cmd>FnlBuffer<cr>)))

{: load}

;;; scratch.fnl ends here
