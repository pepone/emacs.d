;;; init-env.el --- Environment Variables Setup -*- lexical-binding: t; -*-

;;; init-env.el --- Environment Variables Setup -*- lexical-binding: t; -*-

(when (memq window-system '(mac ns x))
  (use-package exec-path-from-shell
    :config
    (setq exec-path-from-shell-variables '("PATH" "MANPATH" "SSH_AUTH_SOCK")) ;; Optional extra vars
    (exec-path-from-shell-initialize)))

(provide 'init-env)
