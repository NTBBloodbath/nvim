;;; config.fnl - Neovim user configurations (saner defaults)
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: let! : set!} :core.macros)

;;; Disable some built-in Neovim plugins and unneeded providers
(let [built-ins [:tar
                 :zip
                 :gzip
                 :zipPlugin
                 :tarPlugin
                 :getscript
                 :getscriptPlugin
                 :vimball
                 :vimballPlugin
                 :2html_plugin
                 :logipat
                 :rrhelper]
      providers [:perl :node :ruby :python :python3]]
  (each [_ v (ipairs built-ins)]
    (let [plugin (.. :loaded_ v)]
      (tset vim.g plugin 1)))
  (each [_ v (ipairs providers)]
    (let [provider (.. :loaded_ v :_provider)]
      (tset vim.g provider 0))))

;; Set C syntax for header files (default is C++)
(let! :g.c_syntax_for_h true)

;;; Global options
(set! hidden true
      updatetime 200
      timeoutlen 500
      ttimeoutlen 5
      completeopt [:menu :menuone :noinsert]
      shortmess :filnxtToOFatsc
      inccommand :split
      path "**")

;; Use clipboard outside Neovim
(set! clipboard :unnamedplus)

;; Enable mouse input
(set! mouse :a)

;; Faster macros
(set! lazyredraw true)

;; Disable swapfiles and enable undofiles
(set! swapfile false
      undofile true)

;;; UI-related options
;; Disable ruler
(set! ruler false)

;; Confirmation prompts for unsaved files, etc
(set! confirm true)

;; Numbering
(set! number true
      relativenumber true)

;; True-color
(set! termguicolors true)

;; Cols and chars
(set! signcolumn "auto:1-3"
      foldcolumn "auto:3")

(set! fillchars {:eob " "
                 :horiz "━"
                 :horizup "┻"
                 :horizdown "┳"
                 :vert "┃"
                 :vertleft  "┫"
                 :vertright "┣"
                 :verthoriz "╋"
                 :fold " "
                 :diff "─"
                 :msgsep "‾"
                 :foldsep "│"
                 :foldopen "▾"
                 :foldclose "▸"})

;; Do not show mode
(set! showmode false)

;; Set windows width
(set! winwidth 40)

;; Highlight current cursor line
(set! cursorline true)

;; Set a global statusline
(set! laststatus 3)

;;; Buffer options
;; Never wrap
(set! wrap false)

;; Smart search
(set! smartcase true)

;; Case-insensitive search
(set! ignorecase true)

;; Indentation rules
(set! copyindent true
      smartindent true
      preserveindent true)

;; Indentation level
(set! tabstop 4
      shiftwidth 4
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

;; Spelling
(set! spelllang "en,es"
      spelloptions "camel"
      spellsuggest "best,6")

;;; config.fnl ends here
