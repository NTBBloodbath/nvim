(import-macros {: kbd!} :core.macros)

(local {: setup} (require :neogen))

;;; Setup
;; Setup neogen
(setup {:enabled true
        :input_after_comment true
        :jump_map :jn
        :languages {:python {:template {:annotation_convention :numpydoc}}}})

;; Keymaps
(kbd! [n] :mm :<cmd>Neogen<cr>)
