;;; init-packages.el --- Package Management -*- lexical-binding: t; -*-

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(unless package--initialized
  (package-initialize))

;; Emacs 29 includes use-package.  Install dependencies together below, before
;; loading any configuration that uses them.
(require 'use-package)
(setq use-package-always-ensure nil)

(defconst my/required-packages
  '(ace-window clang-format company consult embark embark-consult
    exec-path-from-shell forge magit marginalia orderless org-roam
    paredit password-store prettier slime slime-company treesit-auto
    vertico which-key)
  "External packages used by this configuration.")

(defun my/install-packages ()
  "Install missing dependencies, contacting archives only when needed."
  (interactive)
  (let ((missing (seq-remove #'package-installed-p my/required-packages)))
    (when missing
      (condition-case err
          (progn
            (message "Installing missing Emacs packages: %s" missing)
            (package-refresh-contents)
            (dolist (package missing)
              (unless (package-installed-p package)
                (package-install package))))
        (error
         (error "Package setup failed: %s. Check network/archive access, then run M-x my/install-packages and restart Emacs"
                (error-message-string err)))))))

;; A fresh checkout needs no separate bootstrap command.  Once all required
;; packages are installed, startup does no package work.
(my/install-packages)

(provide 'init-packages)
