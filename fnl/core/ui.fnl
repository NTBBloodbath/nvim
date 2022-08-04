;;; ui.fnl - UI Configurations
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : let!} :core.macros)

(lambda is-installed [name]
  (let [path (string.format "%s/packer/opt/%s"
                            (.. (vim.fn.stdpath :data) :/site/pack) name)]
    (= (vim.fn.isdirectory path) 1)))

(local wanted-colorscheme vim.g.colorscheme)

;; Load colorschemes and set the default one
(when (and (is-installed :doom-one.nvim) (= wanted-colorscheme :doom-one))
  (cmd "packadd doom-one.nvim"))

(when (and (is-installed :doombox.nvim) (= wanted-colorscheme :doombox))
  (cmd "packadd doombox.nvim"))

(when (and (is-installed :tokyonight.nvim) (= wanted-colorscheme :tokyonight))
  (cmd "packadd tokyonight.nvim")
  ;; configs
  (let! :g.tokyonight_style :night)
  (let! :g.tokyonight_italic_comments false)
  (let! :g.tokyonight_italic_keywords false))

(when (and (is-installed :no-clown-fiesta.nvim)
           (= wanted-colorscheme :no-clown-fiesta))
  (cmd "packadd no-clown-fiesta.nvim"))

(when (and (is-installed :minimal.nvim)
           (or (= wanted-colorscheme :minimal)
               (= wanted-colorscheme :minimal-base16)))
  (cmd "packadd minimal.nvim"))

(cmd (.. "colorscheme " wanted-colorscheme))

;; Some doom-one tweaks, maybe I'll upstream them later
(when (= wanted-colorscheme :doom-one)
  (cmd "hi! link markdownCode Comment")
  (cmd "hi! link markdownCodeBlock markdownCode")
  (cmd "hi LspSignatureActiveParameter guifg=#a9a1e1")
  (cmd "hi! link DiffAdd DiffAddedGutter")
  (cmd "hi! link DiffChange DiffModifiedGutter")
  (cmd "hi! link DiggDelete DiffRemovedGutter"))

;;; ui.fnl ends here
