(local {: insert} table)
(local {: upper : format} string)
;; (local fennelview (require :utils.fennelview))

(import-macros {: nil? : lazy-require!} :core.macros)

(local {: setup} (lazy-require! :heirline))
(local devicons (lazy-require! :nvim-web-devicons))
(local utils (lazy-require! :heirline.utils))
(local conditions (lazy-require! :heirline.conditions))
(local nvim-gps (lazy-require! :nvim-gps))

;;; Colors
(lambda get-hl [kind]
  (var statusline (utils.get_highlight :StatusLine))
  (if (not (conditions.is_active))
      (set statusline (utils.get_highlight :StatusLineNC)))
  (. statusline kind))

;;; Components
;; Borders
(local border-left {})
(fn border-left.provider [self]
  "▊")

(fn border-left.hl [self]
  (let [hl {:fg "#51afef" :bg (get-hl :bg) :style :bold}]
    hl))

(local border-right {})
(fn border-right.provider [self]
  "▊")

(fn border-right.hl [self]
  (let [hl {:fg "#51afef" :bg (get-hl :bg) :style :bold}]
    hl))

;; Spacing
(local align {:provider "%="})
(local space {:provider " "})

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
  "  ")

(fn vi-mode.hl [self]
  (let [mode (self.mode:sub 1 1)
        hl {:fg (. self.colors mode) :bg (get-hl :bg) :style :bold}]
    hl))

;; File (name, icon)
(local file-info {})
(fn file-info.init [self]
  (set self.filename (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0) ":."))
  (set self.extension (vim.fn.fnamemodify self.filename ":e")))

(local file-icon {})
(fn file-icon.init [self]
  (let [(icon icon-color) (devicons.get_icon_color self.filename self.extension
                                                   {:default true})]
    (values icon icon-color)
    (set self.icon icon)
    (set self.icon_color icon-color)))

(fn file-icon.provider [self]
  (if (not (nil? self.icon))
      (.. self.icon " ")
      self.icon))

(fn file-icon.hl [self]
  (let [hl {:fg self.icon_color :bg (get-hl :bg)}]
    hl))

(local file-name {})
(insert file-name
        (utils.make_flexible_component 2
                                       {:provider (lambda []
                                                    (let [filename (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0)
                                                                                       ":.")]
                                                      (if (= (length filename)
                                                             0)
                                                          "[No Name]" filename)))}
                                       {:provider (lambda []
                                                    (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0)
                                                                        ":t"))}))

(fn file-name.hl [self]
  (let [hl {:fg (get-hl :fg) :bg (get-hl :bg)}]
    hl))

(local file-flags {1 {:provider (lambda []
                                  (if (= vim.bo.modified true) " "))
                      :hl {:fg (get-hl :fg) :bg "#23272e"}}
                   2 {:provider (lambda []
                                  (if (or (not vim.bo.modifiable)
                                          vim.bo.readonly)
                                      " "))
                      :hl {:fg "#ecbe7b" :bg (get-hl :bg)}}})

(insert file-info file-icon)
(insert file-info file-name)
(insert file-info space)
(insert file-info space)
(insert file-info file-flags)
(insert file-info {:provider "%<"})

;; Ruler
;; %l = current line number
;; %L = number of lines in the buffer
;; %c = column number
;; %P = percentage through file of displayed window
(local ruler {:provider "%7(%l/%3L%):%2c %P"})

;; Git
(local git {:condition conditions.is_git_repo})
(fn git.init [self]
  (set self.status-dict vim.b.gitsigns_status_dict)
  (if (or (not (= (. self.status-dict :added) 0))
          (not (= (. self.status-dict :removed) 0))
          (not (= (. self.status-dict :changed) 0)))
      (set self.has_changes true)
      (set self.has_changes false)))

(local git-branch {})
(local git-branch-icon {:provider " " :hl {:fg "#ff6c6b"}})

(local git-branch-name {})
(fn git-branch-name.provider [self]
  (. self.status-dict :head))

(insert git-branch git-branch-icon)
(insert git-branch git-branch-name)

(local git-diff-spacing {:provider " "})
(fn git-diff-spacing.condition [self]
  self.has_changes)

