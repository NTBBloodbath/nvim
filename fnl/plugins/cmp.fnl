(import-macros {: nil? : set! : let! : lazy-require!} :core.macros)

(local {: insert} table)
(local {: setup
        : mapping
        : visible
        : complete
        : select_next_item
        : select_prev_item
        :config {: compare : disable}
        :ItemField {:Kind kind :Abbr abbr :Menu menu}
        :SelectBehavior {:Insert insert-behavior :Select select-behavior}
        : event} (lazy-require! :cmp))

(local types (lazy-require! :cmp.types))
(local under-compare (lazy-require! :cmp-under-comparator))
(local {: cmp_format} (lazy-require! :lspkind))
(local {: lsp_expand : expand_or_jump : expand_or_jumpable : jump : jumpable}
       (lazy-require! :luasnip))

;;; Supertab functionality utility functions
(fn has-words-before []
  (let [(ln col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and (not (= col 0)) (= (string.match (string.sub (. (vim.api.nvim_buf_get_lines 0
                                                                                     (- ln
                                                                                        1)
                                                                                     ln
                                                                                     true)
                                                         1)
                                                      col col)
                                          "%s") nil))))

(fn replace-termcodes [code]
  (vim.api.nvim_replace_termcodes code true true true))

;;; Setup
(setup {:preselect types.cmp.PreselectMode.None
        :window {:documentation {:scrollbar "║"}
                 :completion {:scrollbar "║"}}
        :snippet {:expand (lambda [args]
                            (lsp_expand args.body))}
        :mapping {:<C-b> (mapping.scroll_docs -4)
                  :<C-f> (mapping.scroll_docs 4)
                  :<C-e> (mapping.abort)
                  :<Tab> (mapping (lambda [fallback]
                                    (if (visible)
                                        (select_next_item {:behavior insert-behavior})
                                        (expand_or_jumpable)
                                        (expand_or_jump)
                                        (has-words-before)
                                        (vim.fn.feedkeys (replace-termcodes :<Tab>)
                                                         :n)
                                        (fallback)))
                                  [:i :s])
                  :<S-Tab> (mapping (lambda [fallback]
                                      (if (visible)
                                          (select_prev_item {:behavior insert-behavior})
                                          (jumpable -1)
                                          (jump -1)
                                          (fallback)))
                                    [:i :s])
                  :<CR> (mapping.confirm {:select true})}
        :sources [{:name :nvim_lsp}
                  {:name :luasnip}
                  {:name :path}
                  {:name :buffer}]
        :sorting {:comparators [compare.offset
                                compare.exact
                                compare.score
                                under-compare.under
                                compare.kind
                                compare.sort_text
                                compare.length
                                compare.order]}
        :formatting {:fields [kind abbr menu]
                     :format (cmp_format {:with_text false})}
        :experimental {:ghost_text true}})

;; Search setup
;; (setup.cmdline "/" {:view {:entries :wildmenu :separator "|"}
;;                     :sources [{:name :buffer}]})

;; cmdline setup
;; (setup.cmdline ":"
;;                {:view {:separator "|"}
;;                 :sources [{:name :path} {:name :cmdline}]
;;                 :mapping {:<Tab> (mapping (fn [fallback]
;;                                             (if (visible)
;;                                                 (mapping.select_next_item {:behavior insert-behavior})
;;                                                 (fallback)))
;;                                           [:i :s :c])
;;                           :<S-Tab> (mapping (fn [fallback]
;;                                               (if (visible)
;;                                                   (mapping.select_prev_item {:behavior insert-behavior})
;;                                                   (fallback)))
;;                                             [:i :s :c])}})
