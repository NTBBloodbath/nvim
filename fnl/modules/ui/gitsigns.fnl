(import-macros {: kbd!} :core.macros)

(local {: setup} (require :gitsigns))

;;; Setup Gitsigns
;; Setup
(setup {:preview_config {:border :rounded}})

;; Keybinds
(kbd! [n] :gr "<cmd>Gitsigns reset_buffer<cr>")
(kbd! [n] :gh "<cmd>Gitsigns preview_hunk<cr>")
