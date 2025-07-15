;; extends

; ((weak_carryover_set
;    (weak_carryover
;      "_prefix" @conceal))
;  (#set! conceal ""))

((weak_carryover_set
   (weak_carryover
     . "_prefix" @start
     . name: (tag_name) @end))
 (#make-conceal! @start @end "#"))
 ; (#lua-match? @conceal "html%.class")
 ; (#set! conceal ""))
