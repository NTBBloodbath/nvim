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

;; Set custom keybindings for netrw
(au! [:FileType] [:netrw] (. (require :core.netrw) :set_netrw_maps) {})

;;; Hijack netrw and use xplr instead
;;; FIXME(ntbbloodbath): this seems to produce a segfault in Neovim so it is commented atm
;; (augroup! :hijack-netrw
;;           (au! [:VimEnter] ["*"]
;;                "lua require('core.autocmds.utils').suppress_netrw()")
;;           (au-nested! [:BufEnter] ["*"]
;;                       "lua require('core.autocmds.utils').hijack_directory()"))

;;; autocmds.fnl ends here
