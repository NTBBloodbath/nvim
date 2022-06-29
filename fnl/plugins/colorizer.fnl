(import-macros {: au!} :core.macros)

(local {: setup} (require :colorizer))

;;; Setup
;; Setup colorizer
(setup ["*"] {:mode :virtualtext})

;; Autocommands
;; (au! [:BufEnter] ["*"] "lua COLORIZER_SETUP_HOOK()" {})
