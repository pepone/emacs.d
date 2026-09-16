;;; init-editing.el --- Editing Behavior Enhancements -*- lexical-binding: t; -*-

;; Recent files
(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 200
        recentf-auto-cleanup 'never))

;; Keep recovery files out of source trees, including version-controlled ones.
(let ((backup-directory (expand-file-name "backups/" user-emacs-directory))
      (auto-save-directory (expand-file-name "auto-saves/" user-emacs-directory)))
  (make-directory backup-directory t)
  (make-directory auto-save-directory t)
  (setq backup-directory-alist `(("." . ,backup-directory))
        auto-save-file-name-transforms `((".*" ,auto-save-directory t))
        auto-save-list-file-prefix (expand-file-name ".saves-" auto-save-directory)))
(setq backup-by-copying t
      version-control t
      kept-new-versions 6
      kept-old-versions 2
      delete-old-versions t
      vc-make-backup-files t)

;; Refresh unmodified buffers after external edits or Git operations.
(use-package autorevert
  :ensure nil
  :custom
  (auto-revert-verbose nil)
  :config
  (global-auto-revert-mode 1))

(provide 'init-editing)
