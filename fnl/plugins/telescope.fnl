(module plugins.telescope)

(import-macros {: kbd!} :core.macros)

(local {: setup : load_extension} (require :telescope))
(local {:get_ivy ivy} (require :telescope.themes))

;;; Setup
;; Setup telescope with ivy theme
(setup {:defaults (ivy)
        :extensions {:project {:base_dirs ["~/.config/doom-nvim"
                                           "~/.config/nvim.fnl"
                                           "~/Development/Clang"
                                           "~/Development/Rust"
                                           "~/Development/Nvim"
                                           "~/Development/Misc"]}}})

;; Load extensions
(load_extension :project)
(load_extension :software-licenses)

;;; Keymaps
;; Find files
(kbd! [n] :<leader>f "<cmd>Telescope find_files<cr>")

;; Goto buffer
(kbd! [n] :<leader>gb "<cmd>Telescope buffers<cr>")

;; Goto project
(kbd! [n] :<leader>p
      "<cmd>lua require('telescope').extensions.project.project({ display_type = 'full' })<cr>")

;; Choose a license
(kbd! [n] :<leader>sl "<cmd>Telescope software-licenses find<cr>")
