;;; colors.fnl - Colors utilities
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(fn get-rgb [color]
  (let [red (tonumber (color:sub 2 3) 16)
        grn (tonumber (color:sub 4 5) 16)
        blu (tonumber (color:sub 6 7) 16)]
    [red grn blu]))

(fn blend-colors [top bottom alpha]
  (let [top-rgb (get-rgb top)
        bottom-rgb (get-rgb bottom)
        blend (fn [c]
                (set-forcibly! c
                               (+ (* alpha (. top-rgb c))
                                  (* (- 1 alpha) (. bottom-rgb c))))
                (math.floor (+ (math.min (math.max 0 c) 255) 0.5)))]
    (string.format "#%02X%02X%02X" (blend 1) (blend 2) (blend 3))))

{: blend-colors}

;;; colors.fnl ends here
