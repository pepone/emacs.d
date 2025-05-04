;;; init-editing.el --- Editing Behavior Enhancements -*- lexical-binding: t; -*-

;; Recent files
(use-package recentf
  :init
  (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 200
        recentf-auto-cleanup 'never))

(provide 'init-editing)
