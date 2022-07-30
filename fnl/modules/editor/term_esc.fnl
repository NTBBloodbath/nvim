(local {: setup} (require :smart-term-esc))

(setup {:key :<Esc>
        :except [:nvim :emacs :fzf :zf :htop]})
