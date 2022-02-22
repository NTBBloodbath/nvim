(module core.init)
  ; {autoload {plugin core.plugin
  ;            nvim aniseed.nvim}})

;;; Sane defaults
(require :core.config)

;;; Keybindings
(require :core.maps)

;;; Plugins
(require :core.plugins)
