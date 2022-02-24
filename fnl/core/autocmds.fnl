;;; autocmds.fnl - Autocommands
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: au! : au-fn!} :core.macros)

;; Packer autocommands
(au! [:BufWritePost] [:*/core/plugins.fnl] "PackerCompile profile=true")
(au! [:VimLeavePre] [:*/core/plugins.fnl :*/plugins/*.fnl]
     "PackerCompile profile=true")

;; Highlight yanked text
(au! [:TextYankPost] ["*"] "lua vim.highlight.on_yank({timeout = 300})")

;; Autosave
(au! [:TextChanged :InsertLeave] [:<buffer>] "silent! write")

;; Format on save
(au! [:BufWritePre] [:<buffer>] "silent! Format")

;; Preserve last editing position
(au! [:BufReadPost] ["*"]
     "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif")

;; Quickly exit help pages
(au! [:FileType] [:help] "nnoremap <silent> <buffer> q :q<cr>")

;;; autocmds.fnl ends here
