;;; init-org.el --- Org-mode and Org-Roam Setup -*- lexical-binding: t; -*-

(use-package org-roam
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
         ("C-c n j" . org-roam-dailies-capture-today)))

(provide 'init-org)
