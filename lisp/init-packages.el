;;; init-packages.el --- Package Management -*- lexical-binding: t; -*-

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(unless package--initialized
  (package-initialize))

;; Emacs 29 includes use-package.  Startup only loads installed packages;
;; run M-x my/install-packages explicitly to bootstrap a new installation.
(require 'use-package)
(setq use-package-always-ensure nil)

(defconst my/required-packages
  '(ace-window clang-format company consult embark embark-consult
    exec-path-from-shell forge magit marginalia orderless org-roam
    paredit password-store prettier slime slime-company treesit-auto
    vertico which-key)
  "External packages used by this configuration.")

(defun my/install-packages ()
  "Refresh package metadata and install missing configuration dependencies."
  (interactive)
  (package-refresh-contents)
  (dolist (package my/required-packages)
    (unless (package-installed-p package)
      (package-install package))))

(provide 'init-packages)
