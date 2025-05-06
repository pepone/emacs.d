;;; init-vcs.el --- Version Control Setup -*- lexical-binding: t; -*-

(use-package magit
  :bind
  (("C-x g" . magit-status))
  :config
  (setq git-commit-setup-hook '(git-commit-turn-on-flyspell)))

;; Forge for GitHub PR and Issue Integration
(use-package forge
  :after magit)

(provide 'init-vcs)
