;;; autocmds.fnl - Autocommands
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: au!} :core.macros)

;; Packer autocommands
(au! [:BufWritePost] [:*/modules/init.fnl] "PackerCompile profile=true" {})
(au! [:VimLeavePre] [:*/modules/init.fnl :*/modules/**/*.fnl]
     "PackerCompile profile=true" {})

;; Highlight yanked text
(au! [:TextYankPost] ["*"] vim.highlight.on_yank {})

;; Autosave
(au! [:TextChanged :InsertLeave] [:<buffer>] "silent! write" {})

;; Format on save
;; (au! [:BufWritePre] [:<buffer>] "silent! Format" {})

;; Preserve last editing position
(au! [:BufReadPost] ["*"]
     (. (require :core.autocmds.utils) :preserve_position) {})

;; Quickly exit help pages
(au! [:FileType] [:help] "nnoremap <silent> <buffer> q :q<cr>" {})

;; Always use doom-one colorscheme when editing norg files
;; BUG: this seems to not be updating file highlight groups automatically
;; (au! [:FileType] [:norg] "colorscheme doom-one" {})

;; Disable numbering and signcolumn in Man pages
(au! [:BufEnter :BufWinEnter] ["man://*"] "setlocal nonu nornu scl=no" {})

;;; autocmds.fnl ends here
