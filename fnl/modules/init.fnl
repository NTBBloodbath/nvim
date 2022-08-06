;;; plugins.fnl - Neovim plugins
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(import-macros {: cmd : let! : pack : unpack! : use-package!} :core.macros)

;;; Utility lazy-loading functions
(lambda is-git-repo? []
  (= (vim.fn.isdirectory :.git) 1))

;;; Packer setup
;; Load packer.nvim
(cmd "packadd packer.nvim")

;; Setup packer
(local packer (require :packer))
(packer.init {:opt_default true
              :autoremove true
              :max_jobs 20
              :compile_path (.. (vim.fn.stdpath :config)
                                :/lua/packer_compiled.lua)
              :git {:clone_timeout 300 :default_url_format "git@github.com:%s"}
              :display {:open_fn (lambda []
                                   ((. (require :packer.util) :float) {:border :rounded}))}
              :profile {:enable true}})

;;; Plugins declaration
;; Packer can manage itself
(use-package! :wbthomason/packer.nvim)

;; Fennel compiler
(use-package! :udayvir-singh/tangerine.nvim)

;; Better Lisp editing
(use-package! :gpanders/nvim-parinfer {:ft [:fennel :scheme]})

;; Colorschemes
(use-package! :NTBBloodbath/doom-one.nvim)
(use-package! :NTBBloodbath/doombox.nvim)
(use-package! :folke/tokyonight.nvim)
(use-package! :aktersnurra/no-clown-fiesta.nvim)
(use-package! :Yazeed1s/minimal.nvim)
(use-package! :B4mbus/oxocarbon-lua.nvim)

;; Comments
(use-package! :numToStr/Comment.nvim {:keys [:n :gcc :v :gc] :init! :Comment})

;; Draw ASCII diagrams
(use-package! :jbyuki/venn.nvim {:cmd :VBox})

;; Preview markdown using Glow
(use-package! :ellisonleao/glow.nvim {:config! :editor.glow :cmd [:Glow]})

;; Tree-Sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :config! :editor.treesitter
               :requires [(pack :p00f/nvim-ts-rainbow)
                          (pack :nvim-treesitter/playground
                                {:cmd :TSPlaygroundToggle})]})

;; Smart parentheses, thanks god for exist
(use-package! :ZhiyuanLck/smart-pairs
              {:event :InsertEnter
               :config "require('pairs'):setup({pairs = {['*'] = {enable_smart_space = false}}})"})

;; Smart semicolons
(use-package! :iagotito/smart-semicolon.nvim
              {:ft [:c :cpp :zig :rust :javascript :typescript]})

;; Toggle booleans and operators (e.g. `true` => `false`)
(use-package! :rmagatti/alternate-toggler
              {:setup (lambda []
                        (let! :g.at_custom_alternates {:== "!=" :=== "!=="}))
               :cmd [:ToggleAlternate]})

;; Fancy icons!
(use-package! :kyazdani42/nvim-web-devicons {:module :nvim-web-devicons})

;; Indentation guides
(use-package! :lukas-reineke/indent-blankline.nvim
              {:event :BufRead :config! :ui.indentlines})

;; Color highlighter
(use-package! :xiyaowong/nvim-colorizer.lua
              {:event [:BufRead :BufNewFile] :config! :ui.colorizer})

;; Tabline
(use-package! :akinsho/bufferline.nvim
              {:event :BufEnter :config! :editor.bufferline})

;; Statusline
(use-package! :rebelot/heirline.nvim
              {:config! :ui.statusline :event [:BufRead :BufNewFile]})

;; Better built-in terminal
(use-package! :akinsho/toggleterm.nvim
              {:config! :tools.toggleterm
               :cmd [:ToggleTerm :TermExec]
               :module_pattern :toggleterm
               :keys [:n :<F4>]})

;; Smart ESC, ESC not gonna exit terminal mode again whenever I try to close htop!
(use-package! :sychen52/smart-term-esc.nvim
              {:config! :editor.term_esc :event :TermOpen})

;; Sudo in Neovim
(use-package! :lambdalisue/suda.vim {:cmd [:SudaRead :SudaWrite]})

;; Best file browser ever, now ported to Lua!
;; NOTE: I'm not using it right now so I'll disable it
(use-package! :X3eRo0/dired.nvim
              {:cmd :Dired
               :disable true
               :config! :editor.dired
               :requires [(pack :MunifTanjim/nui.nvim {:module_pattern :nui.*})]})

;; Do we have NNN? We gotta embed NNN.
(use-package! :luukvbaal/nnn.nvim
              {:cmd [:NnnExplorer :NnnPicker]
               :config! :tools.nnn
               :cond (lambda []
                       (= (vim.fn.executable :nnn) 1))})

;; Better buffers cycles
(use-package! :ghillb/cybu.nvim
              {:disable true
               :event :BufWinEnter
               :config! :editor.cybu
               :cmd [:CybuNext :CybuPrev]
               :keys [:n :K :n :J :n :<Tab> :n :<S-Tab>]})

;; Pastebins
(use-package! :rktjmp/paperplanes.nvim
              {:config "require('paperplanes').setup({provider = '0x0.st'})"
               :cmd :PP})

;; Make beauty comment boxes, mainly for license headers in my source code :)
(use-package! :LudoPinelli/comment-box.nvim
              {:cmd [:CBcatalog :CBaclbox :CBaccbox :CBlbox :CBclbox]})

