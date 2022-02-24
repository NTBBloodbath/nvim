(module plugins.luasnip)

(import-macros {: kbd!} :core.macros)

(local {: config : jump : expand_or_jumpable} (require :luasnip))
(local {: load} (require :luasnip/loaders/from_vscode))
(local {: visible
        : select_prev_item
        : select_next_item
        : complete} (require :cmp))

(config.set_config {:history true
                    :updateevents "TextChanged,TextChangedI"})

;; Load snippets
(load)
