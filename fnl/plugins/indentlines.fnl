(local {: setup} (require :indent_blankline))

;;; Setup
(setup {:char "│"
        :use_treesitter true
        :show_first_indent_level true
        :show_current_context true
        :show_current_context_start true
        :filetype_exclude [:help :lspinfo :packer :norg :fennel]
        :buftype_exclude [:terminal]})
