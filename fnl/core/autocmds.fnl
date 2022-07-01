;;; autocmds.fnl - Autocommands
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: au!} :core.macros)

;; Packer autocommands
(au! [:BufWritePost] [:*/core/plugins.fnl] "PackerCompile profile=true" {})
(au! [:VimLeavePre] [:*/core/plugins.fnl :*/plugins/*.fnl]
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

;;; autocmds.fnl ends here
