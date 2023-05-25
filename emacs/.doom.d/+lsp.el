;;; +lsp.el -*- lexical-binding: t; -*-

(after! lsp-mode
  (setq lsp-signature-auto-activate '(:on-trigger-char :on-server-request :after-completion)
        ;; lsp-signature-doc-lines 5
        )

  ;; Rust
  (setq lsp-rust-analyzer-server-display-inlay-hints t
        lsp-rust-analyzer-display-parameter-hints t
        lsp-rust-analyzer-display-chaining-hints t
        lsp-rust-analyzer-binding-mode-hints t
        lsp-rust-analyzer-display-reborrow-hints "always"
        lsp-rust-analyzer-display-lifetime-elision-hints-enable "always" ;; "never", "skip_trivial"
        lsp-rust-analyzer-display-closure-return-type-hints t
        ;; lsp-rust-analyzer-cargo-watch-command "clippy"
        ;; lsp-rust-analyzer-hide-named-constructor t
        ;; lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names
        ;; lsp-rust-analyzer-hide-closure-initialization
        ;; lsp-rust-analyzer-closing-brace-hints
        ;; lsp-rust-analyzer-call-info-full
        ;; lsp-rust-analyzer-inlay-hints-mode
        )

  ;; JS / Typescript
  (setq lsp-javascript-display-parameter-name-hints "all" ;; "none", "literals"
        lsp-javascript-display-inlay-hints t
        lsp-javascript-display-property-declaration-type-hints t
        lsp-javascript-display-variable-type-hints t
        lsp-javascript-display-enum-member-value-hints t
        lsp-javascript-display-return-type-hints t
        lsp-javascript-references-code-lens-enabled t
        lsp-javascript-display-parameter-type-hints t
        ;; lsp-javascript-suggest-complete-function-calls
        ;; lsp-javascript-update-imports-on-file-move-enabled
        ;; lsp-javascript-display-parameter-name-hints-when-argument-matches-name
        ;; lsp-javascript-inlay-hints-mode
        ;; lsp-typescript-tsserver-trace
        ;; lsp-typescript-update-imports-on-file-move-enabled
        ;; lsp-typescript-suggest-complete-function-calls
        ;; lsp-typescript-implementations-code-lens-enabled
        ;; lsp-typescript-references-code-lens-enabled
        lsp-typescript-surveys-enabled nil
        lsp-typescript-disable-automatic-type-acquisition t))

(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        ;; lsp-ui-sideline-show-symbol nil
        ;; lsp-ui-sideline-show-diagnostics nil
        ;; lsp-ui-sideline-show-hover nil
        ;; lsp-ui-sideline-show-code-actions nil
        )

  (setq lsp-enable-symbol-highlighting t
        lsp-ui-doc-enable t
        lsp-lens-enable t
        lsp-ui-sideline-enable t
        lsp-modeline-code-actions-enable t
        )

  ;; (setq lsp-ui-doc-enable t
  ;;       lsp-ui-doc-show-with-cursor t
  ;;       lsp-ui-doc-show-with-mouse t
  ;;       lsp-ui-doc-delay 0.75
  ;;       lsp-ui-doc-alignment frame ;; window
  ;;       lsp-ui-doc-position at-point ;; top, bottom
  ;;       lsp-ui-doc-max-height 8
  ;;       lsp-ui-doc-max-width 72
  ;;       lsp-ui-doc-header t
  ;;       lsp-ui-doc-border "white"
  ;;       lsp-ui-doc-include-signature t
  ;;       lsp-ui-doc-text-scale-level 0
  ;;       lsp-ui-doc-use-webkit t
  ;;       lsp-ui-doc-webkit-max-width-px 600)

  (setq lsp-ui-peek-enable t
        lsp-ui-peek-show-directory t
        ;; lsp-ui-peek-always-show t
        ;; lsp-ui-peek-list-width
        ;; lsp-ui-peek-peek-height
        ))
