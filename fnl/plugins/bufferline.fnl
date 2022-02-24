(module plugins.bufferline)

(local {: setup} (require :bufferline))

;;; Setup bufferline
;; Setup
(setup {:options {:numbers :buffer_id
                  :max_name_length 20
                  :tab_size 20
                  :diagnostics :nvim_lsp
                  :offsets {{:filetype :help
                              :text "Help page"
                              :text_align :center} {:filetype :packer
                                                                                                                                                 :text "Plugins manager"
                                                                                                                                                 :text_align :center}}
                  :show_buffer_icons true
                  :show_buffer_close_icons true
                  :show_close_button false
                  :sho_tab_indicators true
                  :persist_buffer_sort true
                  :separator_style :slant
                  :enforce_regular_tabs true
                  :always_show_bufferline false
                  :sort_by :directory}})
