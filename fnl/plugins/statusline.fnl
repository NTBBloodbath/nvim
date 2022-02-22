(local {: insert} table)
(local fennelview (require :core.fennelview))
(local {: get_icon_color} (require :nvim-web-devicons))
(local {: setup} (require :heirline))
(local {: make_flexible_component
        : pick_child_on_condition
        : get_highlight} (require :heirline.utils))
(local {: width_percent_below} (require :heirline.conditions))

(import-macros {: nil?} :core.macros)

;;; Components
;; Borders
(local border-left {})
(fn border-left.provider [self]
  "▊")
(fn border-left.hl [self]
  (let [hl {:fg "#51afef"
            ;; :bg "#23272e"
            :style :bold}]
    hl))

(local border-right {})
(fn border-right.provider [self]
  "▊")
(fn border-right.hl [self]
  (let [hl {:fg "#51afef"
            :bg "#23272e"
            :style :bold}]
    hl))

;; Spacing
(local align {:provider "%=" :bg "#23272e"})
(local space {:provider " " :bg "#23272e"})

;; Vi-mode
(local vi-mode {:static {:names {:n :Normal
                                 :no :Normal
                                 :i :Insert
                                 :t :Terminal
                                 :v :Visual
                                 :V :Visual
                                 :r :Replace
                                 :R :Replace
                                 :Rv :Replace
                                 :c :Command}
                         :colors {:n "#ff6c6b"
                                  :no "#ff6c6b"
                                  :i "#98be65"
                                  :t "#ff6c6b"
                                  :v "#51afef"
                                  :V "#51afef"
                                  :r "#4db5bd"
                                  :R "#c678dd"
                                  :Rv "#c678dd"
                                  :c "#c678dd"}}})
(fn vi-mode.init [self]
  (set self.mode (vim.fn.mode)))
(fn vi-mode.provider [self]
  " ")
(fn vi-mode.hl [self]
  (let [mode (self.mode:sub 1 1)
        hl {:fg (. self.colors mode)
            :bg "#23272e"
            :style :bold}]
    hl))

;; File (name, icon)
(local file-info {})
(fn file-info.init [self]
  (set self.filename (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0) ":."))
  (set self.extension (vim.fn.fnamemodify self.filename ":e")))

(local file-icon {})
(fn file-icon.init [self]
  (let [(icon icon-color) (get_icon_color self.filename self.extension {:default true})]
    (values icon icon-color)
    (set self.icon icon)
    (set self.icon_color icon_color)))
(fn file-icon.provider [self]
  (if (not (nil? self.icon))
    (.. self.icon " ")
    self.icon))
(fn file-icon.hl [self]
  (let [hl {:fg self.icon_color
            :bg "#23272e"}]
    hl))

(local file-name {})
(insert file-name (make_flexible_component 2
                                           {:provider (lambda []
                                                        (let [filename (vim.fn.fnamemodify
                                                          (vim.api.nvim_buf_get_name 0) ":.")]
                                                          (if (= (length filename) 0)
                                                            "[No Name]"
                                                            filename)))}
                                           {:provider (lambda []
                                                        (vim.fn.pathshorten
                                                          (vim.fn.fnamemodify
                                                            (vim.api.nvim_buf_get_name 0) ":.")))}))
(fn file-name.hl [self]
  (let [hl {:fg "#bbc2cf"
            :bg "#23272e"}]
    hl))

(local file-flags {1 {:provider (lambda []
                                  (if (= vim.bo.modified true)
                                    "[+]"))
                      :hl {:fg "#98be65"
                           :bg "#23272e"}}
                   2 {:provider (lambda []
                                  (if (or (not vim.bo.modifiable) vim.bo.readonly)
                                    ""))
                      :hl {:fg "#ecbe7b"
                           :bg "#23272e"}}})

(insert file-info file-icon)
(insert file-info file-name)
(insert file-info space)
(insert file-info file-flags)
(insert file-info {:provider "%<" :hl {:bg "#23272e"}})

;;; Statuslines
;; Default
(local default-statusline {1 border-left
                           2 space
                           3 vi-mode
                           4 space
                           5 file-info
                           6 align
                           7 border-right})
(fn default-statusline.init [self]
  pick_child_on_condition)
(fn default-statusline.hl [self]
    (let [statusline (get_highlight "StatusLine")]
      {:fg (. statusline fg)
       :bg (. statusline bg)}))

;;; Setup
(setup [default-statusline])
