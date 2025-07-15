;; extends

((weak_carryover_set
   (weak_carryover
     "_prefix" @prefix
     name: (tag_name) @name))
 (#match? @name "html.class")
 (#set! @prefix conceal "")
 (#set! @name conceal ""))
