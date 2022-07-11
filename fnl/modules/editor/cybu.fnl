(import-macros {: kbd!} :core.macros)

(local {: setup} (require :cybu))

;;; Setup Cybu
;; Setup
(setup {:display_time 1000
        :position {:anchor :center :relative_to :editor}
        :style {:path :relative
                :prefix ""
                :padding 2
                :border :rounded
                :devicons {:enabled true :colored true}
                :highlights {:current_buffer :Constant
                             :background :NormalFloat}}})

;; Keybinds
(kbd! [n] :K "<Plug>(CybuPrev)")
(kbd! [n] :J "<Plug>(CybuNext)")
(kbd! [n] :<Tab> "<Plug>(CybuNext)")
(kbd! [n] :<S-Tab> "<Plug>(CybuPrev)")
