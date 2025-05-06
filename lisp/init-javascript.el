;;; init-javascript.el --- JavaScript/TypeScript Setup -*- lexical-binding: t; -*-

;; Eglot for LSP
;; Requires to install typescript language server
;; npm install -g typescript-language-server typescript
;; npm install -g vscode-langservers-extracted # for eslint-language-server etc.

;; Use Tree-sitter modes
(setq major-mode-remap-alist
      '((js-mode          . js-ts-mode)
        (js-json-mode     . json-ts-mode)
        (typescript-mode  . typescript-ts-mode)
        (tsx-mode         . tsx-ts-mode)))

;; LSP via Eglot
(use-package eglot
  :hook ((js-ts-mode typescript-ts-mode tsx-ts-mode) . eglot-ensure))

;; Prettier for formatting
(use-package prettier
  :hook ((js-ts-mode typescript-ts-mode tsx-ts-mode) . prettier-mode))

;; Treesit-auto to manage grammars (optional but nice)
(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

(provide 'init-javascript)
