;;; plugins.fnl - Neovim plugins
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd
                : nightly?
                : pack
                : unpack!
                : use-package!} :core.macros)

;; Neovim nightly checker
(local is-nightly (nightly?))

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
(use-package! :numToStr/Comment.nvim {:event :BufWinEnter
                                      :init! :Comment})

;; Tree-Sitter
(var rainbow-commit nil)
(if (not is-nightly)
  (set rainbow-commit "c6c26c4def0e9cd82f371ba677d6fc9baa0038af"))
(use-package! :nvim-treesitter/nvim-treesitter
              {:opt true
               :run ":TSUpdate"
               :config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow {:commit rainbow-commit})
                          (pack :nvim-treesitter/playground {:cmd :TSPlayground})]})

;; Smart parentheses, thanks god for exist
(use-package! :ZhiyuanLck/smart-pairs
              {:event :InsertEnter
               :init! :pairs})

;; Statusline
(use-package! :rebelot/heirline.nvim
              {:opt true
               :config! :statusline
               :requires [(pack :kyazdani42/nvim-web-devicons
                                {:module :nvim-web-devicons})
                          (pack :SmiteshP/nvim-gps
                                {:init! :nvim-gps
                                 :after :nvim-treesitter})]})

;; Git utilities
(use-package! :lewis6991/gitsigns.nvim
              {:event :BufWinEnter
               :init! :gitsigns
               :requires [(pack :nvim-lua/plenary.nvim
                                {:module :plenary})]})

;; Because we all need to take notes
(use-package! :nvim-neorg/neorg
              {:after :nvim-treesitter
               :config! :neorg})

;; Initialize packer and pass each plugin to it
(unpack!)

;; Automatically install new plugins and compile changes
(cmd "PackerInstall")

;;; plugins.fnl ends here
