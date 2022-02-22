(local {: setup} (require :nvim-treesitter.configs))

(setup {:ensure_installed [:c
                           :lua
                           :fennel
                           :python]
        :highlight {:enable true
                    :use_languagetree true
                    :custom_captures {"punctuation.bracket" ""
                                      :constructor ""}}
        :indent {:enable true
                 :disable [:python]}
        :playground {:enable true}
        :rainbow {:enable true
                  :extended_mode true}})
