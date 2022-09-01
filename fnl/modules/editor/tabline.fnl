(local {: blend-colors} (require :utils.colors))

;;; Tabline dynamic color palette
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
                :mag (. doom-one-palette :magenta)
                :acc (. doom-one-palette :violet)})

;;; Tabline setup
(local {: setup} (require :tabline_framework))
(local {: set_icon} (require :nvim-web-devicons))

;; Set custom icons
(set_icon {:fnl {:icon ""
                 :color (. doom-one-palette :green)
                 :name :Fennel}})
(set_icon {:tl {:icon ""
                :color (. doom-one-palette :teal)
                :name :Teal}})

(fn render [f]
  (f.make_bufs (lambda [info]
                 (var icon (f.icon info.filename))
                 (when (not icon)
                   (set icon ""))
                 (var icon-color (f.icon_color info.filename))
                 (when (not icon-color)
                   (set icon-color palette.fg1))
                 (local color-fg
                        (if info.current icon-color
                            (blend-colors icon-color palette.bg1 0.41)))
                 (local color-bg
                        (if info.current
                            (blend-colors icon-color palette.bg1 0.38)
                            (blend-colors icon-color palette.bg1 0.2)))
                 (f.add {1 (.. "  " icon " ") :fg color-fg :bg color-bg})
                 (f.add {1 (.. (if info.filename info.filename :Empty) "  ")
                         :fg (if info.current palette.fg1 color-fg)
                         :bg color-bg})
                 (f.add {1 (.. (if info.modified "•" "✕") " ")
                         :fg (if info.modified
                                 color-fg
                                 (if info.current palette.red color-fg))
                         :bg color-bg})))
  (f.add_spacer)
  (f.make_tabs (lambda [info]
                 (f.add (.. " " info.index " ")))))

(setup {: render})
