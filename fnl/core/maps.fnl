;;; maps.fnl - Keybindings
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: let! : kbd!} :core.macros)

;; Set space as leader key
(let! :g.mapleader " ")

;;; Disable
;; Disable accidentally pressing ctrl-z and suspending Neovim
(kbd! [n] :<C-z> :<Nop>)

;; Disable ex-mode
(kbd! [n] :Q :<Nop>)

;;; Core
;; Fast command-line mode
(kbd! [n] ";" ":")

;; Fast save current buffer
(kbd! [n] :ww :<cmd>w<cr>)

;; Confirm on quit, doom-quit port in Neovim
(kbd! [c] :quit "<cmd>lua require('utils.quit').confirm_quit(false, true)<cr>")
(kbd! [c] :wq "<cmd>lua require('utils.quit').confirm_quit(true, true)<cr>")

;; Fast exit from Neovim
(kbd! [n] :ZZ "<cmd>lua require('utils.quit').confirm_quit(true, true)<cr>")

;; ESC to turn off search highlighting
(kbd! [n] :<esc> :<cmd>noh<cr>)

;; Escape remaps
(kbd! [i] :jk :<esc>)
(kbd! [i] :kj :<esc>)

;; Do not copy on paste
(kbd! [v] :p "\"_dP")

;; Exit insert mode in terminal
(kbd! [t] :<esc> "<C-\\><C-n>")

;;; Movement
;; TAB to cycle buffers
(kbd! [n] :<Tab> :<cmd>bnext<cr>)
(kbd! [n] :<S-Tab> :<cmd>bprev<cr>)

;; Close tab
(kbd! [n] :cd :<cmd>tabclose<cr>)

;; Move between windows
; left
(kbd! [n] :<C-h> :<C-w>h)

; down
(kbd! [n] :<C-j> :<C-w>j)

; upper
(kbd! [n] :<C-k> :<C-w>k)

; right
(kbd! [n] :<C-l> :<C-w>l)

;; Resize splits
; increase height
(kbd! [n] :<C-Up> "<cmd>resize +2<cr>")

; decrease height
(kbd! [n] :<C-Down> "<cmd>resize -2<cr>")

; increase width
(kbd! [n] :<C-Left> "<cmd>vertical resize +2<cr>")

; decrease width
(kbd! [n] :<C-Right> "<cmd>vertical resize -2<cr>")

;; Stay in visual mode after indenting with < or >
(kbd! [v] ">" :>gv)
(kbd! [v] "<" :<gv)

;;; Function keybindings
;; Toggle file explorer
(kbd! [n] :<F3> "<cmd>Telescope find_files<cr>")

; Toggl eterminal
(kbd! [n] :<F4> :<cmd>ToggleTerm<cr>)

;; Run debugger (gdb)
(kbd! [n] :<F5> "<cmd>lua require('core.dbg').prompt_and_run_gdb()<cr>")

;;; Leader keybindings
;; UI
(kbd! [n] :<leader>tb
      (fn []
        (if (= (vim.opt.background:get) :dark)
            (set vim.opt.background :light)
            (set vim.opt.background :dark))))

;; Buffers
; Close current buffer
(kbd! [n] :<leader>bc :<cmd>bd<cr>)

; Goto next buffer
(kbd! [n] "<leader>b]" :<cmd>bn<cr>)
(kbd! [n] :<leader>bn :<cmd>bn<cr>)

; Goto prev buffer
(kbd! [n] "<leader>b[" :<cmd>bp<cr>)
(kbd! [n] :<leader>bN :<cmd>bp<cr>)

;; Windows
; Split below
(kbd! [n] :<leader>ws :<C-w>s)

; Split right
(kbd! [n] :<leader>wv :<C-w>v)

; Balance windows
(kbd! [n] :<leader>w= :<C-w>=)

; Close current window
(kbd! [n] :<leader>wd :<C-w>c)

;;; maps.fnl ends here
