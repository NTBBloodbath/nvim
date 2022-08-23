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

;;; Utility functions
(fn get-rgb [color]
  (let [red (tonumber (color:sub 2 3) 16)
        grn (tonumber (color:sub 4 5) 16)
        blu (tonumber (color:sub 6 7) 16)]
    [red grn blu]))

(fn blend-colors [top bottom alpha]
  (let [top-rgb (get-rgb top)
        bottom-rgb (get-rgb bottom)
        blend (fn [c]
                (set-forcibly! c
                               (+ (* alpha (. top-rgb c))
                                  (* (- 1 alpha) (. bottom-rgb c))))
                (math.floor (+ (math.min (math.max 0 c) 255) 0.5)))]
    (string.format "#%02X%02X%02X" (blend 1) (blend 2) (blend 3))))

;;; Tabline setup
(local {: setup} (require :tabline_framework))

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
