(module plugins.toggleterm)

(local {: setup} (require :toggleterm))

;;; Setup
(setup {:size 30
        :open_mapping :<F4>
        :hide_numbers true
        :persist_size true
        :close_on_exit true
        :shade_terminals true
        :start_in_insert true
        :direction :tab})
