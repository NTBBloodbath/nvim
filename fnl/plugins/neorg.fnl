(local {: setup} (require :neorg))

;;; Setup Neorg
(setup {:load {:core.defaults {}
               :core.norg.concealer {}
               :core.norg.qol.toc {}
               :core.norg.dirman {:config {:workspaces {:main "~/neorg"}
                                           :autodetect true
                                           :autochdir true}}
               :core.norg.esupports.metagen {:config {:type :auto}}
               :core.export {}
               :core.export.markdown {:config {:extensions :all}}}})
