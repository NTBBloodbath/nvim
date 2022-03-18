;;; autocmds.fnl - Autocommands
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: au! : au-nested! : augroup!} :core.macros)

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
     "lua require('core.autocmds.utils').preserve_position()")

;; Quickly exit help pages
(au! [:FileType] [:help] "nnoremap <silent> <buffer> q :q<cr>")

;;; Hijack netrw and use xplr instead
(augroup! :hijack-netrw
          (au! [:VimEnter] ["*"]
               "lua require('core.autocmds.utils').suppress_netrw()")
          (au-nested! [:BufEnter] ["*"]
                      "lua require('core.autocmds.utils').hijack_directory()"))

;; Open an Emacs *scratch* like buffer
;; (augroup! :scratch
;;           (au-nested! [:VimEnter] ["*"]
;;                       "lua require('core.autocmds.utils').load_scratch()"))

;;; autocmds.fnl ends here
