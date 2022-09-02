(local {: blend-colors} (require :utils.colors))

;;; Tabline dynamic color palette
(fn get-color [name]
  (local doom-one-palette
         ((. (require :doom-one.colors) :get_palette) (vim.opt.background:get)))
  (local palette {:fg1 (. doom-one-palette :fg)
                  :fg2 (. doom-one-palette :fg_alt)
                  :bg1 (. doom-one-palette :base0)
                  :bg2 (. doom-one-palette :bg)
                  :bg3 (. doom-one-palette :bg)
                  :bg4 (. doom-one-palette :bg_alt)
                  :red (. doom-one-palette :red)
                  :ylw (. doom-one-palette :yellow)
                  :grn (. doom-one-palette :green)
                  :cya (. doom-one-palette :cyan)
                  :blu (. doom-one-palette :blue)
                  :tea (. doom-one-palette :teal)
                  :mag (. doom-one-palette :magenta)
                  :acc (. doom-one-palette :violet)})
  (. palette name))

;;; Tabline setup
(local {: setup} (require :tabline_framework))
(local {:setup setup-icons} (require :nvim-web-devicons))

;; Set custom icons
(setup-icons {:override {:fnl {:icon "" :color (get-color :grn) :name :Fennel}
                         :tl {:icon "" :color (get-color :tea) :name :Teal}}})

(fn render [f]
  (f.make_bufs (lambda [info]
                 (var icon (f.icon info.filename))
                 (when (not icon)
                   (set icon ""))
                 (var icon-color (f.icon_color info.filename))
                 (when (= icon-color :NONE)
                   (print "icon color is NONE")
                   (set icon-color (get-color :fg1)))
                 (local color-fg
                        (if info.current
                            icon-color
                            (blend-colors icon-color (get-color :bg1) 0.41)))
                 (local color-bg
                        (if info.current
                            (blend-colors icon-color (get-color :bg1) 0.38)
                            (blend-colors icon-color (get-color :bg1) 0.2)))
                 (f.add {1 (.. "  " icon " ") :fg color-fg :bg color-bg})
                 (f.add {1 (.. (if info.filename info.filename :Empty) "  ")
                         :fg (if info.current (get-color :fg1) color-fg)
                         :bg color-bg})
                 (f.add {1 (.. (if info.modified "•" "✕") " ")
                         :fg (if info.modified
                                 color-fg
                                 (if info.current (get-color :red) color-fg))
                         :bg color-bg})))
  (f.add_spacer)
  (f.make_tabs (lambda [info]
                 (f.add (.. " " info.index " ")))))

(setup {: render})

;; Fix for white colors on colorscheme change
(vim.api.nvim_create_augroup :Tabline {:clear true})
(vim.api.nvim_create_autocmd :ColorScheme
                             {:callback (fn []
                                          (setup-icons {:override {:fnl {:icon "" :color (get-color :grn) :name :Fennel}
                                                                   :tl {:icon "" :color (get-color :tea) :name :Teal}}})
                                          (setup {: render}))
                              :group :Tabline})
