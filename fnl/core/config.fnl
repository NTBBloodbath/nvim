;;; config.fnl - Neovim user configurations (saner defaults)
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: set!} :core.macros)

;;; Global options
(set! hidden      true
      updatetime  200
      timeoutlen  500
      completeopt ["menu"
                   "menuone"
                   "preview"
                   "noinsert"
                   "noselect"]
      shortmess   "atsc"
      inccommand  "split"
      path        "**")

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Disable swapfiles and enable undofiles
(set! swapfile false
      undofile true)

;;; UI-related options
;; Numbering
(set! number         true
      relativenumber true)

;; True-color
(set! termguicolors true)

;; Cols and chars
(set! signcolumn "auto:2-3"
      foldcolumn "auto:9"
      fillchars  {:eob       " "
                  :vert      "▕"
                  :fold      " "
                  :diff      "─"
                  :msgsep    "‾"
                  :foldsep   "│"
                  :foldopen  "▾"
                  :foldclose "▸"})

;; Do not show mode
(set! showmode false)

;; Set windows width
(set! winwidth 40)

;; Highlight current cursor line
(set! cursorline true)

;;; Buffer options
;; Never wrap
(set! wrap false)

;; Indentation rules
(set! copyindent     true
      smartindent    true
      preserveindent true)

;; Indentation level
(set! tabstop     4
      shiftwidth  4
      softtabstop 4)

;; Expand tabs
(set! expandtab true)

;; Enable concealing
(set! conceallevel 2)

;; Automatic split locations
(set! splitright true
      splitbelow true)

;; Scroll off
(set! scrolloff 8)
