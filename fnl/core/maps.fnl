;;; maps.fnl - Keybindings
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: let!
                : kbd!} :core.macros)

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
(kbd! [n] "ww" :<cmd>w<cr>)

;; Fast exit from Neovim
(kbd! [n] :ZZ :<cmd>wqa<cr>)

;; ESC to turn off search highlighting
(kbd! [n] :<esc> :<cmd>noh<cr>)

;; Escape remaps
(kbd! [i] :jk :<esc>)
(kbd! [i] :kj :<esc>)

;; Do not copy on paste
(kbd! [v] :p "\"_dP")

;;; Movement
;; TAB to cycle buffers
(kbd! [n] :<Tab>   :<cmd>bnext<cr>)
(kbd! [n] :<S-Tab> :<cmd>bprev<cr>)

;; Move between windows
(kbd! [n] :<C-h> :<C-w>h) ; left
(kbd! [n] :<C-j> :<C-w>j) ; down
(kbd! [n] :<C-k> :<C-w>k) ; upper
(kbd! [n] :<C-l> :<C-w>l) ; right

;; Resize splits
(kbd! [n] :<C-Up>    "<cmd>resize +2<cr>") ; increase height
(kbd! [n] :<C-Down>  "<cmd>resize -2<cr>") ; decrease height
(kbd! [n] :<C-Left>  "<cmd>vertical resize +2<cr>") ; increase width
(kbd! [n] :<C-Right> "<cmd>vertical resize -2<cr>") ; decrease width

;; Stay in visual mode after indenting with < or >
(kbd! [v] :> :>gv)
(kbd! [v] :< :<gv)

;;; maps.fnl ends here
