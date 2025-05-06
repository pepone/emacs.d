;;; init-auth.el --- Authentication and Password Management -*- lexical-binding: t; -*-

;; Use pass as auth source
(use-package auth-source-pass
  :init
  (auth-source-pass-enable))

;; Manual password management via pass
(use-package password-store
  :after auth-source-pass)

;; Fallback to ~/.authinfo if needed
(setq auth-sources '("~/.authinfo"))

(provide 'init-auth)
