(import-macros {: set! : lazy-require!} :core.macros)

(local {: setup : is_available : get_location} (require :nvim-navic))
(local {: get_icon_by_filetype} (lazy-require! :nvim-web-devicons))

;; Setup navic
(setup {:highlight true :separator " > "})

(lambda get-context []
  (when is_available
    (local location (get_location))
    (if (= location "") "%#NavicText#…%*" location)))

(lambda get-buf-metadata []
  (let [bufnr 0
        path (vim.api.nvim_buf_get_name bufnr)
        (icon highlight) (get_icon_by_filetype vim.bo.filetype)]
    (var dirname (.. (vim.fn.fnamemodify path ":~:.:h") "/"))
    (if (and (not (= dirname "//")) (= (string.sub dirname 1 1) "/"))
        (set dirname (.. "/" dirname))
        (= dirname "./")
        (set dirname ""))
    ;; (var dirname (string.gsub dirname "/$" ""))
    (local filename (vim.fn.fnamemodify path ":t"))
    {: filename : dirname : icon : highlight}))

(fn get-info []
  (var winbar nil)
  (let [context (get-context)
        {: filename : dirname : icon : highlight} (get-buf-metadata)]
    (when (not (= filename ""))
      (set winbar
           (string.format " %%#%s#%s %%#NavicText#%s%%*%%#NavicText#%s%%*"
                          highlight icon dirname filename))
      (when (not (= context nil))
        (set winbar
             (.. winbar (string.format "%%#NavicSeparator# > %%*%s" context)))))
    winbar))

;; Set winbar
(set! winbar "%{%v:lua.require('modules.ui.winbar').get_info()%}")

{:get_info get-info}
