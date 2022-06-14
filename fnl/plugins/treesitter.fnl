(import-macros {: lazy-require!} :core.macros)

(local {: setup} (lazy-require! :nvim-treesitter.configs))
(local parsers (lazy-require! :nvim-treesitter.parsers))

;;; Extra parsers
(local parser-config (parsers.get_parser_configs))

;; neorg treesitter parsers 
(set parser-config.norg {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                                        :files [:src/parser.c :src/scanner.cc]
                                        :branch :main}})

(set parser-config.norg_meta
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                     :files [:src/parser.c]
                     :branch :main}})

(set parser-config.norg_table
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                     :files [:src/parser.c]
                     :branch :main}})

;;; Setup
(setup {:ensure_installed [:c
                           :cpp
                           :lua
                           :vim
                           :rust
                           :json
                           :regex
                           :fennel
                           :python
                           :jsdoc
                           :javascript
                           :markdown
                           :comment
                           :norg
                           :norg_meta
                           :norg_table]
        :highlight {:enable true
                    :use_languagetree true
                    :custom_captures {:punctuation.bracket "" :constructor ""}}
        :indent {:enable true :disable [:python]}
        :playground {:enable true}
        :rainbow {:enable true
                  :extended_mode true
                  :max_file_lines 1000
                  :colors ["#51afef" "#4db5bd" "#c678dd" "#a9a1e1"]}
        :update_strategy :lockfile})
