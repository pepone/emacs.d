;;; init-lisp.el --- Common Lisp Development Setup -*- lexical-binding: t; -*-

;; Paredit for structured editing
(use-package paredit
  :hook ((emacs-lisp-mode
          lisp-mode
          lisp-interaction-mode
          slime-repl-mode) . paredit-mode))

;; Company in the SLIME REPL (source buffers use the shared configuration).
(use-package company
  :hook (slime-repl-mode . company-mode))

;; SLIME setup
(use-package slime
  :config
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-fancy)))

;; SLIME-Company integration for smarter completion
(use-package slime-company
  :after (slime company)
  :config
  (setq slime-company-completion 'fuzzy)
  (add-to-list 'company-backends 'company-slime))

(provide 'init-lisp)
