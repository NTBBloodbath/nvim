(module plugins.lspconfig {autoload {lsp lspconfig}})

;;; Diagnostics configuration
(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           :virtual_text false
           :update_in_insert true
           :severity_sort true
           :float {:show_header false :border :single}})
  (sign_define :DiagnosticSignError {:text "" :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn {:text "" :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo {:text "" :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint {:text "" :texthl :DiagnosticSignHint}))

;;; Improve UI
(let [{: with : handlers} vim.lsp]
  (set vim.lsp.handlers.textDocument/signatureHelp
       (with handlers.signature_help {:border :single}))
  (set vim.lsp.handlers.textDocument/hover
       (with handlers.hover {:border :single})))

;;; On attach
(fn on-attach [client bufnr]
  (import-macros {: cmd : set-local! : kbd-buf! : augroup-buf! : au!}
                 :core.macros)
  (local {:document_formatting has-formatting?
          :document_range_formatting has-range-formatting?}
         client.resolved_capabilities)
  (local {:formatting_seq_sync format-seq-sync!
          :hover open-float-doc!
          :definition goto-definition!
          :declaration goto-declaration!
          :rename rename!
          :type_definition goto-type-definition!
          :code_action open-float-actions!} vim.lsp.buf)
  (local {:open_float open-float-diag!
          :goto_prev goto-prev-diag!
          :goto_next goto-next-diag!} vim.diagnostic)
  ;;; Signature
  (let [signature (require :lsp_signature)]
    (signature.on_attach {:bind true
                          :fix_pos true
                          :floating_window_above_cur_line true
                          :doc_lines 0
                          :hint_enable false
                          :hint_prefix "● "
                          :hint_scheme :DiagnossticSignInfo}
                         bufnr))
  ;; Enable omnifunc-completion
  (set-local! omnifunc "v:lua.vim.lsp.omnifunc")
  ;;; Keybinds
  ;; Show documentation
  (kbd-buf! [n] :K open-float-doc!)
  ;; Open code actions
  (kbd-buf! [n] :<leader>a open-float-actions!)
  ;; Rename symbol under cursor
  (kbd-buf! [n] :<leader>r rename!)
  ;; Show line diagnostics
  (kbd-buf! [n] :<leader>d open-float-diag!)
  ;; Go to diagnostics
  (kbd-buf! [n] "<leader>[d" goto-prev-diag!)
  (kbd-buf! [n] "<leader>]d" goto-next-diag!)
  ;; Go to definition
  (kbd-buf! [n] :<leader>gd goto-definition!)
  ;; Go to declaration
  (kbd-buf! [n] :<leader>gD goto-declaration!)
  ;;; Autocommands
  ;; Display line diagnostics on hover
  (augroup-buf! lsp-display-diagnostics
                (au! [:CursorHold :CursorHoldI] ["*"]
                     "lua vim.diagnostic.open_float()"))
  ;;; Commands
  ;; TODO: create a commands macro
  (vim.api.nvim_add_user_command :Format vim.lsp.buf.formatting {}))

;;; Capabilities
(local capabilities
       (let [{: make_client_capabilities} vim.lsp.protocol
             {: update_capabilities} (require :cmp_nvim_lsp)]
         (update_capabilities (make_client_capabilities))))

;;; Setup servers
(local defaults {:on_attach on-attach
                 : capabilities
                 : handlers
                 :flags {:debounce_text_changes 150}})

;; C/C++
(lsp.clangd.setup defaults)

;; Rust
(lsp.rust_analyzer.setup defaults)

;; Lua
(let [lua-dev (require :lua-dev)]
  (local lua-dev-config
         (lua-dev.setup {:library {:vimruntime true :types true :plugins false}
                         :lspconfig {:settings {:Lua {:workspace {:preloadFileSize 500}}}}}))
  (lsp.sumneko_lua.setup lua-dev-config))
