(local {: setup} (require :indent_blankline))

;;; Setup
(setup {:char "│"
        :use_treesitter false
        :show_first_indent_level true
        :show_current_context true
        :show_current_context_start true
        :filetype_exclude [:help :lspinfo :packer :norg :fennel :man]
        :buftype_exclude [:terminal]})
