; Fold blocks
[
 (if)
 (do)
 (fn)
 (def)
 (parameters)
 (tuple)
] @fold

; Fold entire function declaration
(extra_defs) @fold

; Fold parameters (when there are many of them)
; Fold function body
(extra_defs
  (parameters) @fold
  (body) @fold)