(local git-added {})
(fn git-added.provider [self]
  (let [count (. self.status-dict :added)]
    (when (and (not (= count nil)) (> count 0))
      (format " %d" count))))

(fn git-added.hl [self]
  {:fg "#98be65"})

(local git-removed {})
(fn git-removed.provider [self]
  (let [count (. self.status-dict :removed)]
    (when (and (not (= count nil)) (> count 0))
      (format " %d " count))))

(fn git-removed.hl [self]
  {:fg "#ff6c6b"})

(local git-changed {})
(fn git-changed.provider [self]
  (let [count (. self.status-dict :changed)]
    (when (and (not (= count nil)) (> count 0))
      (format " %d" count))))

(fn git-changed.hl [self]
  {:fg "#da8548"})

(insert git git-branch)
(insert git git-diff-spacing)
(insert git git-added)
(insert git git-diff-spacing)
(insert git git-removed)
(insert git git-changed)

;; nvim-gps
(local gps {:condition nvim-gps.is_available})
(fn gps.provider [self]
  (nvim-gps.get_location))

;; Diagnostics
(local diagnostics {:condition conditions.has_diagnostics
                    1 {:provider (lambda [self]
                                   (when (> self.errors 0)
                                     (.. " " self.errors)))
                       :hl {:fg (. (utils.get_highlight :LspDiagnosticsSignError)
                                   :fg)}}
                    2 {:provider (lambda [self]
                                   (when (> self.warnings 0)
                                     (.. " " self.warnings)))
                       :hl {:fg (. (utils.get_highlight :LspDiagnosticsSignWarning)
                                   :fg)}}
                    3 {:provider (lambda [self]
                                   (when (> self.hints 0)
                                     (.. " " self.hints)))
                       :hl {:fg (. (utils.get_highlight :LspDiagnosticsSignHint)
                                   :fg)}}
                    4 {:provider (lambda [self]
                                   (when (> self.info 0)
                                     (.. " " self.info)))
                       :hl {:fg (. (utils.get_highlight :LspDiagnosticsSignInformation)
                                   :fg)}}})

(fn diagnostics.init [self]
  (set self.errors
       (length (vim.diagnostic.get 0 {:severity vim.diagnostic.severity.ERROR})))
  (set self.warnings
       (length (vim.diagnostic.get 0 {:severity vim.diagnostic.severity.WARN})))
  (set self.hints
       (length (vim.diagnostic.get 0 {:severity vim.diagnostic.severity.HINT})))
  (set self.info
       (length (vim.diagnostic.get 0 {:severity vim.diagnostic.severity.INFO}))))

;; Terminal name
(local terminal-name {})
(fn terminal-name.provider [self]
  (format "Terminal %d" vim.b.toggle_number))

;;; Statuslines
;; Default
(local default-statusline {1 border-left
                           2 space
                           3 vi-mode
                           4 space
                           5 file-info
                           6 diagnostics
                           7 align
                           8 gps
                           9 align
                           10 git
                           11 space
                           12 ruler
                           13 space
                           14 border-right})

(fn default-statusline.hl [self]
  (let [fg (get-hl :fg)
        bg (get-hl :bg)]
    {: fg : bg}))

;; Inactive
(local inactive-statusline {:condition (lambda []
                                         (if (conditions.is_active) false true))
                            1 border-left
                            2 space
                            3 file-info
                            4 align
                            5 ruler
                            6 space
                            7 border-right})

(fn inactive-statusline.hl [self]
  (let [fg (get-hl :fg)
        bg (get-hl :bg)]
    {: fg : bg}))

;; Terminal
(local terminal-statusline {:condition (lambda []
                                         (if (= vim.bo.filetype :toggleterm)
                                             true false))
                            1 border-left
                            2 space
                            3 terminal-name
                            4 align
                            5 border-right})

(fn terminal-statusline.hl [self]
  (let [fg (get-hl :fg)
        bg (get-hl :bg)]
    {: fg : bg}))

;;; Setup
(setup {:init utils.pick_child_on_condition
        1 terminal-statusline
        2 inactive-statusline
        3 default-statusline})
