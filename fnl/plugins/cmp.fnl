(module plugins.cmp)  

(import-macros {: nil? : set! : let!} :core.macros)

(local {: insert} table)
(local {: setup
        : mapping
        : visible
        : complete
        :config {: compare : disable}
        :SelectBehavior {:Insert insert-behavior :Select select-behavior}
        : event} (require :cmp))
(local types (require :cmp.types))
(local under-compare (require :cmp-under-comparator))
(local {: lsp_expand
        : expand_or_jump
        : expand_or_jumpable
        : jump
        : jumpable} (require :luasnip))

;;; Supertab functionality utility functions
(fn has-words-before []
  (let [col (- (vim.fn.col ".") 1)
        ln  (vim.fn.getline ".")]
    (if (or (= col 0) (string.match (string.sub ln col col) "%s"))
      true
      false)))

;;; Setup
(setup {:preselect types.cmp.PreselectMode.None
        :view {:entries :custom}
        :snippet {:expand (fn [args]
                            (lsp_expand args.body))}
        :mapping {:<C-b> (mapping.scroll_docs -4)
                  :<C-f> (mapping.scroll_docs 4)
                  :<C-Space> (mapping.complete)
                  :<C-e> (mapping.abort)
                  :<Tab> (mapping (fn [fallback]
                                    (if (visible)
                                      (mapping.select_next_item {:behavior insert-behavior})
                                      (expand_or_jumpable)
                                      (expand_or_jump)
                                      ;; (has-words-before)
                                      ;; (complete)
                                      (fallback)
                                    )) [:i :s])
                  :<S-Tab> (mapping (fn [fallback]
                                      (if (visible)
                                        (mapping.select_prev_item {:behavior insert-behavior})
                                        (jumpable -1)
                                        (jump -1)
                                        (fallback)
                                      )) [:i :s])
                  :<Space> (mapping.confirm {:select false})}
  
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
        :formatting {:format (fn [entry vim-item]
                               (set vim-item.dup (. {:buffer 1
                                                     :path 1
                                                     :nvim_lsp 0} entry.source.name))
                               (set vim-item.menu (. {:nvim_lsp "[Lsp]"
                                                  :path "[Pth]"
                                                  :buffer "[Buf]"
                                                  :luasnip "[Snp]"
                                                  :treesitter "[TS]"} entry.source.name))
                               (set vim-item.kind (. {:Text " "
                                                  :Method " "
											      :Function " "
											      :Constructor " "
											      :Field "ﰠ "
											      :Variable " "
											      :Class " "
											      :Interface " "
											      :Module " "
											      :Property "ﰠ "
											      :Unit "塞"
											      :Value " "
											      :Enum "練"
											      :Keyword " "
											      :Snippet " "
											      :Color " "
											      :File " "
											      :Reference " "
											      :Folder " "
											      :EnumMember " "
											      :Constant "ﲀ "
											      :Struct "ﳤ "
											      :Event " "
											      :Operator " "
											      :TypeParameter " "}
                                                 vim-item.kind))
                               vim-item)}})

;; Search setup
(setup.cmdline "/" {:view {:name :wildmenu
                           :separator "|"}
                    :sources {:name :buffer}})

;; cmdline setup
(setup.cmdline ":" {:view {:name :wildmenu
                           :separator "|"}
                    :sources {:name :path
                              :name :cmdline}})
