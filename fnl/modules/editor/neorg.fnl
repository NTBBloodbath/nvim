(local {: setup} (require :neorg))

;;; Setup Neorg
(setup {:load {:core.defaults {}
               :core.norg.concealer {:config {:markup_preset :conceal
                                              :icon_preset :diamond
                                              :icons {:heading {:enabled true
                                                                :level_1 {:icon "◈"}
                                                                :level_2 {:icon " ◇"}
                                                                :level_3 {:icon "  ◆"}
                                                                :level_4 {:icon "   ❖"}
                                                                :level_5 {:icon "    ⟡"}
                                                                :level_6 {:icon "     ⋄"}}}}}
               :core.norg.qol.toc {}
               :core.norg.dirman {:config {:workspaces {:main "~/neorg"}
                                           :autodetect true
                                           :autochdir true}}
               :core.norg.esupports.metagen {:config {:type :auto}}
               :core.export {}
               :core.export.markdown {:config {:extensions :all}}}})
