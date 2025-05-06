;;; init-completion.el --- Completion and Search -*- lexical-binding: t; -*-

;; Vertico
(use-package vertico
  :init
  (vertico-mode))

;; Path selection
(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)))

;; Orderless
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia
(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

;; Consult
(use-package consult
  :custom
  (consult-preview-key nil)
  :bind
  (("C-x b" . consult-buffer)
   ("M-l"   . consult-git-grep)
   ("M-y"   . consult-yank-pop)
   ("C-s"   . consult-line)
   ("C-c j" . consult-git-grep)
   ("C-c k" . consult-ripgrep)
   ("C-c r" . consult-recent-file)))

;; Embark
(use-package embark
  :bind
  (("C-."   . embark-act)
   ("C-;"   . embark-dwim)
   ("C-h B" . embark-bindings))
  :config
  (setq embark-prompter 'embark-completing-read-prompter))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . embark-consult-preview-minor-mode))

;; Savehist
(use-package savehist
  :init
  (savehist-mode))

;; Emacs built-in minibuffer settings
(use-package emacs
  :custom
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt)))

(provide 'init-completion)
