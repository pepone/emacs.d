;;; init-auth.el --- Authentication and Password Management -*- lexical-binding: t; -*-

;; Set the fallback before enabling pass, which adds its own backend.
(setq auth-sources '("~/.authinfo"))

;; Use pass as auth source
(use-package auth-source-pass
  :ensure nil
  :init
  (auth-source-pass-enable))

;; Manual password management via pass
(use-package password-store
  :commands (password-store-copy password-store-insert password-store-edit))


(provide 'init-auth)
