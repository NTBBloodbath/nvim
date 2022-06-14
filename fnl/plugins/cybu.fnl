(import-macros {: kbd!} :core.macros)

(local {: setup} (require :cybu))

;;; Setup Cybu
;; Setup
(setup {:display_time 1500
        :position {:anchor :center
                   :relative_to :editor}})

;; Keybinds
(kbd! [n] :K "<Plug>(CybuPrev)")
(kbd! [n] :J "<Plug>(CybuNext)")
