;;; init-lisp.el --- Common Lisp Development Setup -*- lexical-binding: t; -*-

;; Paredit for structured editing
(use-package paredit
  :hook ((emacs-lisp-mode
          lisp-mode
          lisp-interaction-mode
          slime-repl-mode) . paredit-mode))

;; Company for autocompletion
(use-package company
  :hook ((prog-mode . company-mode)
         (slime-repl-mode . company-mode))
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t))

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
