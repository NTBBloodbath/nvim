(module plugins.luasnip)

(import-macros {: kbd!} :core.macros)

(local {: config : jump : expand_or_jumpable} (require :luasnip))
(local {: load} (require :luasnip/loaders/from_vscode))

(config.set_config {:history true :updateevents "TextChanged,TextChangedI"})

;; Load snippets
(load)
