(module plugins.telescope)

(local {: setup} (require :telescope))
(local {:get_ivy ivy} (require :telescope.themes))

(setup {:defaults (ivy)})
