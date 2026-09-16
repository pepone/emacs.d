;;; init-vcs.el --- Version Control Setup -*- lexical-binding: t; -*-

(use-package magit
  :bind
  (("C-x g" . magit-status))
  :config
  (with-eval-after-load 'git-commit
    (add-hook 'git-commit-setup-hook #'git-commit-setup-flyspell)))

;; Forge for GitHub PR and Issue Integration
(use-package forge
  :after magit)

(provide 'init-vcs)
