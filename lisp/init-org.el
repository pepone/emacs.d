;;; init-org.el --- Org-mode and Org-Roam Setup -*- lexical-binding: t; -*-

(defun my/org-roam-enable-for-notes ()
  "Load Org-roam when visiting a file in its notes directory."
  (when (and buffer-file-name
             (boundp 'org-roam-directory)
             (file-in-directory-p buffer-file-name org-roam-directory))
    (require 'org-roam)))

(use-package org-roam
  :hook (org-mode . my/org-roam-enable-for-notes)
  :custom
  (org-roam-directory (file-truename "~/knowledge"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n o" . org-id-get-create)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n a" . org-roam-alias-add)
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode 1))

;; Match the mixed-font theme: prose wraps visually; code retains fixed pitch.
(defun my/prose-setup ()
  "Use proportional fonts and visual wrapping for prose."
  (variable-pitch-mode 1)
  (visual-line-mode 1))
(add-hook 'org-mode-hook #'my/prose-setup)
(add-hook 'markdown-mode-hook #'my/prose-setup)

(provide 'init-org)
