(import-macros {: kbd!} :core.macros)

(local {: setup} (require :neotest))

;;; Setup neotest
;; Setup
(setup {})

;;; Keybinds
;; Run nearest test
(kbd! [n] :tr "require('neotest').run.run()")

;; Run test file
(kbd! [n] :tf "require('neotest').run.run(vim.fn.expand('%'))")
