;;; win.fnl - Utilities for manipulating Neovim windows
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: kbd-buf!} :core.macros)

(fn create-hidden-buffer []
  "Create a new hidden buffer and return its id"
  (let [buf (vim.api.nvim_create_buf false true)]
    ;; Buffer options
    (vim.api.nvim_buf_set_option buf :bufhidden :wipe)
    ;; Buffer keybinds
    (kbd-buf! [n] :q :<cmd>q<cr>)
    buf))

(fn create-float-win []
  "Create a new floating window with a hidden buffer and returns its window id and buffer"
  (let [buf (create-hidden-buffer)
        width (vim.api.nvim_get_option :columns)
        height (vim.api.nvim_get_option :lines)
        win-width (math.ceil (* width 0.4))
        win-height (math.ceil (- (* height 0.8) 3))
        col (math.ceil (/ (- width win-width) 2))
        row (math.ceil (- (- height win-height) 4))
        opts {:style :minimal
              :border :rounded
              :relative :win
              :width win-width
              :height win-height
              : col
              : row}]
    (local win (vim.api.nvim_open_win buf true opts))
    {: win : buf}))

(fn center-text [text-lines]
  "Align text to center"
  (local aligned-text {})
  (local win-width (vim.api.nvim_win_get_width 0))
  (each [_ line (ipairs text-lines)]
      (local padding-amount (- (math.floor (/ win-width 2)) (math.floor (/ (string.len line) 2))))
      (local padding (string.rep " " padding-amount))
      (table.insert aligned-text (.. padding line)))
  aligned-text)
  

{: create-float-win : center-text}

;;; win.fnl ends here
