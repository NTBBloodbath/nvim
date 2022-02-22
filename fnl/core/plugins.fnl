;;; plugins.fnl - Neovim plugins
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd
                : pack
                : unpack!
                : use-package!} :core.macros)

;; Load packer.nvim
(cmd "packadd packer.nvim")

;; Packer can manage itelf
(use-package! :wbthomason/packer.nvim
             {:opt true})

;; Fennel compiler
(use-package! :Olical/aniseed
             {:opt true})

;; Colorscheme
(use-package! :NTBBloodbath/doom-one.nvim
             {:opt true})

;; Comments
(use-package! :numToStr/Comment.nvim {:init! :Comment})

;; Tree-Sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:opt true
               :run ":TSUpdate"
               :config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow)
                          (pack :nvim-treesitter/playground {:cmd :TSPlayground})]})

;; Smart parentheses, thanks god for exist
(use-package! :ZhiyuanLck/smart-pairs
              {:disable true
               :event :BufWinEnter
               :init! :pairs})

;; Statusline
(use-package! :rebelot/heirline.nvim
              {:opt true
               :config! :statusline
               :requires [(pack :kyazdani42/nvim-web-devicons
                                {:module :nvim-web-devicons})]})

;; Git utilities
(use-package! :lewis6991/gitsigns.nvim
              {:event :BufWinEnter
               :init! :gitsigns
               :requires [(pack :nvim-lua/plenary.nvim
                                {:module :plenary})]})

;; Initialize packer and pass each plugin to it
(unpack!)

;; Automatically install new plugins and compile changes
(cmd "PackerInstall")

;;; plugins.fnl ends here
