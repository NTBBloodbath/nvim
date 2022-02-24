;;; macros.fnl - Fennel macros
;;
;; Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
;; URL:     https://github.com/NTBBloodbath/nvim.fnl
;; License: GPLv3
;;
;;; Code:

(local {: format : gmatch : gsub} string)
(local {: insert : concat} table)
;; (local fennelview (require :utils.fennelview))

;; Packer plugins
(global pkgs [])

(fn ->str [x]
  "Convert given parameter into a string"
  (tostring x))

(fn head [xs]
  "Get the first element in a list"
  (. xs 1))

(fn str? [x]
  "Check if given parameter is a string"
  (= :string (type x)))

(fn num? [x]
  "Check if given parameter is a number"
  (= :number (type x)))

(fn tbl? [x]
  "Check if given parameter is a table"
  (= :table (type x)))

(fn nil? [x]
  "Check if given parameter is nil"
  (= :nil x))

(fn empty? [xs]
  "Check if given table is empty"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (= 0 (length xs)))

(fn includes? [xs x]
  "Check if given parameter exists in given list"
  (accumulate [is? false _ v (ipairs xs) :until is?]
    (= v x)))

(fn head [xs]
  "Get the first element in a list"
  (assert-compile (tbl? xs) "expected table for xs" xs)
  (. xs 1))

(fn fn? [x]
  "Check if given parameter is a function"
  (and (list? x) (or (= `fn (head x)) (= `hashfn (head x)))))

(fn cmd [command]
  "Execute a Neovim command using the Lua API"
  `(vim.api.nvim_command ,command))

(fn nightly? []
  "Check if using Neovim nightly (0.7)"
  (let [nightly (vim.fn.has :nvim-0.7.0)]
    (= nightly 1)))

(lambda set! [name value]
  "Set a Neovim option using the Lua API"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    `(tset vim.opt ,name ,value)))

(fn set!-mult [...]
  "Set one or multiple vim options using the lua API"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      (where [name value & rest] (not (sym? value)))
      [(set! name value) (unpack (aux (unpack rest)))]
      _ []))

  (let [exprs (aux ...)]
    (if (> (length exprs) 1)
        `(do
           ,(unpack exprs))
        (unpack exprs))))

(fn set-local! [name value]
  " Set a Neovim option (local to buffer) using the Lua API"
  (assert-compile (sym? name) "expected symbol for name" name)
  (let [name (->str name)]
    `(tset vim.opt_local ,name ,value)))

(lambda let! [name value]
  "Set a Neovim variable using the Lua API"
  (assert-compile (or (sym? name) (str? name))
                  "expected symbol or string for name" name)
  (let [name (->str name)
        scope (when (includes? [:g. :b. :w. :t. "g:" "b:" "w:" "t:"]
                               (name:sub 1 2))
                (name:sub 1 1))
        name (name:sub 3)]
    `(tset ,(match scope
              :g `vim.g
              :b `vim.b
              :w `vim.w
              :t `vim.t) ,name ,value)))

(fn let!-mult [...]
  "Set one or multiple Neovim variables using the Lua API"
  (fn aux [...]
    (match [...]
      (where [& rest] (empty? rest)) []
      [name value & rest] [(let! name value) (unpack (aux (unpack rest)))]
      _ []))

  (let [exprs (aux ...)]
    (if (> (length exprs) 1)
        `(do
           ,(unpack exprs))
        (unpack exprs))))

(fn kbd! [[modes & options] lhs rhs ?desc]
  "Defines a new mapping using the Lua API"
  (assert-compile (or (sym? modes) (tbl? modes))
                  "expected symbol or table for modes" modes)
  (assert-compile (tbl? options) "expected table for options" options)
  (assert-compile (str? lhs) "expected string for lhs" lhs)
  (assert-compile (or (str? rhs) (list? rhs) (fn? rhs) (sym? rhs))
                  "expected string or list or function or symbol for rhs" rhs)
  (assert-compile (or (not (nil? ?desc)) (str? ?desc))
                  "expected string or nil for description" ?desc)
  (let [modes (icollect [char (gmatch (->str modes) ".")]
                char)
        options (collect [_ v (ipairs options)]
                  (->str v)
                  true)
        rhs (if (and (not (fn? rhs)) (list? rhs)) `#,rhs rhs)
        desc (if (and (not ?desc) (or (fn? rhs) (sym? rhs))) (view rhs) ?desc)
        options (if desc (doto options (tset :desc desc)) options)
        is-nightly (nightly?)]
    (if (= true is-nightly)
        `(vim.keymap.set ,modes ,lhs ,rhs ,options)
        `(vim.api.nvim_set_keymap ,(head modes) ,lhs ,rhs ,options))))

(fn kbd-buf! [[modes & options] lhs rhs ?desc]
  "Defines a new buffer mapping using the Lua API"
  (let [options (doto options
                  (insert :buffer))]
    (kbd! [modes (unpack options)] lhs rhs ?desc)))

(fn augroup! [name ...]
  "Define a new augroup"
  `(do
     (vim.api.nvim_command ,(format "augroup %s" name))
     (vim.api.nvim_command :au!)
     (do
       ,...)
     (vim.api.nvim_command "augroup END")))

(fn augroup-buf! [name ...]
  "Define a buffer-local autocommand group using the Vim API"
  `(do
     (cmd ,(format "augroup %s" name))
     (cmd "au! * <buffer>")
     (do
       ,...)
     (cmd "augroup END")))

(fn au! [events patterns rhs]
  "Define an autocommand"
  (let [events (concat events ",")
        patterns (concat patterns ",")
        command (concat ["au " events " " patterns " " rhs])]
    `(vim.api.nvim_command ,command)))

(fn au-nested! [events patterns rhs]
  "Define an autocommand"
  (let [events (concat events ",")
        patterns (concat patterns ",")
        command (concat ["au " events " " patterns " ++nested " rhs])]
    `(vim.api.nvim_command ,command)))

(lambda pack [identifier ?options]
  "Return a mixed table with the identifier as the first sequential element
  and options as hash-table items"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options))
                  "expected nil or table for options" ?options)
  (let [options (or ?options {})
        options (collect [k v (pairs options)]
                  (if (= k :config!)
                      (values :config (format "require('plugins.%s')" v))
                      (= k :init!)
                      (values :config (format "require('%s').setup()" v))
                      (values k v)))]
    (doto options
      (tset 1 identifier))))

(fn use-package! [identifier ?options]
  "Declares a plugin with its options. Saved on the global compile-time variable pkgs"
  (assert-compile (str? identifier) "expected string for identifier" identifier)
  (assert-compile (or (not (nil? ?options)) (tbl? ?options))
                  "expected nil or table for options" ?options)
  (insert pkgs (pack identifier ?options)))

(fn unpack! []
  "Initializes packer with the previously declared plugins"
  (let [packages (icollect [_ v (ipairs pkgs)]
                   `(use ,v))]
    `((. (require :packer) :startup) #(do
                                        ,(unpack (icollect [_ v (ipairs packages)]
                                                   v))))))

{: ->str
 : kbd!
 : kbd-buf!
 : au!
 : au-nested!
 : augroup!
 : augroup-buf!
 : nil?
 : nightly?
 : cmd
 : pack
 : use-package!
 : unpack!
 : set-local!
 :set! set!-mult
 :let! let!-mult}

;;; macros.fnl ends here
