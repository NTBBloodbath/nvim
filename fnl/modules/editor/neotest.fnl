(import-macros {: kbd!} :core.macros)

(local {: setup} (require :neotest))
(local neotest-python (require :neotest-python))

;;; Setup neotest
;; Setup
(setup {:adapters [neotest-python]})

;;; Keybinds
;; Run nearest test
(kbd! [n] :tr "require('neotest').run.run()")

;; Run test file
(kbd! [n] :tf "require('neotest').run.run(vim.fn.expand('%'))")
