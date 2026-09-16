;;; init-javascript.el --- JavaScript/TypeScript Setup -*- lexical-binding: t; -*-

;; Eglot for LSP
;; Requires to install typescript language server
;; npm install -g typescript-language-server typescript
;; npm install -g vscode-langservers-extracted # for eslint-language-server etc.

;; init-treesit owns grammar installation and major-mode remapping.

;; LSP via Eglot
(use-package eglot
  :ensure nil
  :hook ((js-ts-mode typescript-ts-mode tsx-ts-mode) . eglot-ensure))

;; Prettier for formatting
(use-package prettier
  :hook ((js-ts-mode typescript-ts-mode tsx-ts-mode) . prettier-mode))

(provide 'init-javascript)
