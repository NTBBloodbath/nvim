;;; ui.fnl - UI Configurations
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : let!} :core.macros)

(lambda is-installed [name]
  """Check if a colorscheme is installed"""
  (let [path (string.format "%s/packer/opt/%s"
                            (.. (vim.fn.stdpath :data) :/site/pack) name)]
    (= (vim.fn.isdirectory path) 1)))

(local wanted-colorscheme vim.g.colorscheme)

;; Load colorschemes and set the default one
(when (is-installed :doom-one.nvim)
  (cmd "packadd doom-one.nvim"))

(when (is-installed :doombox.nvim)
  (cmd "packadd doombox.nvim"))

(when (is-installed :tokyonight.nvim)
  (cmd "packadd tokyonight.nvim")
  ;; configs
  (let! :g.tokyonight_style :night)
  (let! :g.tokyonight_italic_comments false)
  (let! :g.tokyonight_italic_keywords false))

(when (is-installed :no-clown-fiesta.nvim)
  (cmd "packadd no-clown-fiesta.nvim"))

(when (is-installed :minimal.nvim)
  (cmd "packadd minimal.nvim"))

(cmd (.. "colorscheme " wanted-colorscheme))

;;; ui.fnl ends here
