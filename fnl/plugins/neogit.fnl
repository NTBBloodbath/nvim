(import-macros {: kbd!} :core.macros)

(local {: setup : popups} (require :neogit))

;;; Setup neogit
;; Setup
(setup {:disable_commit_confirmation true
        :use_magit_keybindings true
        :kind :split_above
        :commit_popup {:kind :split}
        :signs {:section ["" ""]
                :item ["▸" "▾"]
                :hunk ["樂" ""]}})

;; Keybinds
(kbd! [n] :<F2> :<cmd>Neogit<cr>)
(kbd! [n] :<leader>gs :<cmd>Neogit<cr>)
(kbd! [n] :<leader>gc "<cmd>Neogit commit<cr>")
(kbd! [n] :<leader>gl popups.pull.create)
(kbd! [n] :<leader>gp popups.push.create)