;; Git utilities
(use-package! :lewis6991/gitsigns.nvim
              {:cond is-git-repo?
               :config! :ui.gitsigns
               :requires [(pack :nvim-lua/plenary.nvim {:module :plenary})]})

;; More than 3 years using Git and conflicts still confuses my brain
(use-package! :akinsho/git-conflict.nvim
              {:cond is-git-repo? :init! :git-conflict})

;; Magit? No, Neogit
(use-package! :TimUntersberger/neogit
              {:cmd :Neogit
               :cond is-git-repo?
               :config! :tools.neogit
               :keys [:n
                      :<leader>gs
                      :n
                      :<leader>gc
                      :n
                      :<leader>gl
                      :n
                      :<leader>gp
                      :n
                      :<F2>]})

(use-package! :olimorris/persisted.nvim
              {:opt false
               :config "require('persisted').setup({ autoload = true })"})

;; Because we all need to take notes
(use-package! :nvim-neorg/neorg
              {:after :nvim-treesitter :config! :editor.neorg})

;; Dim unused code through LSP and TS
(use-package! :zbirenbaum/neodim {:after :nvim-treesitter :init! :neodim})

;; LSP
(use-package! :neovim/nvim-lspconfig
              {:ft [:c :cpp :zig :lua :rust :elixir :javascript :typescript]
               :config! :lsp.lspconfig})

(use-package! :folke/lua-dev.nvim {:module :lua-dev})

(use-package! :p00f/clangd_extensions.nvim {:module :clangd_extensions})

(use-package! :ray-x/lsp_signature.nvim {:module :lsp_signature})

(use-package! :j-hui/fidget.nvim {:after :nvim-lspconfig :init! :fidget})

(use-package! :Maan2003/lsp_lines.nvim
              {:after :nvim-lspconfig :config "require('lsp_lines').setup()"})

;; Modern folds
(use-package! :kevinhwang91/nvim-ufo
              {:module :ufo
               :after :nvim-lspconfig
               :requires [(pack :kevinhwang91/promise-async {:module :promise})]})

;; Completion
(use-package! :hrsh7th/nvim-cmp
              {:config! :completion.cmp
               :wants [:LuaSnip]
               :requires [(pack :onsails/lspkind-nvim {:module :lspkind})
                          (pack :hrsh7th/cmp-nvim-lsp {:module :cmp_nvim_lsp})
                          (pack :hrsh7th/cmp-path)
                          (pack :hrsh7th/cmp-buffer)
                          ;; (pack :hrsh7th/cmp-cmdline)
                          (pack :saadparwaiz1/cmp_luasnip)
                          (pack :lukas-reineke/cmp-under-comparator
                                {:module :cmp-under-comparator})]
               :event [:InsertEnter]})

;; Snippets
(use-package! :L3MON4D3/LuaSnip
              {:event :InsertEnter
               :wants :friendly-snippets
               :config! :completion.luasnip
               :requires [(pack :rafamadriz/friendly-snippets {:opt false})]})

;; Discord presence
(use-package! :andweeb/presence.nvim
              {:config "require('presence'):setup({enable_line_number = true, main_image = 'file'})"
               :event [:BufRead :BufNewFile]})

;; Annotations
(use-package! :danymat/neogen {:config! :tools.neogen
                               :after :nvim-treesitter
                               :keys [:n :mm]})

;; Templates
(use-package! :NTBBloodbath/templar.nvim
              {:opt false :branch :refact/fields-syntax-fix-change})

;; Test framework
(use-package! :nvim-neotest/neotest
              {:ft [:python]
               :config! :editor.neotest
               :after :nvim-treesitter
               :requires [(pack :nvim-neotest/neotest-python
                                {:module :neotest-python})
                          (pack :antoinemadec/FixCursorHold.nvim
                                {:event :BufEnter})]})

;; Tasks runner
(use-package! :jedrzejboczar/toggletasks.nvim
              {:init! :toggletasks
               :module :telescope._extensions.toggletasks
               :event :BufWinEnter})

;; Lua and Libuv documentation
(use-package! :milisims/nvim-luaref {:opt false})

(use-package! :nanotee/luv-vimdocs {:opt false})

;; Editorconfig support
(use-package! :gpanders/editorconfig.nvim {:event :BufRead})

;; Fuzzy everywhere and every time
(use-package! :nvim-lua/telescope.nvim
              {:config! :tools.telescope
               :cmd :Telescope
               :keys [:n :<F3> :n :<leader>f :n :<leader>gb :n :<leader>p :n :<leader>sl]
               :requires [(pack :nvim-telescope/telescope-project.nvim
                                {:module :telescope._extensions.project})
                          (pack :chip/telescope-software-licenses.nvim
                                {:module :telescope._extensions.software-licenses})]})

;; Separate cut from delete registers
(use-package! :gbprod/cutlass.nvim
              {:config "require('cutlass').setup({cut_key = 'x'})"
               :event :BufEnter})

;; Prevent the cursor from moving when using shift and filter actions
(use-package! :gbprod/stay-in-place.nvim
              {:config! :editor.stay_in_place :event :BufEnter})

;; Scope buffers to tabs
(use-package! :tiagovla/scope.nvim {:init! :scope :event :BufWinEnter})

;; Initialize packer and pass each plugin to it
(unpack!)

;; Automatically install new plugins (or install all on first launch and compile changes)
(if (= (vim.fn.filereadable (.. (vim.fn.stdpath :config)
                                :/lua/packer_compiled.lua)) 1)
    (cmd :PackerInstall)
    (cmd :PackerSync))

;;; plugins.fnl ends here
