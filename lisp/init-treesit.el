;;; init-treesit.el --- Tree-sitter integration -*- lexical-binding: t; -*-

;; Ensure treesit-auto is installed and active
(use-package treesit-auto
  :custom
  (treesit-auto-install 'always)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(provide 'init-treesit)
