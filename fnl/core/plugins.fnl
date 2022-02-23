;;; plugins.fnl - Neovim plugins
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(module core.plugins
  {autoload {packer packer}})

(import-macros {: cmd
                : nightly?
                : pack
                : unpack!
                : use-package!} :core.macros)

;;; Utilities
;; Neovim nightly checker
(local is-nightly (nightly?))

(local fennelview (require :core.fennelview))

;;; Packer setup
;; Load packer.nvim
(cmd "packadd packer.nvim")

;; Setup packer
(packer.init {:opt_default true
              :git {:clone_timeout 300}
              :display {:open_fn (lambda open_fn []
                                    (local {: float} (require :packer.util))
                                    (float {:border :single}))}
              :profile {:enable true}})

;;; Plugins declaration
;; Packer can manage itelf
(use-package! :wbthomason/packer.nvim)

;; Fennel compiler
(use-package! :Olical/aniseed)

;; Caching
(use-package! :lewis6991/impatient.nvim)

;; Colorscheme
(use-package! :NTBBloodbath/doom-one.nvim)

;; Comments
(use-package! :numToStr/Comment.nvim {:event :BufWinEnter
                                      :init! :Comment})

;; Tree-Sitter
(var rainbow-commit nil)
(if (not is-nightly)
  (set rainbow-commit "c6c26c4def0e9cd82f371ba677d6fc9baa0038af"))
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :config! :treesitter
               :requires [(pack :p00f/nvim-ts-rainbow {:commit rainbow-commit})
                          (pack :nvim-treesitter/playground {:cmd :TSPlayground})]})

;; Smart parentheses, thanks god for exist
(use-package! :ZhiyuanLck/smart-pairs
              {:event :InsertEnter
               :config "require('pairs'):setup()"})

;; Fancy icons!
(use-package! :kyazdani42/nvim-web-devicons
              {:module :nvim-web-devicons})

;; Indentation guides
(use-package! :lukas-reineke/indent-blankline.nvim
              {:config! :indentlines
               :event :BufWinEnter})

;; Tabline
(use-package! :akinsho/bufferline.nvim
              {:event :BufWinEnter
               :config! :bufferline})

;; Statusline
(use-package! :rebelot/heirline.nvim
              {:config! :statusline
               :requires [(pack :SmiteshP/nvim-gps
                                {:init! :nvim-gps
                                 :after :nvim-treesitter})]})

;; Git utilities
(use-package! :lewis6991/gitsigns.nvim
              {:event :ColorScheme
               :init! :gitsigns
               :requires [(pack :nvim-lua/plenary.nvim
                                {:module :plenary})]})

;; Because we all need to take notes
(use-package! :nvim-neorg/neorg
              {:after :nvim-treesitter
               :config! :neorg})

;; LSP
(use-package! :neovim/nvim-lspconfig
              {:opt false})

;; Initialize packer and pass each plugin to it
(unpack!)

;; Automatically install new plugins and compile changes
(cmd "PackerInstall")

;;; plugins.fnl ends here
